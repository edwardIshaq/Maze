
//  DrawingView.m
//  Maze
//
//  Created by Edward Ishaq on 9/1/14.
//  Copyright (c) 2014 Edward Ashak. All rights reserved.
//

#import "DrawingView.h"
#import "LineLayerDelegate.h"
#import "EdgesLayerDelegate.h"

@import QuartzCore;

@interface DrawingView ()
@property CALayer *pointsLayer;
@property CALayer *tempLineLayer;
@property CALayer *edgesLayer;

@property LineLayerDelegate *tempLineDelegate;
@property EdgesLayerDelegate *edgesDelegate;

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
    self.tempLineDelegate = [LineLayerDelegate new];
    self.tempLineLayer.delegate = self.tempLineDelegate;
    
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

- (void)drawLineFromPoint:(CGPoint)start toPoint:(CGPoint)end {
    //Add new Edge
    MAEdge *edge = [[MAEdge alloc] init];
    edge.startPoint = start;
    edge.endPoint = end;
    [self.edgesDelegate addLine:edge];
    
    //Remove Temp Edge
    self.tempLineDelegate.startPoint = CGPointZero;
    self.tempLineDelegate.endPoint   = CGPointZero;

    
    [self setNeedsDisplay];
    [self.edgesLayer setNeedsDisplay];
    [self.tempLineLayer setNeedsDisplay];
    
}
- (void)drawTempLineFromPoint:(CGPoint)start toPoint:(CGPoint)end {
    
    self.tempLineDelegate.startPoint = start;
    self.tempLineDelegate.endPoint   = end;
    
    [self setNeedsDisplay];
    [self.tempLineLayer setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.tempLineDelegate drawLayer:self.tempLineLayer inContext:ctx];
    [self.edgesDelegate drawLayer:self.edgesLayer inContext:ctx];
}


@end
