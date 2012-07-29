//
//  TypeTypeInstance.h
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-14/196.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeInstance.h"
#import "TypeType.h"
#import "Type.h"
#import "BaseTypeInstance.h"

@interface TypeTypeInstance : BaseTypeInstance

@property (retain) TypeType *instanceType;
@property (retain) id<Type> concreteType;
@property (retain) NSCell *cell;

+ (id)instanceWithType:(id)type;

@end
