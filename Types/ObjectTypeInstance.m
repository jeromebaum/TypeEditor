//
//  ObjectTypeInstance.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-29.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import "ObjectTypeInstance.h"
#import "DictionaryTypeInstance.h"
#import "TypeTypeInstance.h"

@interface ObjectTypeInstance ()

- (NSArray *)keys;
- (id<Type>)concreteTypeForKey:(NSString *)key;

@end

@implementation ObjectTypeInstance

@synthesize instanceType;
@synthesize contents;

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
        id<TypeInstance> item = [[self concreteTypeForKey:key] instance];
        [item loadPlist:[plist objectForKey:key]];
        [[self contents] setObject:item forKey:key];
    }
}

- (NSArray *)keys {
    DictionaryTypeInstance *metaInstance = [[self instanceType]
                                            metaInstance];
    return [metaInstance keys];
}

- (id<Type>)concreteTypeForKey:(NSString *)key {
    DictionaryTypeInstance *metaInstance = [[self instanceType]
                                            metaInstance];
    TypeTypeInstance *typeTypeInstance = [[metaInstance contents]
                                          objectForKey:key];
    return [typeTypeInstance concreteType];
}

- (NSInteger)numberOfChildren {
    return [[self keys] count];
}

- (id)childAtIndex:(NSInteger)index {
    NSString *key = [[self keys] objectAtIndex:index];
    id child = [[self contents] objectForKey:key];
    id type = [self concreteTypeForKey:key];
    if (!child || [child instanceType] != type) {
        [child removeObserver:self
                   forKeyPath:@"value"];
        child = [type instance];
        [child addObserver:self
                forKeyPath:@"value"
                   options:NSKeyValueObservingOptionPrior
                   context:nil];
        [[self contents] setObject:child forKey:key];
    }
    return child;
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

+ (id)instanceWithType:(id)type {
    ObjectTypeInstance *instance = [[self new] autorelease];
    [instance setInstanceType:type];
    return instance;
}

- (id)init {
    if (self = [super init]) {
        [self setInstanceType:nil];
        [self setContents:[NSMutableDictionary dictionary]];
    }
    return self;
}

- (void)dealloc {
    [self setInstanceType:nil];
    [self setContents:nil];
    [super dealloc];
}

@end
