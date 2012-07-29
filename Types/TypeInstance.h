//
//  TypeInstance.h
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-06/188.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TypeInstance <NSObject>

- (id)instanceType;
- (id)value;

- (id)toPlist;
- (void)loadPlist:(id)plist;

- (NSInteger)numberOfChildren;
- (id)childAtIndex:(NSInteger)index;

- (BOOL)isValueEditable;
- (void)setValue:(id)value;
- (NSCell *)valueCell;
- (id)cellValue;
- (void)setCellValue:(id)value;

- (BOOL)canCreateChildAtIndex:(NSInteger)index;
- (BOOL)canRemoveChildAtIndex:(NSInteger)index;
- (void)createChildAtIndex:(NSInteger)index;
- (void)removeChildAtIndex:(NSInteger)index;

- (id)labelAtIndex:(NSInteger)index;
- (BOOL)isLabelEditableAtIndex:(NSInteger)index;
- (void)setLabel:(id)label atIndex:(NSInteger)index;
- (NSCell *)labelCellAtIndex:(NSInteger)index;
- (id)cellLabelAtIndex:(NSInteger)index;
- (void)setCellLabel:(id)label atIndex:(NSInteger)index;

@end
