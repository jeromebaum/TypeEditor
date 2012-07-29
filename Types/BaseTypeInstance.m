//
//  TypeCompleterDelegate.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-14/196.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import "BaseTypeInstance.h"

@implementation BaseTypeInstance

- (id)instanceType {
    [NSException raise:@"Invalid call"
                format:@"This is not a real type instance"];
    return nil;
}
- (id)value {
    [NSException raise:@"Invalid call"
                format:@"This is not a real type instance"];
    return nil;
}
- (id)toPlist {
    [NSException raise:@"Invalid call"
                format:@"This is not a real type instance"];
    return nil;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", [self toPlist]];
}

- (void)loadPlist:(id)plist { }

- (NSInteger)numberOfChildren { return 0; }
- (id)childAtIndex:(NSInteger)index { return nil; }

- (BOOL)isValueEditable { return NO; }
- (void)setValue:(id)value { }
- (NSCell *)valueCell { return nil; }
- (id)cellValue {
    return [self value];
}
- (void)setCellValue:(id)value {
    [self setValue:value];
}

- (BOOL)canCreateChildAtIndex:(NSInteger)index { return NO; }
- (BOOL)canRemoveChildAtIndex:(NSInteger)index { return NO; }
- (void)createChildAtIndex:(NSInteger)index { }
- (void)removeChildAtIndex:(NSInteger)index { }

- (id)labelAtIndex:(NSInteger)index { return @""; }
- (BOOL)isLabelEditableAtIndex:(NSInteger)index { return NO; }
- (void)setLabel:(id)label atIndex:(NSInteger)index { }
- (NSCell *)labelCellAtIndex:(NSInteger)index { return nil; }
- (id)cellLabelAtIndex:(NSInteger)index {
    return [self labelAtIndex:index];
}
- (void)setCellLabel:(id)label
             atIndex:(NSInteger)index {
    [self setLabel:label atIndex:index];
}

@end
