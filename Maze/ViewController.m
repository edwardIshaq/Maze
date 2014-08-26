//
//  ViewController.m
//  Maze
//
//  Created by Edward Ishaq on 8/17/14.
//  Copyright (c) 2014 Edward Ashak. All rights reserved.
//

#import "ViewController.h"
#import "MAPoint.h"

@interface ViewController ()
@property NSMutableSet *points;
@property MAPoint *startPoint;
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
    
    MAPoint *point = [[MAPoint alloc] initPointWithCGPoint:center];
    [self.view addSubview:point.view];
    [self.points addObject:point];
}


/*
 velocity could be used as weight of edge
 
 */
- (IBAction)dragLineHandler:(UIPanGestureRecognizer*)tap {
    CGPoint endPoint = [tap locationInView:self.view];
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

/*
 typedef NS_ENUM(NSInteger, UIGestureRecognizerState) {
 UIGestureRecognizerStatePossible,   // the recognizer has not yet recognized its gesture, but may be evaluating touch events. this is the default state
 
 UIGestureRecognizerStateBegan,      // the recognizer has received touches recognized as the gesture. the action method will be called at the next turn of the run loop
 UIGestureRecognizerStateChanged,    // the recognizer has received touches recognized as a change to the gesture. the action method will be called at the next turn of the run loop
 UIGestureRecognizerStateEnded,      // the recognizer has received touches recognized as the end of the gesture. the action method will be called at the next turn of the run loop and the recognizer will be reset to UIGestureRecognizerStatePossible
 UIGestureRecognizerStateCancelled,  // the recognizer has received touches resulting in the cancellation of the gesture. the action method will be called at the next turn of the run loop. the recognizer will be reset to UIGestureRecognizerStatePossible
 
 UIGestureRecognizerStateFailed,     // the recognizer has received a touch sequence that can not be recognized as the gesture. the action method will not be called and the recognizer will be reset to UIGestureRecognizerStatePossible
 
 // Discrete Gestures – gesture recognizers that recognize a discrete event but do not report changes (for example, a tap) do not transition through the Began and Changed states and can not fail or be cancelled
 UIGestureRecognizerStateRecognized = UIGestureRecognizerStateEnded // the recognizer has received touches recognized as the gesture. the action method will be called at the next turn of the run loop and the recognizer will be reset to UIGestureRecognizerStatePossible
 };
*/

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchLocation = [touch locationInView:self.view];
    NSLog(@"(%.0f %.0f) state: %d", touchLocation.x, touchLocation.y, gestureRecognizer.state);

    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"%@ Began" , gestureRecognizer);
            break;
            
        case UIGestureRecognizerStateChanged:
            NSLog(@"%@ Changed" , gestureRecognizer);
            break;
            
        case UIGestureRecognizerStateEnded:
            NSLog(@"%@ Ended" , gestureRecognizer);
            break;
            
            
            
        default:
            break;
    }
    return YES;
}

- (UIView*)lineFromPoint:(CGPoint)start toPoint:(CGPoint)finish {
    
    CGFloat length = sqrtf(powf(ABS(start.x-finish.x), 2) + powf(ABS(start.y - finish.y),2));
    
    CGFloat deltaY = finish.y - start.y;
    CGFloat deltaX = finish.x - start.x;
    CGFloat angle = atan2f(deltaY, deltaX);
    
    NSLog(@"length:%.2f angle:%.2f | s: (%.0f,%.0f) e: (%.0f,%.0f)", length, angle, start.x, start.y, finish.x, finish.y);
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor blackColor];
    CGRect lineFrame = CGRectMake(start.x, start.y, length, 10.0);
    lineView.frame = lineFrame;
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    lineView.transform = transform;

//    lineView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, angle);

    
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
