
//  DrawingView.m
//  Maze
//
//  Created by Edward Ishaq on 9/1/14.
//  Copyright (c) 2014 Edward Ashak. All rights reserved.
//

#import "DrawingView.h"
#import "EdgesLayerDelegate.h"

@import QuartzCore;

@interface DrawingView ()
@property CALayer *pointsLayer, *tempLineLayer, *edgesLayer;

@property EdgesLayerDelegate *edgesDelegate, *tempEdgeDelegate;

@end

@implementation DrawingView

- (void)commonInit {

    //Points
    self.pointsLayer = [CALayer layer];
    self.pointsLayer.frame = self.bounds;
    //self.pointsLayer.delegate = self;
    
    //Temp Line
    self.tempLineLayer = [CALayer layer];
    self.tempLineLayer.frame = self.bounds;
    self.tempEdgeDelegate = [EdgesLayerDelegate new];
    self.tempLineLayer.delegate = self.tempEdgeDelegate;
    
    //Graph Edges
    self.edgesLayer = [CALayer layer];
    self.edgesLayer.frame = self.bounds;
    self.edgesDelegate = [EdgesLayerDelegate new];
    self.edgesLayer.delegate = self.edgesDelegate;
    
    [self.layer addSublayer:self.pointsLayer];
    [self.layer addSublayer:self.tempLineLayer];
    [self.layer addSublayer:self.edgesLayer];

}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)drawPoint:(CGPoint)point{}

- (void)clearTempLine {
    //Remove Temp Edge
}

- (void)drawLineFromPoint:(CGPoint)start toPoint:(CGPoint)end {
    //remove temp edge
    [self.tempEdgeDelegate clearEdges];

    //Add new Edge
    MAEdge *edge = [[MAEdge alloc] initWithStart:start endPoint:end];
    [self.edgesDelegate addEdge:edge];
    
    [self setNeedsDisplay];
    [self.edgesLayer setNeedsDisplay];
    [self.tempLineLayer setNeedsDisplay];
    
}
- (void)drawTempLineFromPoint:(CGPoint)start toPoint:(CGPoint)end {
    [self.tempEdgeDelegate clearEdges];
    
    MAEdge *tmpEdge = [[MAEdge alloc] initWithStart:start endPoint:end];    
    [self.tempEdgeDelegate addEdge:tmpEdge];
    
    [self setNeedsDisplay];
    [self.tempLineLayer setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.tempEdgeDelegate drawLayer:self.tempLineLayer inContext:ctx];
    [self.edgesDelegate drawLayer:self.edgesLayer inContext:ctx];
}

- (void)clearGraph {
    [self.tempEdgeDelegate clearEdges];
    [self.edgesDelegate clearEdges];
    [self setNeedsDisplay];

}
@end
