//
//  Point.h
//  Maze
//
//  Created by Edward Ishaq on 8/17/14.
//  Copyright (c) 2014 Edward Ashak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAPoint : NSObject

@property UIColor *color;
@property NSString *name;
@property CGPoint center;

@property (readonly) UIView *view;

//@property
- (instancetype)initPointWithCGPoint:(CGPoint)cgPoint;

+ (UIColor*)randomColor;
@end
