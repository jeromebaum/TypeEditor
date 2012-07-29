//
//  AnyTypeInstance.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-18/200.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import "AnyTypeInstance.h"
#import "TypeType.h"
#import "TypeTypeInstance.h"

@implementation AnyTypeInstance

@synthesize instanceType;
@synthesize typeType;
@synthesize typeInstance;

- (id)value {
    return @"";
}

- (id)toPlist {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [[self typeType] toPlist],
            @"typeType",
            [[self typeInstance] toPlist],
            @"typeInstance",
            nil];
}

- (void)loadPlist:(id)plist {
    [[self typeType] loadPlist:[plist objectForKey:@"typeType"]];
    [[self typeInstance] loadPlist:[plist objectForKey:@"typeInstance"]];
}

- (NSInteger)numberOfChildren {
    return 2;  // TypeType and TypeInstance
}

- (id)childAtIndex:(NSInteger)index {
    if (index == 0) {
        return typeType;
    }
    if (index == 1) {
        return typeInstance;
    }
    return nil;
}

- (id)labelAtIndex:(NSInteger)index {
    if (index == 0) {
        return @"type";
    }
    if (index == 1) {
        return @"instance";
    }
    return nil;
}

- (id)init {
    if (self = [super init]) {
        [self setInstanceType:nil];
        [self setTypeType:[[[TypeType new] autorelease] instance]];
        [self setTypeInstance:nil];
        [self registerObserver];
        [self observe];
    }
    return self;
}

- (void)registerObserver {
    [[self typeType] addObserver:self
                      forKeyPath:@"value"
                         options:0
                         context:nil];
}

- (void)deregisterObserver {
    [[self typeType] removeObserver:self
                         forKeyPath:@"value"];
}

- (void)observe {
    id type = [[self typeType] concreteType];
    [self setTypeInstance:[type instance]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    [self observe];
}

- (void)dealloc {
    [self setInstanceType:nil];
    [self setTypeType:nil];
    [self setTypeInstance:nil];
    [self deregisterObserver];
    [super dealloc];
}

+ (id)instanceWithType:(id)type {
    id instance = [[self new] autorelease];
    [instance setInstanceType:type];
    return instance;
}

+ (NSSet *)keyPathsForValuesAffectingValue
{
    return [NSSet setWithObjects:@"typeType", @"typeInstance", nil];
}

@end
