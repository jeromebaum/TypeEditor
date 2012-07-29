//
//  DictionaryTypeInstance.h
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-18/200.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DictionaryType.h"
#import "BaseTypeInstance.h"

@interface DictionaryTypeInstance : BaseTypeInstance

@property (retain) DictionaryType *instanceType;
@property (retain) NSMutableDictionary *contents;
@property (retain) NSMutableArray *keys;

+ (id)instanceWithType:(id)type;

@end
