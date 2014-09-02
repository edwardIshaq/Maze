//
//  LinesLayerDelegate.m
//  Maze
//
//  Created by Edward Ishaq on 9/1/14.
//  Copyright (c) 2014 Edward Ashak. All rights reserved.
//

#import "EdgesLayerDelegate.h"

@interface EdgesLayerDelegate ()
@property NSMutableArray *graphLines;
@end


@implementation EdgesLayerDelegate

- (id)init {
    self = [super init];
    self.graphLines = [[NSMutableArray alloc] init];
    return self;
    
}
- (void)addEdge:(MAEdge*)line {
    [self.graphLines addObject:line];
}

- (id < CAAction >)actionForLayer:(CALayer *)layer forKey:(NSString *)key {
    return nil;
}

- (void)displayLayer:(CALayer *)layer {

}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    for (MAEdge *line in self.graphLines) {
        CGContextMoveToPoint(ctx, line.startPoint.x, line.startPoint.y);
        CGContextAddLineToPoint(ctx, line.endPoint.x, line.endPoint.y);
        CGContextSetLineWidth(ctx, kEdgeWidth );
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), .5, .5, .5 , 1.0);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
    }
    CGContextStrokePath(UIGraphicsGetCurrentContext());
}
- (void)clearEdges {
    [self.graphLines removeAllObjects];
}
@end
