//
//  LayerPropertyViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/28.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "LayerPropertyViewController.h"

@interface LayerPropertyViewController ()
@property (weak, nonatomic) IBOutlet UIView *cornerTestView;
@property (weak, nonatomic) IBOutlet UIView *layerView1;
@property (weak, nonatomic) IBOutlet UIView *layerView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LayerPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //这个曲率值只影响背景颜色而不影响背景图片或是子图层 ，需要截图的时候还需要加masktoBounds
    self.cornerTestView.layer.cornerRadius = 5.0f;
    //shadowOpacity是一个必须在0.0（不可见）和1.0（完全不透明）之间的浮点数。如果设置为1.0，将会显示一个有轻微模糊的黑色阴影稍微在图层之上
    // shadowColor 颜色
    // shadowOffset 默认为{0，-3}
    // shadowRadius
    self.cornerTestView.layer.shadowOpacity = 1.0f;
    self.cornerTestView.layer.shadowOffset = CGSizeMake(0, 3);
    self.cornerTestView.layer.shadowRadius = 5.0f;
    
//    可以通过指定一个shadowPath来提高性能。shadowPath是一个CGPathRef类型（一个指向CGPath的指针）。CGPath是一个Core Graphics对象，用来指定任意的一个矢量图形。我们可以通过这个属性单独于图层形状之外指定阴影的形状
    self.layerView1.layer.opacity = 1.0f;
    CGMutablePathRef squarePath = CGPathCreateMutable();
    CGPathAddRect(squarePath, NULL,self.layerView1.bounds);
    self.layerView1.layer.shadowPath = squarePath;
    CGPathRelease(squarePath);
    
    [self.view setNeedsLayout];
    [self setMaskLayer];
}
-(void)setMaskLayer{
    CALayer * layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0 + 50, 50, 50);
    layer.contents = (__bridge id)[UIImage imageNamed:@"chapter3"].CGImage;
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    self.imageView.layer.mask = layer;
}



@end
