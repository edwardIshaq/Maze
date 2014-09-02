//
//  MAEdge.m
//  Maze
//
//  Created by Edward Ishaq on 9/1/14.
//  Copyright (c) 2014 Edward Ashak. All rights reserved.
//

#import "MAEdge.h"

@implementation MAEdge
- (id)initWithStart:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    self = [super init];
    self.startPoint = startPoint;
    self.endPoint   = endPoint;
    
    return self;
}
@end
