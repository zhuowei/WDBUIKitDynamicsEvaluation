//
//  ViewController.m
//  WDBUIKitDynamicsEvaluation
//
//  Created by Zhuowei Zhang on 2022-09-11.
//

#import "ViewController.h"

@interface ViewController ()
@property(strong, nonatomic) IBOutlet UIView* ballView;
@property(strong, nonatomic) IBOutlet UIView* calendarEntry1View;
@property(strong, nonatomic) IBOutlet UIView* calendarEntry2View;
@property(strong, nonatomic) IBOutlet UIView* plinthView;
@property(strong, nonatomic) IBOutlet UIView* floorView;
@property(strong, nonatomic) IBOutlet UIView* rightWallView;
@property(strong, nonatomic) UIDynamicAnimator* dynamicAnimator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calendarEntry1View.layer.shadowColor = UIColor.blackColor.CGColor;
    self.calendarEntry1View.layer.shadowOpacity = 0.5;
    self.calendarEntry1View.layer.shadowOffset = CGSizeMake(0, 2);
    self.calendarEntry1View.layer.cornerRadius = 8;
    //self.calendarEntry1View.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    self.calendarEntry2View.layer.shadowColor = UIColor.blackColor.CGColor;
    self.calendarEntry2View.layer.shadowOpacity = 0.5;
    self.calendarEntry2View.layer.shadowOffset = CGSizeMake(0, 2);
    self.calendarEntry2View.layer.cornerRadius = 8;
    self.calendarEntry2View.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
}

-(IBAction)startAnimation:(UIView*)view {
    view.hidden = true;
  // Do any additional setup after loading the view.
  self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
  [self.dynamicAnimator addBehavior:[[UIGravityBehavior alloc] initWithItems:@[
    self.ballView, self.calendarEntry1View, self.calendarEntry2View, self.plinthView
                        ]]];
    UICollisionBehavior* collision = [[UICollisionBehavior alloc]initWithItems:@[self.ballView, self.calendarEntry1View, self.calendarEntry2View, self.plinthView]];
    
    [collision addBoundaryWithIdentifier:@"floor" forPath:[UIBezierPath bezierPathWithRect:self.floorView.frame]];
    [collision addBoundaryWithIdentifier:@"rightWall" forPath:[UIBezierPath bezierPathWithRect:self.rightWallView.frame]];
    [self.dynamicAnimator addBehavior:collision];
    UIPushBehavior* push = [[
        UIPushBehavior alloc]initWithItems:@[self.ballView] mode:UIPushBehaviorModeInstantaneous];
    push.magnitude = 100;
    push.angle = -M_PI / 4.;
    [self.dynamicAnimator addBehavior:push];
}

@end
