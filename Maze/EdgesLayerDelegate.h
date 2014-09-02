//
//  LinesLayerDelegate.h
//  Maze
//
//  Created by Edward Ishaq on 9/1/14.
//  Copyright (c) 2014 Edward Ashak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Headers.h"

@interface EdgesLayerDelegate : NSObject

@property (readonly) NSArray *lines;
- (void)addLine:(MAEdge*)line;
@end
