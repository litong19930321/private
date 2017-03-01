//
//  RepeatAnimalViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/3/1.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "RepeatAnimalViewController.h"

@interface RepeatAnimalViewController ()
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (strong, nonatomic) CALayer * layer;
@end

@implementation RepeatAnimalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self repeatAnimal];
}

-(void)repeatAnimal{
    _layer = [CALayer layer];
    _layer.frame = self.mainView.bounds;
    _layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"door"].CGImage);
  
    [self.mainView.layer addSublayer:_layer];
    
//    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/1500.0;
    self.mainView.layer.sublayerTransform = transform;
    
    CABasicAnimation * basicAnimal = [CABasicAnimation animation];
    basicAnimal.keyPath = @"transform.rotation.y";
    basicAnimal.toValue = @(-M_PI/4);
    basicAnimal.duration = 2;
    basicAnimal.repeatCount = INFINITY;
    basicAnimal.autoreverses = YES;
    [_layer addAnimation:basicAnimal forKey:nil];
    _layer.speed = 0;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
}
- (void)pan:(UIPanGestureRecognizer *)pan
{
    //get horizontal component of pan gesture
    CGFloat x = [pan translationInView:self.view].x;
    //convert from points to animation duration //using a reasonable scale factor
    x /= 200.0f;
    //update timeOffset and clamp result
    CFTimeInterval timeOffset = _layer.timeOffset;
    timeOffset = MIN(0.999, MAX(0.0, timeOffset - x));
    _layer.timeOffset = timeOffset;
    //reset pan gesture
    [pan setTranslation:CGPointZero inView:self.view];
}


@end
