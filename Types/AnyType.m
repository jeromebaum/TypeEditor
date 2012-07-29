//
//  AnyType.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-18/200.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import "AnyType.h"
#import "AnyTypeInstance.h"
#import "NullType.h"

@implementation AnyType

@synthesize metaInstance;

- (id)instance {
    return [AnyTypeInstance instanceWithType:self];
}

- (id)init {
    if (self = [super init]) {
        [self setMetaInstance:[[[NullType new] autorelease] instance]];
    }
    return self;
}

- (void)dealloc {
    [self setMetaInstance:nil];
    [super dealloc];
}

@end
