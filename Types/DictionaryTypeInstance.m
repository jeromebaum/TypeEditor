//
//  DictionaryTypeInstance.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-18/200.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import "DictionaryTypeInstance.h"
#import "TypeType.h"
#import "TypeTypeInstance.h"

@interface DictionaryTypeInstance ()

- (id<Type>)concreteType;

@end

@implementation DictionaryTypeInstance

@synthesize instanceType;
@synthesize contents;
@synthesize keys;

- (id)value {
    return [NSString stringWithFormat:@"(%d items)",
            [self numberOfChildren]];
}

- (id)toPlist {
    NSMutableDictionary *plist = [[NSMutableDictionary new] autorelease];
    for (NSString *key in [self keys]) {
        id<TypeInstance> item = [[self contents] objectForKey:key];
        [plist setObject:[item toPlist] forKey:key];
    }
    return plist;
}

- (void)loadPlist:(id)plist {
    for (NSString *key in [plist keys]) {
        id<TypeInstance> item = [[self concreteType] instance];
        [item loadPlist:[plist objectForKey:key]];
        [[self contents] setObject:item forKey:key];
        [[self keys] addObject:key];
    }
}

- (id<Type>)concreteType {
    TypeTypeInstance *metaInstance = [[self instanceType] metaInstance];
    return [metaInstance concreteType];
}

- (NSInteger)numberOfChildren {
    return [[self keys] count];
}

- (id)childAtIndex:(NSInteger)index {
    NSString *key = [[self keys] objectAtIndex:index];
    return [[self contents] objectForKey:key];
}

- (BOOL)canCreateChildAtIndex:(NSInteger)index {
    return index >= 0 && index <= [[self contents] count];
}

- (BOOL)canRemoveChildAtIndex:(NSInteger)index {
    return index >= 0 && index < [[self contents] count];
}

- (void)createChildAtIndex:(NSInteger)index {
    assert([self canCreateChildAtIndex:index]);
    [self willChangeValueForKey:@"value"];
    NSInteger tryIndex = index;
    NSString *key = [NSString stringWithFormat:@"[%d]", index];
    while ([[self keys] containsObject:key]) {
        tryIndex += 1;
        key = [NSString stringWithFormat:@"[%d]", tryIndex];
    }
    TypeType *wantedType = [self concreteType];
    id instance = [wantedType instance];
    [instance addObserver:self
               forKeyPath:@"value"
                  options:NSKeyValueObservingOptionPrior
                  context:nil];
    [[self keys] insertObject:key atIndex:index];
    [[self contents] setObject:instance forKey:key];
    [self didChangeValueForKey:@"value"];
}

- (void)removeChildAtIndex:(NSInteger)index {
    assert([self canRemoveChildAtIndex:index]);
    [self willChangeValueForKey:@"value"];
    NSString *key = [[self keys] objectAtIndex:index];
    id instance = [[self contents] objectForKey:key];
    [instance removeObserver:self
                  forKeyPath:@"value"];
    [[self keys] removeObjectAtIndex:index];
    [[self contents] removeObjectForKey:key];
    [self didChangeValueForKey:@"value"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([change objectForKey:NSKeyValueChangeNotificationIsPriorKey]) {
        [self willChangeValueForKey:@"value"];
    } else {
        [self didChangeValueForKey:@"value"];
    }
}

- (id)labelAtIndex:(NSInteger)index {
    return [[self keys] objectAtIndex:index];
}

- (BOOL)isLabelEditableAtIndex:(NSInteger)index {
    return YES;
}

- (void)setLabel:(id)label atIndex:(NSInteger)index {
    [self willChangeValueForKey:@"value"];
    NSString *oldkey = [[self keys] objectAtIndex:index];
    if ([[self keys] containsObject:label]) {
        return;
    }
    id instance = [[self contents] objectForKey:oldkey];
    [[self keys] replaceObjectAtIndex:index withObject:label];
    [[self contents] removeObjectForKey:oldkey];
    [[self contents] setObject:instance forKey:label];
    [self didChangeValueForKey:@"value"];
}

+ (id)instanceWithType:(id)type {
    DictionaryTypeInstance *instance = [[self new] autorelease];
    [instance setInstanceType:type];
    return instance;
}

- (id)init {
    if (self = [super init]) {
        [self setInstanceType:nil];
        [self setContents:[NSMutableDictionary dictionary]];
        [self setKeys:[NSMutableArray array]];
    }
    return self;
}

- (void)dealloc {
    [self setInstanceType:nil];
    [self setContents:nil];
    [self setKeys:nil];
    [super dealloc];
}

@end
