//
//  ObjectType.h
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-29.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Type.h"

@interface ObjectType : NSObject <Type>

@property (retain) id metaInstance;

@end
