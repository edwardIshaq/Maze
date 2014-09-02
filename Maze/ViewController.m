//
//  ViewController.m
//  Maze
//
//  Created by Edward Ishaq on 8/17/14.
//  Copyright (c) 2014 Edward Ashak. All rights reserved.
//

#import "ViewController.h"
#import "MAPoint.h"
#import "DrawingView.h"

@interface ViewController ()
@property NSMutableSet *points;
@property MAPoint *startPoint;
@property (assign) CGPoint currPoint;
@property UIView *currLine;
@end

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.points = [NSMutableSet set];
    
    UITapGestureRecognizer *pointTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pointTapHandler:)];
    [self.view addGestureRecognizer:pointTap];
    
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
//    [self.view addGestureRecognizer:longPress];
    
    //Add a pan Gesture to the point
    UIPanGestureRecognizer *dragLine = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragLineHandler:)];
    dragLine.delegate = self;
    [self.view addGestureRecognizer:dragLine];

}



- (IBAction)pointTapHandler:(UITapGestureRecognizer*)tap {
    CGPoint center = [tap locationInView:self.view];
    [self addPointAt:center];
}

- (void)addPointAt:(CGPoint)center {
    MAPoint *point = [[MAPoint alloc] initPointWithCGPoint:center];
    [self.view addSubview:point.view];
    [self.points addObject:point];

}
/*
 velocity could be used as weight of edge
 
 */
- (IBAction)dragLineHandler:(UIPanGestureRecognizer*)tap {
    CGPoint endPoint = [tap locationInView:self.view];
    self.currPoint = endPoint;
    
    DrawingView *drawingView = (DrawingView*)self.view;
    
    [drawingView drawTempLineFromPoint:self.startPoint.center toPoint:self.currPoint];
    return;
    
    drawingView.startPoint = self.startPoint.center;
    drawingView.endPoint = self.currPoint;
    [self.view setNeedsDisplay];
    return;
    
//    [self addPointAt:endPoint];
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, self.startPoint.center.x, self.startPoint.center.y);
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
    CGContextSetLineWidth(ctx, 10 );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), .5, .5, .5 , 1.0);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    UIGraphicsEndImageContext();

    return;

    //Check against subviews(Points) ?
    //NSLog(@"dragLineAction: %.2f %.2f ", endPoint.x, endPoint.y);
    UIView *lineView = [self lineFromPoint:self.startPoint.view.center toPoint:endPoint];
    if (lineView) {
        [self.currLine removeFromSuperview];
        self.currLine = lineView;
        [self.view addSubview:self.currLine];
    }
}

#pragma mark - UIGestureRecognizerDelegate impl.

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    }
    //Check if this point is contained in any of the points
    //if yes add it as a starting point and return yes
    CGPoint gesturePoint = [gestureRecognizer locationInView:self.view];
    for (MAPoint *point in self.points) {
        if (CGRectContainsPoint(point.view.frame, gesturePoint)) {
            self.startPoint = point;
            NSLog(@"Starting Point: %@", point);
            return YES;
        }
    }
    return NO;
}


- (UIView*)lineFromPoint:(CGPoint)start toPoint:(CGPoint)finish {

    
    NSLog(@"x:%.2f y:%.2f dx:%.0f dy:%.0f", start.x, start.y, finish.x, finish.y);
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(start.x, start.y, finish.x ,finish.y)];
    lineView2.backgroundColor = [UIColor redColor];
    
    return lineView2;

    
    CGFloat length = sqrtf(powf(ABS(start.x-finish.x), 2) + powf(ABS(start.y - finish.y),2));
    
    CGFloat deltaY = finish.y - start.y;
    CGFloat deltaX = finish.x - start.x;
    CGFloat angle = atan2f(deltaY, deltaX);
    
//    NSLog(@"length:%.2f angle:%.2f | s: (%.0f,%.0f) e: (%.0f,%.0f)", length, angle, start.x, start.y, finish.x, finish.y);
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(start.x, start.y, length, 10.0)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.layer.anchorPoint = CGPointMake(0, 0);
    lineView.transform = CGAffineTransformMakeRotation(angle);
//    lineView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, angle);
    NSLog(@"x:%.2f y:%.2f dx:%.0f dy:%.0f", start.x, start.y, deltaX, deltaY);
    return lineView;
}
- (void)searchAlgorithem {
    /*
     - initiate Queue
     - check to see if done
     - else Extend first Path on Queue
     - Enqueue DFS/BFS (head/tail of Q)
     - Hill Climbing ? dont remember
     - Beam Search (Keep only 2 each level)
     
     Ideas: remove nodes that have been extended , to remove duplicate processing
     
     */
}
@end
