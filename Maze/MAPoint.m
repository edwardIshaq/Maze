//
//  Point.m
//  Maze
//
//  Created by Edward Ishaq on 8/17/14.
//  Copyright (c) 2014 Edward Ashak. All rights reserved.
//

#import "MAPoint.h"

const CGFloat pointDim = 30.0;

@implementation MAPoint

- (instancetype)initPointWithCGPoint:(CGPoint)cgPoint {
    self = [super init];
    if (self) {
        self.center = cgPoint;
        self.color = [MAPoint randomColor];

    }
    return self;
}

+ (UIColor*)randomColor {
    CGFloat r=0,g=0,b=0;
    r = (arc4random()%255 / 255.0);
    g = (arc4random()%255 / 255.0);
    b = (arc4random()%255 / 255.0);
    
    UIColor *randColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    return randColor;
}

- (UIView*)view {
    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pointDim, pointDim)];
    pointView.layer.cornerRadius = pointView.frame.size.width/2;
    pointView.center = self.center;
    [pointView setBackgroundColor:self.color];

    return pointView;
}
@end
