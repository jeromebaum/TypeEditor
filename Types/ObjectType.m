//
//  ObjectType.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-29.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import "ObjectType.h"
#import "ObjectTypeInstance.h"
#import "DictionaryType.h"
#import "TypeTypeInstance.h"

@implementation ObjectType

@synthesize metaInstance;

- (id)instance {
    return [ObjectTypeInstance instanceWithType:self];
}

- (id)init {
    if (self = [super init]) {
        id type = [[DictionaryType new] autorelease];
        [[type metaInstance] setConcreteType:[[TypeType new] autorelease]];
        [self setMetaInstance:[type instance]];
    }
    return self;
}

- (void)dealloc {
    [self setMetaInstance:nil];
    [super dealloc];
}

@end
