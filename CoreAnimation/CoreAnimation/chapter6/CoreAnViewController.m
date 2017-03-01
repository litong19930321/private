//
//  CoreAnViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/28.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "CoreAnViewController.h"

@interface CoreAnViewController ()
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIView *testView1;
@property (strong,nonatomic) CALayer * layer;

@end

@implementation CoreAnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self defaulta];
//    [self defaultb];
    [self testPresentLayer];
}
-(void)defaulta{
    _layer = [CALayer layer];
    _layer.frame = self.testView1.bounds;
    _layer.backgroundColor = [UIColor orangeColor].CGColor;
    
    [self.testView1.layer addSublayer:_layer];
}

-(void)defaultb{
    _layer = [CALayer layer];
    _layer.frame = self.testView1.bounds;
    _layer.backgroundColor = [UIColor blueColor].CGColor;
    
    CATransition * transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    _layer.actions = @{@"backgroundColor":transition};
    [self.testView1.layer addSublayer:_layer];
}



- (IBAction)changeBtn:(id)sender {

//    [CATransaction begin];
//    [CATransaction setAnimationDuration:1.0];
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
//    [CATransaction commit];
}

-(void)testPresentLayer{
    _layer = [CALayer layer];
    _layer.frame = CGRectMake(100, 100, 50, 50);
    _layer.backgroundColor = [UIColor orangeColor].CGColor;
    _layer.anchorPoint = CGPointMake(0, 0);
    [self.view.layer addSublayer:_layer];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint currentPoint = [[touches anyObject] locationInView:self.view];
    if ([_layer.presentationLayer hitTest:currentPoint]) {
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    }else{
        [CATransaction begin];
        [CATransaction setAnimationDuration:1.0];
        _layer.position = currentPoint;
        [CATransaction commit];
    }
}

@end



















