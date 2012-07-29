//
//  ChoiceTypeInstance.h
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-18/200.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTypeInstance.h"

@interface ChoiceTypeInstance : BaseTypeInstance

@property (copy) NSString *value;
@property (retain) id instanceType;
@property (retain) NSCell *cell;

+ (id)instanceWithType:(id)type;

@end
