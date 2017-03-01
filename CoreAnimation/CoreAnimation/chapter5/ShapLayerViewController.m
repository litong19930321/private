//
//  ShapLayerViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/28.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "ShapLayerViewController.h"

@interface ShapLayerViewController ()

@end

//CAShapeLayer是一个通过矢量图形而不是bitmap来绘制的图层子类。你指定诸如颜色和线宽等属性，用CGPath来定义想要绘制的图形，最后CAShapeLayer就自动渲染出来了。当然，你也可以用Core Graphics直接向原始的CALyer的内容中绘制一个路径，相比直下，使用CAShapeLayer有以下一些优点：

//渲染快速。CAShapeLayer使用了硬件加速，绘制同一图形会比用Core Graphics快很多。
//高效使用内存。一个CAShapeLayer不需要像普通CALayer一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存。
//不会被图层边界剪裁掉。一个CAShapeLayer可以在边界之外绘制。你的图层路径不会像在使用Core Graphics的普通CALayer一样被剪裁掉（如我们在第二章所见）。
//不会出现像素化。当你给CAShapeLayer做3D变换时，它不像一个有寄宿图的普通图层一样变得像素化。

@implementation ShapLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self useBezierPath];
    [self createCorner];
    [self createTextLayer];
}
//画一个火材人
-(void)useBezierPath{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(175, 80) radius:20 startAngle:-M_PI * 3/ 2  endAngle:M_PI/2 clockwise:YES];
    [path addLineToPoint:CGPointMake(175, 150)];
    [path moveToPoint:CGPointMake(150, 180)];
    [path addLineToPoint:CGPointMake(175, 150)];
    [path moveToPoint:CGPointMake(175, 150)];
    [path addLineToPoint:CGPointMake(200, 180)];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(200, 125)];
    
    
    CAShapeLayer * shaplayer = [CAShapeLayer layer];
    shaplayer.strokeColor = [UIColor redColor].CGColor;
    shaplayer.lineWidth = 2.0f;
    shaplayer.fillColor = [UIColor orangeColor].CGColor;
//    shaplayer.lineJoin = kCALineJoinRound;
    shaplayer.lineCap = kCALineCapRound;
    shaplayer.path = path.CGPath;

    [self.view.layer addSublayer:shaplayer];
}

//使用cashaplayer 来控制具体的圆角数量
-(void)createCorner{
    CGRect rect = CGRectMake(0, 0, 100, 50);
    CGSize radii = CGSizeMake(10.0f, 10.0f);
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft cornerRadii:radii];
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
  
    
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 100, 50)];
    imageView.image = [UIImage imageNamed:@"test.jpg"];
    imageView.layer.mask = layer;
    
    
    [self.view addSubview:imageView];
    
}
//使用textLayer 绘制文本
-(void)createTextLayer{
    CATextLayer * layer = [CATextLayer layer];
    layer.frame = CGRectMake(100, 200, 100, 50);
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    layer.wrapped = YES;
    layer.alignmentMode = kCAAlignmentJustified;
    UIFont * font = [UIFont systemFontOfSize:15.0f];
    CGFontRef fontname = CGFontCreateWithFontName((__bridge CFStringRef)font.fontName);
    layer.font = fontname;
    layer.fontSize = font.pointSize;
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.foregroundColor = [UIColor whiteColor].CGColor;
    layer.string = @"hello";
}


@end
