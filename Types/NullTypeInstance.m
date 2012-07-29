//
//  NullTypeInstance.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-06/188.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NullTypeInstance.h"

@implementation NullTypeInstance

@synthesize instanceType;

- (id)toPlist {
    return [NSDictionary dictionary];
}

- (id)value {
    return @"(none)";
}

+ (id)instanceWithType:(id)type {
    id instance = [[self new] autorelease];
    [instance setInstanceType:type];
    return instance;
}

- (id)init {
    if (self = [super init]) {
        [self setInstanceType:nil];
    }
    return self;
}

- (void)dealloc {
    [self setInstanceType:nil];
    [super dealloc];
}

@end
