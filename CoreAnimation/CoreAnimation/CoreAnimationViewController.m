//
//  CoreAnimationViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/27.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "CoreAnimationViewController.h"
#import <objc/runtime.h>
@interface CoreAnimationViewController ()

@property (nonatomic,strong) UIView * animalView_keyframe;
@end

@implementation CoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    ((void (*) (id,SEL))objc_msgSend)(self,@selector(animation_1));
    _animalView_keyframe = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 60, 30)];
    _animalView_keyframe.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_animalView_keyframe];
    
}
//basic
-(void)animation_1{
    UIView * animalView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, 60, 60)];
    NSLog(@"%f--%f",animalView.layer.position.x,animalView.layer.position.y);
    
    animalView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:animalView];
    dispatch_queue_t queue = dispatch_queue_create("lt.test", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"hello");
        dispatch_async(dispatch_get_main_queue(), ^{
            CABasicAnimation * animation = [CABasicAnimation animation];
            animation.keyPath = @"position.x";
            animation.fromValue = @(animalView.frame.origin.x);
            animation.toValue = @(self.view.frame.size.width - 60);
            animation.duration = 1.0;
            [animalView.layer addAnimation:animation forKey:@"basic"];
            animalView.layer.position = CGPointMake(self.view.frame.size.width - 60,50);
        });
    });
    
}
//cakeyframeAnimation 关键帧动画
-(void)keyframeAnimtaion{
    
    CAKeyframeAnimation * keyframeAnimation = [CAKeyframeAnimation animation];
    keyframeAnimation.keyPath = @"position.y";
    keyframeAnimation.values =  @[ @0, @10, @-10, @10, @0 ];
    keyframeAnimation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    keyframeAnimation.additive = YES;
    [_animalView_keyframe.layer addAnimation:keyframeAnimation forKey:@"shake"];
}
- (IBAction)start:(id)sender {
    [self keyframeAnimtaion];
}

@end
