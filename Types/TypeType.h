//
//  TypeType.h
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-06/188.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Type.h"
#import "TypeRegistry.h"

@interface TypeType : NSObject <Type>

@property (retain) TypeRegistry *registry;
@property (retain) id metaInstance;

@end
