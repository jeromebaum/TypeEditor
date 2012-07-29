//
//  Document.m
//  TypeEditor
//
//  Created by Jerome Baum on 2012-07-29.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import "Document.h"
#import "TypeRegistry.h"
#import "TypeTypeInstance.h"

#import "NullType.h"
#import "StringType.h"
#import "ListType.h"
#import "TypeType.h"
#import "AnyType.h"
#import "ChoiceType.h"
#import "DictionaryType.h"
#import "ObjectType.h"

@implementation Document

@synthesize dataSource;
@synthesize outlineView;

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    

    TypeRegistry *registry = [TypeRegistry defaultRegistry];
    [registry registerType:[[NullType new] autorelease]];
    [registry registerType:[[StringType new] autorelease]];
    [registry registerType:[[ListType new] autorelease]];
    [registry registerType:[[TypeType new] autorelease]];
    [registry registerType:[[AnyType new] autorelease]];
    [registry registerType:[[ChoiceType new] autorelease]];
    [registry registerType:[[DictionaryType new] autorelease]];
    [registry registerType:[[ObjectType new] autorelease]];
    
    id root = [[registry mapNameToType:@"AnyType"] instance];
    
    [[self dataSource] setRootItem:root];
    [[self dataSource] set_outlineView:[self outlineView]];
    [[self outlineView] setDataSource:[self dataSource]];
    [[self outlineView] setDelegate:[self dataSource]];
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

@end
