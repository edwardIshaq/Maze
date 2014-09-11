//
//  Point.m
//  Maze
//
//  Created by Edward Ishaq on 8/17/14.
//  Copyright (c) 2014 Edward Ashak. All rights reserved.
//

#import "MAPoint.h"
#import "Headers.h"

@interface MAPoint ()
@property UIView *cacheView;
@end

@implementation MAPoint

- (instancetype)initPointWithCGPoint:(CGPoint)cgPoint {
    self = [super init];
    if (self) {
        self.center = cgPoint;
        self.color = [MAPoint randomColor];
        self.cacheView = nil;
    }
    return self;
}


- (UIView*)view {
    if (self.cacheView) {
        return self.cacheView;
    }
    
    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPointDim, kPointDim)];
    pointView.layer.cornerRadius = pointView.frame.size.width/2;
    pointView.center = self.center;
    [pointView setBackgroundColor:[UIColor clearColor]];
    pointView.layer.cornerRadius = kPointDim/2;
    pointView.layer.borderColor = self.color.CGColor;
    pointView.layer.borderWidth = 1.;

    CALayer *cirlcleLayer = [CALayer layer];
    cirlcleLayer.backgroundColor = self.color.CGColor;
    cirlcleLayer.bounds = CGRectMake(0, 0, kPointDim/2, kPointDim/2);
    cirlcleLayer.position = CGPointMake(kPointDim/2, kPointDim/2);
    cirlcleLayer.cornerRadius = kPointDim/4.;
    
    [pointView.layer addSublayer:cirlcleLayer];
    
    self.cacheView = pointView;
    return pointView;
}

#pragma mark - Helpers

+ (UIColor*)randomColor {
    CGFloat r=0,g=0,b=0;
    r = (arc4random()%255 / 255.0);
    g = (arc4random()%255 / 255.0);
    b = (arc4random()%255 / 255.0);
    
    UIColor *randColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    return randColor;
}
- (CGFloat)distanceFromPosition:(CGPoint)point {
    CGFloat distance = hypotf(self.center.x - point.x, self.center.y - point.y);;
    return distance;
}
@end
