//
//  Type.h
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-06/188.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Type <NSObject>

- (id)metaInstance;
- (id)instance;

@optional
- (void)setMetaInstance:(id)instance;

@end
