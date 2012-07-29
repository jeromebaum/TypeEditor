//
//  ListTypeInstance.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-06/188.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListTypeInstance.h"
#import "TypeType.h"

@interface ListTypeInstance ()

- (TypeType *)concreteType;

@end

@implementation ListTypeInstance

@synthesize instanceType;
@synthesize contents;

- (id)value {
    return [NSString stringWithFormat:@"(%d items)",
            [self numberOfChildren]];
}

- (id)toPlist {
    NSMutableArray *plist = [[NSMutableArray new] autorelease];
    for (id<TypeInstance> item in [self contents]) {
        [plist addObject:[item toPlist]];
    }
    return plist;
}

- (TypeType *)concreteType {
    TypeTypeInstance *metaInstance = [[self instanceType] metaInstance];
    return [metaInstance concreteType];
}

- (void)loadPlist:(id)plist {
    [self setContents:[[NSMutableArray new] autorelease]];
    TypeType *wantedType = [self concreteType];
    for (id item in plist) {
        TypeTypeInstance *instance = [wantedType instance];
        [instance loadPlist:item];
        [[self contents] addObject:instance];
    }
}

- (NSInteger)numberOfChildren {
    return [[self contents] count];
}

- (id)childAtIndex:(NSInteger)index {
    return [[self contents] objectAtIndex:index];
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
    TypeType *wantedType = [self concreteType];
    id instance = [wantedType instance];
    [instance addObserver:self
               forKeyPath:@"value"
                  options:NSKeyValueObservingOptionPrior
                  context:nil];
    [[self contents] insertObject:instance atIndex:index];
    [self didChangeValueForKey:@"value"];
}

- (void)removeChildAtIndex:(NSInteger)index {
    assert([self canRemoveChildAtIndex:index]);
    [self willChangeValueForKey:@"value"];
    id instance = [[self contents] objectAtIndex:index];
    [instance removeObserver:self
                  forKeyPath:@"value"];
    [[self contents] removeObjectAtIndex:index];
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
    return [NSString stringWithFormat:@"[%d]", index];
}

+ (id)instanceWithType:(id)type {
    ListTypeInstance *instance = [[self new] autorelease];
    [instance setInstanceType:type];
    return instance;
}

- (id)init {
    if (self = [super init]) {
        [self setInstanceType:nil];
        [self setContents:[NSMutableArray array]];
    }
    return self;
}

- (void)dealloc {
    [self setContents:nil];
    [self setInstanceType:nil];
    [super dealloc];
}

@end
