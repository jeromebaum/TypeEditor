//
//  ChoiceType.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-18/200.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import "ChoiceType.h"
#import "ChoiceTypeInstance.h"
#import "ListType.h"
#import "StringType.h"
#import "TypeType.h"
#import "TypeTypeInstance.h"

/*
 
 Maybe base this on DictionaryType instead of ListType? That way we can
 choose not only from strings but from other objects as well, with a string
 as the selection label.
 
 */

@implementation ChoiceType

@synthesize metaInstance;

- (id)instance {
    return [ChoiceTypeInstance instanceWithType:self];
}

- (id)metaType {
    id type = [[ListType new] autorelease];
    id contentType = [[StringType new] autorelease];
    id contentTypeType = [[[TypeType new] autorelease] instance];
    [contentTypeType setConcreteType:contentType];
    [type setMetaInstance:contentTypeType];
    return type;
}

- (id)init {
    if (self = [super init]) {
        [self setMetaInstance:[[self metaType] instance]];
    }
    return self;
}

- (void)dealloc {
    [self setMetaInstance:nil];
    [super dealloc];
}

@end
