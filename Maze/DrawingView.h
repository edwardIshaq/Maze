//
//  DrawingView.h
//  Maze
//
//  Created by Edward Ishaq on 9/1/14.
//  Copyright (c) 2014 Edward Ashak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingView : UIView
@property (assign) CGPoint startPoint, endPoint;

- (void)drawPoint:(CGPoint)point;
- (void)drawTempLineFromPoint:(CGPoint)start toPoint:(CGPoint)end;
@end
