//
//  NullTypeInstance.h
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-06/188.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeInstance.h"
#import "BaseTypeInstance.h"

@interface NullTypeInstance : BaseTypeInstance

@property (retain) id instanceType;

+ (id)instanceWithType:(id)type;

@end
