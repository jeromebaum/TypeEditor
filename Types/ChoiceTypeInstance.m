//
//  ChoiceTypeInstance.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-18/200.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import "ChoiceTypeInstance.h"
#import "ChoiceType.h"

@implementation ChoiceTypeInstance

@synthesize value;
@synthesize instanceType;
@synthesize cell;

- (id)toPlist {
    return [self value];
}

- (void)loadPlist:(id)plist {
    [self setValue:plist];
}

- (BOOL)isValueEditable {
    return YES;
}

- (NSCell *)valueCell {
    if ([self cell]) {
        return [self cell];
    }
    NSPopUpButtonCell *_cell = [[NSPopUpButtonCell new] autorelease];
    [_cell addItemsWithTitles:[[[self instanceType] metaInstance] toPlist]];
    [self setCell:_cell];
    return _cell;
}

- (id)cellValue {
    if (![self value]) {
        return nil;
    }
    return [NSNumber numberWithInt:[(NSPopUpButtonCell *)[self cell]
                                    indexOfItemWithTitle:[self value]]];
}

- (void)setCellValue:(id)_value {
    [self setValue:[(NSPopUpButtonCell *)[self cell]
                    itemTitleAtIndex:[_value intValue]]];
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
