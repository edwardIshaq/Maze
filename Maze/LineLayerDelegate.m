//
//  LineLayerDelegate.m
//  Maze
//
//  Created by Edward Ishaq on 9/1/14.
//  Copyright (c) 2014 Edward Ashak. All rights reserved.
//

#import "LineLayerDelegate.h"

@implementation LineLayerDelegate
- (id < CAAction >)actionForLayer:(CALayer *)layer forKey:(NSString *)key {
    return nil;
}

- (void)displayLayer:(CALayer *)layer {
    //[super displayLayer:layer];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{   
    CGContextMoveToPoint(ctx, self.startPoint.x, self.startPoint.y);
    CGContextAddLineToPoint(ctx, self.endPoint.x, self.endPoint.y);
    CGContextSetLineWidth(ctx, kEdgeWidth );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), .5, .5, .5 , 1.0);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
}
@end
