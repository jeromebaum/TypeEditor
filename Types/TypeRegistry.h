//
//  TypeRegistry.h
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-14/196.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @abstract Stores available Types
 *
 * The TypeRegistry stores available types. There can be multiple
 * type registries (but that doesn't really make sense).
 */
@interface TypeRegistry : NSObject

/**
 * Get the mapping of names to types.
 *
 * @return NSDictionary with keys of NSString and values of Type.
 */
- (NSDictionary *)mapNamesToTypes;

/**
 * Map a single name to its registered type.
 *
 * @param name Name to map.
 *
 * @return Type instance registered under that name.
 */
- (id)mapNameToType:(NSString *)name;

/**
 * Map the given type to its name.
 *
 * @param type Instance of Type to map.
 *
 * @return Name that the type is registered under.
 */
- (NSString *)mapTypeToName:(id)type;

/**
 * Register the given type under its default name (the name of the class).
 *
 * @param type Instance of Type to register. Type parameters are ignored.
 */
- (void)registerType:(id)type;

/**
 * Override the name to register a type under. Note that a type can only
 * be registered under a single name.
 *
 * @param name Name to register the type under.
 * @param type Instance of Type to register. Type parameters are ignored.
 */
- (void)setName:(NSString *)name forType:(id)type;

/**
 * Get the default registry.
 */
+ (id)defaultRegistry;

@end
