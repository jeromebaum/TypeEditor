//
//  ListTypeInstance.h
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-06/188.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListType.h"
#import "BaseTypeInstance.h"

@interface ListTypeInstance : BaseTypeInstance

@property (retain) ListType *instanceType;
@property (retain) NSMutableArray *contents;

+ (id)instanceWithType:(id)type;

@end
