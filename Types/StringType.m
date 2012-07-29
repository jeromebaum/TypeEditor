//
//  StringType.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-06/188.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StringType.h"
#import "StringTypeInstance.h"
#import "NullType.h"

@implementation StringType

@synthesize metaInstance;

- (id)instance {
    return [StringTypeInstance instanceWithType:self];
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
