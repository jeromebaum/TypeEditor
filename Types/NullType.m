//
//  NullType.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-06/188.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NullType.h"
#import "NullTypeInstance.h"

@implementation NullType

@synthesize metaInstance;

- (id)instance {
    return [NullTypeInstance instanceWithType:self];
}

- (id)init {
    if (self = [super init]) {
        [self setMetaInstance:[NullTypeInstance instanceWithType:self]];
    }
    return self;
}

@end
