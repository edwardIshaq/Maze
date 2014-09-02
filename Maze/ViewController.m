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
    CGPoint gesturePoint = [tap locationInView:self.view];
    self.currPoint = gesturePoint;
    
    MAPoint *destPoint = [self pointContainingTouchPoint:gesturePoint];
    DrawingView *drawingView = (DrawingView*)self.view;
    
    if (destPoint && ![destPoint isEqual:self.startPoint]) {
        [drawingView drawLineFromPoint:self.startPoint.center toPoint:self.currPoint];
    }
    else
    {
        [drawingView drawTempLineFromPoint:self.startPoint.center toPoint:self.currPoint];
    }
}

#pragma mark - UIGestureRecognizerDelegate impl.
- (MAPoint*)pointContainingTouchPoint:(CGPoint)touchPoint {
    MAPoint *containingPoint = nil;
    for (MAPoint *point in self.points) {
        if (CGRectContainsPoint(point.view.frame, touchPoint)) {
            containingPoint = point;
            break;
        }
    }
    return containingPoint;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    }
    

    //Check if this point is contained in any of the points
    //if yes add it as a starting point and return yes
    CGPoint gesturePoint = [gestureRecognizer locationInView:self.view];
    
    self.startPoint = [self pointContainingTouchPoint:gesturePoint];
    return (self.startPoint? YES : NO);
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
