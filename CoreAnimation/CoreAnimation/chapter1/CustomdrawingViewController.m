//
//  CustomdrawingViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/27.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "CustomdrawingViewController.h"

@interface BlueView : UIView

@end

@implementation BlueView

-(void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx,[UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, self.bounds);
}

@end

@interface CustomdrawingViewController ()<CALayerDelegate>

@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation CustomdrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建layer
    CALayer * layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(50, 50, 100, 100);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.delegate = self;
    layer.contentsScale = [UIScreen mainScreen].scale;
    [self.layerView.layer addSublayer:layer];
    //调用layer的代理方法
    [layer display];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx,[UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

@end
