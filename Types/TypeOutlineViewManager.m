//
//  TypeOutlineViewDataSource.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-15/197.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import "TypeOutlineViewManager.h"
#import "BaseTypeInstance.h"

@implementation TypeOutlineViewManager

@synthesize _outlineView;
@synthesize rootItem;
@synthesize parentChildToIndex;

- (id)outlineView:(NSOutlineView *)outlineView
            child:(NSInteger)index
           ofItem:(id)item {
    if (!item) {
        return [self rootItem];  // root item has top-level as child
    }
    id child = [item childAtIndex:index];
    [[self parentChildToIndex] setObject:[NSNumber numberWithInt:index]
                                  forKey:child];
    return child;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView
   isItemExpandable:(id)item {
    return [item numberOfChildren] > 0;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView
  numberOfChildrenOfItem:(id)item {
    if (!item) {
        return 1;  // root item has 1 child (the top-level)
    }
    NSInteger count = [item numberOfChildren];
    return count;
}

- (int)parentIndex:(id)item outlineView:(id)outlineView {
    return [[[self parentChildToIndex] objectForKey:item] intValue];
}

- (id)outlineView:(NSOutlineView *)outlineView
objectValueForTableColumn:(NSTableColumn *)tableColumn
           byItem:(id)item {
    if ([[tableColumn identifier] isEqual:@"type"]) {
        return [[item instanceType] className];
    }
    if ([[tableColumn identifier] isEqual:@"label"]) {
        id parent = [outlineView parentForItem:item];
        int relativeIndex = [self parentIndex:item
                                  outlineView:outlineView];
        return [parent cellLabelAtIndex:relativeIndex];
    }
    if ([[tableColumn identifier] isEqual:@"value"]) {
        return [item cellValue];
    }
    return @"(unknown)";
}

- (void)outlineView:(NSOutlineView *)outlineView
     setObjectValue:(id)object
     forTableColumn:(NSTableColumn *)tableColumn
             byItem:(id)item {
    if ([[tableColumn identifier] isEqual:@"label"]) {
        id parent = [outlineView parentForItem:item];
        int relativeIndex = [self parentIndex:item
                                  outlineView:outlineView];
        [parent setCellLabel:object atIndex:relativeIndex];
    }
    if ([[tableColumn identifier] isEqual:@"value"]) {
        [item setCellValue:object];
    }
    [outlineView reloadItem:nil reloadChildren:YES];
}

- (NSCell *)outlineView:(NSOutlineView *)outlineView
 dataCellForTableColumn:(NSTableColumn *)tableColumn
                   item:(id)item {
    if (!tableColumn) {
        return nil;  // no group cells
    }
    NSCell *defaultCell = [tableColumn
                           dataCellForRow:[outlineView rowForItem:item]];
    [defaultCell setEditable:NO];
    NSCell *cell = defaultCell;
    if ([[tableColumn identifier] isEqual:@"label"]) {
        id parent = [outlineView parentForItem:item];
        int relativeIndex = [self parentIndex:item
                                  outlineView:outlineView];
        cell = [parent labelCellAtIndex:relativeIndex];
        if (!cell) {
            cell = defaultCell;
        }
        [cell setEditable:[parent isLabelEditableAtIndex:relativeIndex]];
    }
    if ([[tableColumn identifier] isEqual:@"value"]) {
        cell = [item valueCell];
        if (!cell) {
            cell = defaultCell;
        }
        [cell setEditable:[item isValueEditable]];
    }
    return cell;
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    id item = [[self _outlineView]
               itemAtRow:[[self _outlineView] clickedRow]];
    id parent = [[self _outlineView] parentForItem:item];
    NSInteger index = [self parentIndex:item
                            outlineView:[self _outlineView]];
    if (!parent) {  // a parent is like its first child
        parent = item;
        item = nil;
        index = 0;
    }
    return ((item && (([menuItem action] == @selector(addAbove:) &&
                       [parent canCreateChildAtIndex:index]) ||
                      ([menuItem action] == @selector(addBelow:) &&
                       [parent canCreateChildAtIndex:index+1]) ||
                      ([menuItem action] == @selector(addLower:) &&
                       [item canCreateChildAtIndex:0]) ||
                      ([menuItem action] == @selector(removeChild:) &&
                       [parent canRemoveChildAtIndex:index]))) ||
            (!item && ([menuItem action] == @selector(addBelow:) &&
                       [parent canCreateChildAtIndex:index])));
}

- (void)addAbove:(id)sender {
    id item = [[self _outlineView]
               itemAtRow:[[self _outlineView] clickedRow]];
    id parent = [[self _outlineView] parentForItem:item];
    NSInteger index = [self parentIndex:item
                            outlineView:[self _outlineView]];
    if (!parent) {  // a parent is like its first child
        parent = item;
        item = nil;
        index = 0;
    }
    if ([parent canCreateChildAtIndex:index]) {
        [parent createChildAtIndex:index];
    }
    [[self _outlineView] reloadItem:nil reloadChildren:YES];
}

- (void)addLower:(id)sender {
    id item = [[self _outlineView]
               itemAtRow:[[self _outlineView] clickedRow]];
    if ([item canCreateChildAtIndex:0]) {
        [item createChildAtIndex:0];
    }
    [[self _outlineView] reloadItem:nil reloadChildren:YES];
}

- (void)removeChild:(id)sender {
    id item = [[self _outlineView]
               itemAtRow:[[self _outlineView] clickedRow]];
    id parent = [[self _outlineView] parentForItem:item];
    NSInteger index = [self parentIndex:item
                            outlineView:[self _outlineView]];
    if (!parent) {  // a parent is like its first child
        parent = item;
        item = nil;
        index = 0;
    }
    if ([parent canRemoveChildAtIndex:index]) {
        [parent removeChildAtIndex:index];
    }
    [[self _outlineView] reloadItem:nil reloadChildren:YES];
}

- (void)addBelow:(id)sender {
    id item = [[self _outlineView]
               itemAtRow:[[self _outlineView] clickedRow]];
    id parent = [[self _outlineView] parentForItem:item];
    NSInteger index = [self parentIndex:item
                            outlineView:[self _outlineView]];
    if (!parent) {  // a parent is like its first child
        parent = item;
        item = nil;
        index = 0;
    }
    if ([parent canCreateChildAtIndex:index+1]) {
        [parent createChildAtIndex:index+1];
    }
    [[self _outlineView] reloadItem:nil reloadChildren:YES];
}

- (id)init {
    if (self = [super init]) {
        [self setRootItem:nil];
        [self setParentChildToIndex:
         [NSMapTable mapTableWithStrongToStrongObjects]];
    }
    return self;
}

- (void)dealloc {
    [self setRootItem:nil];
    [self setParentChildToIndex:nil];
    [super dealloc];
}

@end
