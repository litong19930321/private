//
//  PlayViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/3/2.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "PlayViewController.h"
#define kSpace 0.05
@interface PlayViewController ()
@property (nonatomic,strong) CADisplayLink * timer;
@property (nonatomic,strong) CAShapeLayer * layer;
@property (nonatomic,strong) CAGradientLayer * gradientLayer1;
@property (nonatomic,strong) CAGradientLayer * gradientLayer2;
@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createLayer];
//    [self cerate];
    [self creReplicatorLayer];
}


- (IBAction)startAnimal:(id)sender {
    if (!_timer) {
        _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(fill:)];
        [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }else{
        _timer.paused = NO;
    }
}
- (IBAction)reset:(id)sender {
    _timer.paused = YES;
    _layer.strokeEnd = 0;
}
//圆圈动画
-(void)fill:(CADisplayLink *)timer{
    if (_layer.strokeStart ==  1.0) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        _layer.strokeStart = 0;
        _layer.strokeEnd = 0;
        [CATransaction commit];
    }
    if (_layer.strokeEnd < 1.0) {
        if (_layer.strokeEnd + kSpace > 1.0) {
            _layer.strokeEnd = 1.0;
        }
        _layer.strokeEnd += kSpace;
    }else{
        if (_layer.strokeStart + kSpace > 1.0) {
            _layer.strokeStart = 1.0;
        }else{
            _layer.strokeStart += kSpace;
        }
//        return;
    }
    
}
-(void)createLayer{
    _layer = [CAShapeLayer layer];
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(175, 250) radius:50 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    _layer.path = path.CGPath;
    _layer.strokeColor = [UIColor redColor].CGColor;
    _layer.fillColor = [UIColor greenColor].CGColor;
    _layer.strokeStart = 0;
    _layer.strokeEnd = 0;
    _layer.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:_layer];
    
}

//过度图层
-(void)cerate{
    _gradientLayer1 = [CAGradientLayer layer];
    _gradientLayer1.frame = CGRectMake(0, 0, 100, 50);
//    _gradientLayer1.position = CGPointMake(175, 350);
    _gradientLayer1.colors = @[(id)[UIColor orangeColor].CGColor,(id)[UIColor blueColor].CGColor];
    _gradientLayer1.locations = @[@0.4,@0.6];
    
    
    _gradientLayer2 = [CAGradientLayer layer];
    _gradientLayer2.frame = CGRectMake(0, 50, 100, 50);
//    _gradientLayer2.position = CGPointMake(175, 300);
    _gradientLayer2.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor purpleColor].CGColor];
    _gradientLayer2.locations = @[@0.4,@0.6];
    
    
    CALayer * alayer = [CALayer layer];
    alayer.frame = CGRectMake(0, 0, 100, 100);
    alayer.position = CGPointMake(175, 325);
    [alayer addSublayer:_gradientLayer1];
    [alayer addSublayer:_gradientLayer2];
    [self.view.layer addSublayer:alayer];
    
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:30 startAngle:M_PI/2 endAngle:M_PI * 3/ 4 clockwise:NO];
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.lineWidth = 5.0f;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineCap = @"round";
    alayer.mask = layer;
    

}


-(void)creReplicatorLayer{
    CALayer * layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 30, 30);
    layer.position = CGPointMake(self.view.center.x - 50, self.view.center.y - 50);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = 15;
    [self.view.layer addSublayer:layer];
    
    CABasicAnimation * animation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation1.fromValue = @(0);
    animation1.toValue = @(1);
    animation1.duration = 1.5;
    //    animation1.autoreverses = YES;
    
    CABasicAnimation * animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.toValue = @(1.5);
    animation2.fromValue = @(0.5);
    animation2.duration = 1.5;
    //    animation2.autoreverses = YES;
    
    CAAnimationGroup * ani = [CAAnimationGroup animation];
    ani.animations = @[animation1,animation2];
    ani.duration = 1.5;
    ani.repeatCount = MAXFLOAT;
    ani.autoreverses = YES;
    
    [layer addAnimation:ani forKey:nil];
    
    CAReplicatorLayer * rec = [CAReplicatorLayer layer];
    [rec addSublayer:layer];
    rec.instanceCount = 3;
    rec.instanceDelay = 0.5;
    rec.instanceTransform = CATransform3DMakeTranslation(50, 0, 0);
    [self.view.layer addSublayer:rec];
    
    CAReplicatorLayer * rec2 = [CAReplicatorLayer layer];
    [rec2 addSublayer:rec];
    rec2.instanceCount = 3;
    rec2.instanceDelay = 0.5;
    rec2.instanceTransform = CATransform3DMakeTranslation(0, 50, 0);
    [self.view.layer addSublayer:rec2];
}
@end
