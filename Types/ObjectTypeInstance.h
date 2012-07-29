//
//  ObjectTypeInstance.h
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-29.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectType.h"
#import "BaseTypeInstance.h"

@interface ObjectTypeInstance : BaseTypeInstance

@property (retain) ObjectType *instanceType;
@property (retain) NSMutableDictionary *contents;

+ (id)instanceWithType:(id)type;

@end
