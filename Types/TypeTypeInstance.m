//
//  TypeTypeInstance.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-14/196.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TypeTypeInstance.h"
#import "TypeType.h"
#import "TypeInstance.h"
#import "NullType.h"

@interface TypeTypeInstance ()

- (id)niceMetaInstance;

@end

@implementation TypeTypeInstance

@synthesize instanceType;
@synthesize concreteType;
@synthesize cell;

- (id)value {
    return [[[self instanceType] registry]
            mapTypeToName:[self concreteType]];
}

- (id)toPlist {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [self value],
            @"typeName",
            [[self niceMetaInstance] toPlist],
            @"typeParameters",
            nil];
}

- (void)loadPlist:(id)plist {
    [self setValue:[plist objectForKey:@"typeName"]];
    if ([[self value] respondsToSelector:@selector(setMetaInstance:)]) {
        id metaType = [[self niceMetaInstance] instanceType];
        id metaInstance = [metaType instance];
        [metaInstance loadPlist:[plist objectForKey:@"typeParameters"]];
        [[self value] setMetaInstance:metaInstance];
    }
}

- (NSInteger)numberOfChildren {
    return 1;  // Always a single child: an editor for the selected type.
}

- (id)childAtIndex:(NSInteger)index {
    if (index != 0) {
        return nil;
    }
    return [[self concreteType] metaInstance];
}

- (BOOL)isValueEditable {
    return YES;
}

- (void)setValue:(id)value {
    id type = [[[self instanceType] registry] mapNameToType:value];
    [self setConcreteType:type];
}

- (NSCell *)valueCell {
    if ([self cell]) {
        return [self cell];
    }
    NSPopUpButtonCell *_cell = [[NSPopUpButtonCell new] autorelease];
    [_cell addItemsWithTitles:[[[[self instanceType] registry]
                               mapNamesToTypes] allKeys]];
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

- (void)setCellValue:(id)value {
    [self setValue:[(NSPopUpButtonCell *)[self cell]
                    itemTitleAtIndex:[value intValue]]];
}

- (id)labelAtIndex:(NSInteger)index {
    if (index != 0) {
        return nil;
    }
    return @"type information";
}

+ (id)instanceWithType:(id)type {
    TypeTypeInstance *instance = [[self new] autorelease];
    [instance setInstanceType:type];
    return instance;
}

- (id)niceMetaInstance {
    return [[self concreteType] metaInstance];
}

- (id)init {
    if (self = [super init]) {
        [self setInstanceType:nil];
        [self setConcreteType:[[NullType new] autorelease]];
        [self setCell:nil];
    }
    return self;
}

- (void)dealloc {
    [self setInstanceType:nil];
    [self setConcreteType:nil];
    [self setCell:nil];
    [super dealloc];
}

+ (NSSet *)keyPathsForValuesAffectingValue
{
    return [NSSet setWithObjects:
            @"concreteType",
            @"concreteType.metaInstance",
            @"concreteType.metaInstance.value",
            nil];
}

@end
