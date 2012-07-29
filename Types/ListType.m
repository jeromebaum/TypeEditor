//
//  ListType.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-06/188.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListType.h"
#import "ListTypeInstance.h"
#import "TypeTypeInstance.h"

@implementation ListType

@synthesize metaInstance;

- (id)instance {
    return [ListTypeInstance instanceWithType:self];
}

- (id)init {
    if (self = [super init]) {
        [self setMetaInstance:[[[TypeType new] autorelease] instance]];
    }
    return self;
}

- (void)dealloc {
    [self setMetaInstance:nil];
    [super dealloc];
}

@end
