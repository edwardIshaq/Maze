
//  DrawingView.m
//  Maze
//
//  Created by Edward Ishaq on 9/1/14.
//  Copyright (c) 2014 Edward Ashak. All rights reserved.
//

#import "DrawingView.h"
#import "LineLayerDelegate.h"

@import QuartzCore;

@interface DrawingView ()
@property CALayer *pointsLayer;
@property CALayer *tempLineLayer;
@property CALayer *linesLayer;

@property LineLayerDelegate *tempLineDelegate;

@end

@implementation DrawingView

- (void)commonInit {
    // Initialization code
    self.pointsLayer = [CALayer layer];
    self.pointsLayer.frame = self.bounds;
    //self.pointsLayer.delegate = self;
    
    self.tempLineLayer = [CALayer layer];
    self.tempLineLayer.frame = self.bounds;
    self.tempLineDelegate = [LineLayerDelegate new];
    self.tempLineLayer.delegate = self.tempLineDelegate;
    
    self.linesLayer = [CALayer layer];
    self.linesLayer.frame = self.bounds;
    //self.linesLayer.delegate = self;
    
    [self.layer addSublayer:self.pointsLayer];
    [self.layer addSublayer:self.tempLineLayer];
    [self.layer addSublayer:self.linesLayer];

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
    
}


@end
