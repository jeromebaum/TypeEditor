//
//  AnyTypeInstance.h
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-18/200.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTypeInstance.h"

@interface AnyTypeInstance : BaseTypeInstance

@property (retain) id instanceType;
@property (retain) id typeType;
@property (retain) id typeInstance;

+ (id)instanceWithType:(id)type;

@end
