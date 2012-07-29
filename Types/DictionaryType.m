//
//  DictionaryType.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-18/200.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import "DictionaryType.h"
#import "DictionaryTypeInstance.h"
#import "TypeTypeInstance.h"

@implementation DictionaryType

@synthesize metaInstance;

- (id)instance {
    return [DictionaryTypeInstance instanceWithType:self];
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
