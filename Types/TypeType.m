//
//  TypeType.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-06/188.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TypeType.h"
#import "TypeTypeInstance.h"
#import "NullType.h"

@implementation TypeType

@synthesize registry;
@synthesize metaInstance;

- (id)instance {
    return [TypeTypeInstance instanceWithType:self];
}

- (id)init {
    if (self = [super init]) {
        [self setRegistry:[TypeRegistry defaultRegistry]];
        [self setMetaInstance:[[[NullType new] autorelease] instance]];
    }
    return self;
}

- (void)dealloc {
    [self setRegistry:nil];
    [self setMetaInstance:nil];
    [super dealloc];
}

@end
