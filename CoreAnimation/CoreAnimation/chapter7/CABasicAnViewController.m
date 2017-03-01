//
//  CABasicAnViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/3/1.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "CABasicAnViewController.h"

@interface CABasicAnViewController ()<CAAnimationDelegate>
@property (strong, nonatomic) CALayer * customLayer;
@property (weak, nonatomic) IBOutlet UIView *customView;

@end

@implementation CABasicAnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setNeedsLayout];
//    [self createBasicAnimation];
//    [self createAnimationRoundBezierPath];
    [self createGroupAnimation];
}

-(void)createBasicAnimation{
    _customLayer = [CALayer layer];
    _customLayer.frame = self.customView.bounds;
    _customLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.customView.layer addSublayer:_customLayer];
}
//开始执行动画
- (IBAction)startAnimation:(id)sender {
    int a = arc4random()%255;
    int b = arc4random()%255;
    int c = arc4random()%255;
    UIColor * color = [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1.0];
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.delegate = self;
    animation.toValue = (__bridge id _Nullable)(color.CGColor);
    self.customLayer.backgroundColor = (__bridge CGColorRef _Nullable)(color);
    [self.customLayer addAnimation:animation forKey:nil];
}
- (IBAction)startK:(id)sender {
//    CAKeyframeAnimation * keyAnimation = [CAKeyframeAnimation animation];
//    keyAnimation.duration = 2.0;
//    keyAnimation.keyPath = @"backgroundColor";
//    keyAnimation.values = @[
//                            (__bridge id)[UIColor blueColor].CGColor,
//                            (__bridge id)[UIColor redColor].CGColor,
//                            (__bridge id)[UIColor greenColor].CGColor,
//                            (__bridge id)[UIColor blueColor].CGColor ];
//    [self.customLayer addAnimation:keyAnimation forKey:nil];
    [self createGroupAnimation];
}


-(void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.customLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}

-(void)createAnimationRoundBezierPath{
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(20, 300)];
    [bezierPath addCurveToPoint:CGPointMake(350, 300) controlPoint1:CGPointMake(95, 250) controlPoint2:CGPointMake(260, 350)];
    CAShapeLayer * shapLayer = [CAShapeLayer layer];
    shapLayer.path = bezierPath.CGPath;
    shapLayer.lineWidth = 3.0f;
    shapLayer.fillColor = [UIColor clearColor].CGColor;
    shapLayer.strokeColor = [UIColor blueColor].CGColor;
    shapLayer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor orangeColor]);
    shapLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:shapLayer];
    
    CAKeyframeAnimation * keyAnimal = [CAKeyframeAnimation animation];
    keyAnimal.path = bezierPath.CGPath;
    keyAnimal.duration = 5.0;
    keyAnimal.keyPath = @"position";
    
    CALayer * animalLayer = [CALayer layer];
    animalLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"avatar"].CGImage);
    animalLayer.frame = CGRectMake(0, 0, 64, 64);
    animalLayer.position = CGPointMake(20, 300);
    
    [self.view.layer addSublayer:animalLayer];
    
    [animalLayer addAnimation:keyAnimal forKey:nil];

}

-(void)createGroupAnimation{
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(20, 300)];
    [bezierPath addCurveToPoint:CGPointMake(350, 300) controlPoint1:CGPointMake(95, 250) controlPoint2:CGPointMake(260, 350)];
    CAShapeLayer * shapLayer = [CAShapeLayer layer];
    shapLayer.path = bezierPath.CGPath;
    shapLayer.lineWidth = 3.0f;
    shapLayer.contentsScale = [UIScreen mainScreen].scale;
    shapLayer.fillColor = [UIColor clearColor].CGColor;
    shapLayer.strokeColor = [UIColor blueColor].CGColor;
    shapLayer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor orangeColor]);
    shapLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:shapLayer];
    
    
    //移动动画
    CAKeyframeAnimation * keyAnimal = [CAKeyframeAnimation animation];
    keyAnimal.path = bezierPath.CGPath;
//    keyAnimal.duration = 5.0;
    keyAnimal.keyPath = @"position";
    //背影颜色切换动画
    CABasicAnimation *  colorAnimal = [CABasicAnimation animation];
    colorAnimal.keyPath = @"backgroundColor";
    colorAnimal.toValue = (__bridge id)[UIColor greenColor].CGColor;
    
    
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[colorAnimal,keyAnimal];
    groupAnimation.duration = 5.0;
    groupAnimation.removedOnCompletion = NO;
    CALayer * animalLayer = [CALayer layer];
    animalLayer.backgroundColor = [UIColor orangeColor].CGColor;
//    animalLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"avatar"].CGImage);
    animalLayer.frame = CGRectMake(0, 0, 64, 64);
    animalLayer.position = CGPointMake(40, 300);
    animalLayer.fillMode = kCAFillModeForwards;
    [self.view.layer addSublayer:animalLayer];
    
    [animalLayer addAnimation:groupAnimation forKey:nil];

}

@end


















