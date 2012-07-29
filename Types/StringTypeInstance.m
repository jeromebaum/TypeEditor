//
//  StringTypeInstance.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-06/188.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StringTypeInstance.h"

@implementation StringTypeInstance

@synthesize value;
@synthesize instanceType;

- (id)toPlist {
    return [self value];
}

- (void)loadPlist:(id)plist {
    [self setValue:plist];
}

- (BOOL)isValueEditable {
    return YES;
}

- (id)init {
    if (self = [super init]) {
        [self setInstanceType:nil];
        [self setValue:@""];
    }
    return self;
}

- (void)dealloc {
    [self setInstanceType:nil];
    [self setValue:nil];
    [super dealloc];
}

+ (id)instanceWithType:(id)type {
    id instance = [[self new] autorelease];
    [instance setInstanceType:type];
    return instance;
}

@end
