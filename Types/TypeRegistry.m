//
//  TypeRegistry.m
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-14/196.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TypeRegistry.h"

@interface TypeRegistry ()

@property (retain) NSMutableDictionary *namesToTypes;
@property (retain) NSMutableDictionary *classToRegistryNames;

@end

@implementation TypeRegistry

@synthesize namesToTypes;
@synthesize classToRegistryNames;

- (NSDictionary *)mapNamesToTypes {
    return [NSDictionary dictionaryWithDictionary:[self namesToTypes]];
}

- (id)mapNameToType:(NSString *)name {
    id type = [[self mapNamesToTypes] objectForKey:name];
    return [[[type class] new] autorelease];
}

- (NSString *)mapTypeToName:(id)type {
    NSString *className = [[type class] description];
    NSString *registryName = [[self classToRegistryNames]
                              objectForKey:className];
    return registryName;
}

- (void)registerType:(id)type {
    NSString *className = [[type class] description];
    [self setName:className forType:type];
}

- (void)setName:(NSString *)name forType:(id)type {
    NSString *className = [[type class] description];
    [[self namesToTypes] setObject:type forKey:name];
    [[self classToRegistryNames] setObject:name forKey:className];
}

+ (id)defaultRegistry {
    static TypeRegistry *registry;
    if (!registry) {
        registry = [self new];
    }
    return registry;
}

- (id)init {
    if (self = [super init]) {
        [self setNamesToTypes:
         [[NSMutableDictionary new] autorelease]];
        [self setClassToRegistryNames:
         [[NSMutableDictionary new] autorelease]];
    }
    return self;
}

- (void)dealloc {
    [self setNamesToTypes:nil];
    [self setClassToRegistryNames:nil];
    [super dealloc];
}

@end
