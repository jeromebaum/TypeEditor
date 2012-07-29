//
//  Document.m
//  TypeEditor
//
//  Created by Jerome Baum on 2012-07-29.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@synthesize rootInstance;
@synthesize registry;
@synthesize dataSource;
@synthesize outlineView;

- (id)init
{
    self = [super init];
    if (self) {
        TypeRegistry *reg = [TypeRegistry defaultRegistry];
        [reg registerType:[[NullType new] autorelease]];
        [reg registerType:[[StringType new] autorelease]];
        [reg registerType:[[ListType new] autorelease]];
        [reg registerType:[[TypeType new] autorelease]];
        [reg registerType:[[AnyType new] autorelease]];
        [reg registerType:[[ChoiceType new] autorelease]];
        [reg registerType:[[DictionaryType new] autorelease]];
        [reg registerType:[[ObjectType new] autorelease]];
        [self setRegistry:reg];
    }
    return self;
}

- (void)dealloc {
    [self setRootInstance:nil];
    [self setRegistry:nil];
    [super dealloc];
}

- (NSString *)windowNibName
{
    return @"Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    
    if (![self rootInstance]) {
        id root = [[[self registry] mapNameToType:@"AnyType"] instance];
        [self setRootInstance:root];
    }
    
    [[self dataSource] setRootItem:[self rootInstance]];
    
    [[self dataSource] setDocument:self];
    [[self dataSource] set_outlineView:[self outlineView]];
    [[self outlineView] setDataSource:[self dataSource]];
    [[self outlineView] setDelegate:[self dataSource]];
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName
                 error:(NSError **)outError
{
    id plist = [[[self dataSource] rootItem] toPlist];
    id *error; error = NULL;
    NSData *data = [NSPropertyListSerialization dataFromPropertyList:plist
                                        format:NSPropertyListXMLFormat_v1_0
                                                    errorDescription:error];
    if (error) {
        id dict = [NSDictionary dictionaryWithObjectsAndKeys:
                   *error,
                   NSLocalizedDescriptionKey,
                   nil];
        id error = [NSError errorWithDomain:@"Cocoa"
                                       code:NSFileWriteUnknownError
                                   userInfo:dict];
        outError = &error;
        return nil;
    }
    return data;
}

- (BOOL)readFromData:(NSData *)data
              ofType:(NSString *)typeName
               error:(NSError **)outError
{
    id *error; error = NULL;
    NSPropertyListFormat *format; format = NULL;
    id plist = [NSPropertyListSerialization propertyListFromData:data
                                                mutabilityOption:0
                                                          format:format
                                                errorDescription:error];
    if (error) {
        id dict = [NSDictionary dictionaryWithObjectsAndKeys:
                   *error,
                   NSLocalizedDescriptionKey,
                   nil];
        id error = [NSError errorWithDomain:@"Cocoa"
                                       code:NSFileReadUnknownError
                                   userInfo:dict];
        outError = &error;
        return NO;
    }
    id root = [[[self registry] mapNameToType:@"AnyType"] instance];
    [root loadPlist:plist];
    [self setRootInstance:root];
    return YES;
}

@end
