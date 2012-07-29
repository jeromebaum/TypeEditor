//
//  TypeOutlineViewDataSource.h
//  TypedPrototype
//
//  Created by Jerome Baum on 2012-07-15/197.
//  Copyright (c) 2012 Jerome Baum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeOutlineViewManager : NSObject <NSOutlineViewDataSource, NSOutlineViewDelegate, NSMenuDelegate>

@property (assign) NSOutlineView *_outlineView;
@property (assign) NSDocument *document;
@property (retain) id rootItem;
@property (retain) NSMapTable *parentChildToIndex;

- (IBAction)addAbove:(id)sender;
- (IBAction)addLower:(id)sender;
- (IBAction)removeChild:(id)sender;
- (IBAction)addBelow:(id)sender;

@end
