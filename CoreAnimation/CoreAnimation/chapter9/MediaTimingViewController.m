//
//  MediaTimingViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/3/1.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "MediaTimingViewController.h"

@interface MediaTimingViewController (){
    NSInteger _count;
    CFTimeInterval _lasttime;
}

@property (nonatomic,strong) CALayer * layer;
@property (weak, nonatomic) IBOutlet UIImageView *ballImgView;
@end

@implementation MediaTimingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _count = 0;
    [self.view setNeedsLayout];
    [self createMediefuncAnimal];
    [self getFPS];
}

-(void)createMediefuncAnimal{
   _layer = [CALayer layer];
   _layer.frame = CGRectMake(0, 0, 100, 100);
   
   _layer.backgroundColor = [UIColor orangeColor].CGColor;
   [self.view.layer addSublayer:_layer];
    
    
    
}
- (IBAction)startAnimal:(id)sender {
    
    //create a keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor ];
    //add timing function
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
//    [(0,0), c1, c2, (1,1)]
//    [CAMediaTimingFunction functionWithControlPoints:1 :0 :0 :0];
    animation.timingFunctions = @[fn, fn, fn];
    //apply animation to layer
    [_layer addAnimation:animation forKey:nil];
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:2.0f];
//    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    _layer.position = [[touches anyObject] locationInView:self.view];
//    
//    [CATransaction commit];
//}
- (IBAction)usekeyAnimation:(id)sender {
    [self startAnimal];
    
}

-(void)startAnimal{
    CAKeyframeAnimation * keyAnimal = [CAKeyframeAnimation alloc];
    NSValue *fromValue = [NSValue valueWithCGPoint:CGPointMake(175, 200)];
    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(175, 630)];
    keyAnimal.keyPath = @"position";
    CFTimeInterval duration = 2.0;
    //generate keyframes
    NSInteger numFrames = duration * 60;
    NSMutableArray *frames = [NSMutableArray array];
    for (int i = 0; i < numFrames; i++) {
        float time = 1/(float)numFrames * i;
        //apply easing
        time = bounceEaseOut(time);
        //add keyframe
        [frames addObject:[self interpolateFromValue:fromValue toValue:toValue time:time]];
    }
    
    keyAnimal.values = frames;
    keyAnimal.duration = 2.0;
    self.ballImgView.layer.position = CGPointMake(175, 630);
    [self.ballImgView.layer addAnimation:keyAnimal forKey:nil];
}
- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time
{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        //get type
        const char *type = [fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate(from.x, to.x, time), interpolate(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    //provide safe default implementation
    return (time < 0.5)? fromValue: toValue;
}
float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}
float bounceEaseOut(float t)
{
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}
-(void)getFPS{

    CADisplayLink * time = [CADisplayLink displayLinkWithTarget:self selector:@selector(caculate:)];
    [time addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}
-(void)caculate:(CADisplayLink *)link{
    if (_lasttime == 0) {
        _lasttime = link.timestamp;
    }
    NSTimeInterval del = link.timestamp - _lasttime;
    if (_count < 60) {
        _count = _count + 1;
    }
    if (del < 1) {
        return;
    }
    
    
    
    NSLog(@"FPS:%ld",(long)_count);
    if (_count == 60) {
        _count = 0;
    }
    _lasttime = link.timestamp;
}
@end






















