//
//  TestViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/3/1.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "TestViewController.h"
#import <math.h>
@interface TestViewController (){
    NSInteger _count;
    NSMutableArray * _arr;
    BOOL _iscomplete;
}
@property (nonatomic,strong) CALayer * mainLayer;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _iscomplete = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _mainLayer = [CALayer layer];
    _mainLayer.backgroundColor = [UIColor orangeColor].CGColor;
    _mainLayer.frame = CGRectMake(0, 0, 100, 100);
    _mainLayer.position = self.view.center;
    _mainLayer.cornerRadius = 50;
    _mainLayer.zPosition = 1;
    [self.view.layer addSublayer:_mainLayer];
    _count = 0;
    _arr = @[].mutableCopy;
}

-(void)showMoreBall{

    for (int i = 0; i < 8; i ++) {
        CALayer * layer = [CALayer layer];
        layer.backgroundColor = [UIColor blueColor].CGColor;
        layer.frame = CGRectMake(0, 0, 50, 50);
        layer.cornerRadius = 25;
        layer.position = _mainLayer.position;
        [self.view.layer addSublayer:layer];
        [_arr addObject:layer];
    }
    NSTimer * timer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(free:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    
}
-(void)free:(NSTimer *)timer{
    if (_count == 8) {
        [timer invalidate];
        _count = 0;
        _iscomplete = YES;
        return;
    }
    CALayer * layer = _arr[_count];
    CABasicAnimation * animal = [CABasicAnimation animation];
    animal.keyPath = @"position";
    CGFloat x = 100 *  cos(M_PI / 4 * _count);
    CGFloat y = 100 * sin(M_PI / 4 * _count);
    CGAffineTransform  transform = CGAffineTransformIdentity;
    transform = CGAffineTransformMakeTranslation(x, y);
    animal.fromValue = [NSValue valueWithCGPoint:layer.position];
    CGFloat tox = x + layer.position.x;
    CGFloat toy = y + layer.position.y;
    animal.toValue = [NSValue valueWithCGPoint:CGPointMake(tox, toy)];
    animal.duration = 0.2;
//    animal.byValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
    animal.fillMode = kCAFillModeForwards;
    animal.removedOnCompletion = NO;
    [layer addAnimation:animal forKey:nil];
    
    _count += 1;
    
}
-(void)reciveBall{
    NSTimer * timer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(recive:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

-(void)recive:(NSTimer *)timer{
    if (_count == 8) {
        [timer invalidate];
        _count = 0;
        _iscomplete = NO;
        return;
    }
    CALayer * layer = _arr[_count];
    CABasicAnimation * animal = [CABasicAnimation animation];
    animal.keyPath = @"position";
    animal.toValue = [NSValue valueWithCGPoint:_mainLayer.position];
    animal.duration = 0.2;
    animal.fillMode = kCAFillModeForwards;
    animal.removedOnCompletion = NO;
    [layer addAnimation:animal forKey:nil];
    
    _count += 1;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint  point = [[touches anyObject] locationInView:self.view];
    point = [_mainLayer convertPoint:point fromLayer:self.view.layer];
    if ([_mainLayer containsPoint:point] && !_iscomplete) {
        NSLog(@"hello");
        [self showMoreBall];
    }else if ([_mainLayer containsPoint:point] && _iscomplete){
        [self reciveBall];
    }
}


@end
