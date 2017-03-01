//
//  FictitiousViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/3/1.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "FictitiousViewController.h"

@interface FictitiousViewController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (strong, nonatomic) CALayer * shapLayer;
@end

@implementation FictitiousViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)startAnimal:(id)sender {
    _shapLayer = [CALayer layer];
    _shapLayer.frame = _mainView.bounds;
    _shapLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"avatar"].CGImage);
    [_mainView.layer addSublayer:_shapLayer];
    
    
    CABasicAnimation * animal = [CABasicAnimation animation];
    animal.duration = 2.0;
    animal.delegate = self;
    animal.keyPath = @"transform.rotation";
//    CATransform3D transFrom = CATransform3DMakeRotation(M_PI, 0, 0, 1);
    animal.byValue = @(M_PI * 2);
    [_shapLayer addAnimation:animal forKey:@"basicAnimation"];
}
- (IBAction)showTransition:(id)sender {
    int a = arc4random()%255;
    int b = arc4random()%255;
    int c = arc4random()%255;
    UIColor * color = [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1.0];
    CATransition * transition = [CATransition animation];
    transition.type = @"cobe";
    
    [self.mainImageView.layer addAnimation:transition forKey:nil];
    self.mainImageView.backgroundColor = color;
}

- (IBAction)customAnimal:(id)sender {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * coverImg = UIGraphicsGetImageFromCurrentImageContext();
    UIView * coverView = [[UIImageView alloc] initWithImage:coverImg];
    coverView.frame = self.view.bounds;
    [self.view addSubview:coverView];
    
    [UIView animateWithDuration:2.0 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI / 2);
        coverView.transform = transform;
        coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
    }];
    
}


- (IBAction)stop:(id)sender {
    [self.shapLayer removeAnimationForKey:@"basicAnimation"];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"%@",flag ? @"YES" :@"NO");
}

@end











