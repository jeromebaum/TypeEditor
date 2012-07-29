//
//  ListType.h
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-06/188.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Type.h"
@class TypeTypeInstance;

@interface ListType : NSObject <Type>

@property (retain) TypeTypeInstance *metaInstance;

@end
