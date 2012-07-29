//
//  Document.h
//  TypeEditor
//
//  Created by Jerome Baum on 2012-07-29.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TypeOutlineViewManager.h"

@interface Document : NSDocument

@property (assign) IBOutlet TypeOutlineViewManager *dataSource;
@property (assign) IBOutlet NSOutlineView *outlineView;

@end
