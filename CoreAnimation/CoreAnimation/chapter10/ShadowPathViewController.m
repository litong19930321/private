//
//  ShadowPathViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/3/1.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "ShadowPathViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DrawingView : UIView
@property (strong, nonatomic) UIBezierPath * path;
@property (strong, nonatomic) CAShapeLayer * shapLayer;
@end

@implementation DrawingView

+(Class)layerClass{
    return [CAShapeLayer class];
}

-(void)setUp{
    self.path = [UIBezierPath bezierPath];
    
    _shapLayer = [CAShapeLayer layer];
    
    _shapLayer.lineWidth = 1.0f;
    _shapLayer.strokeColor = [UIColor blueColor].CGColor;
    _shapLayer.lineCap = kCALineCapRound;
    _shapLayer.lineJoin = kCALineCapRound;
    _shapLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:_shapLayer];
    
   
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self.path moveToPoint:point];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint poin = [[touches anyObject] locationInView:self];
    [self.path addLineToPoint:poin];
    _shapLayer.path = self.path.CGPath;
}
@end

@interface ShadowPathViewController ()

@end

@implementation ShadowPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    CALayer * layer = [CALayer layer];
//    layer.backgroundColor = [UIColor orangeColor].CGColor;
//    layer.frame = CGRectMake(0, 0, 100, 100);
//    layer.position = self.view.center;
//    [self.view.layer addSublayer:layer];
//    
//    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-25, -25, 150, 150) cornerRadius:5.0f];
//    layer.shadowPath = path.CGPath;
//    layer.shadowOpacity = 0.5f;
//    
//    DrawingView * view = [[DrawingView alloc] init];
//    view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    [self.view addSubview:view];
    
    
    UIImage * image = [UIImage imageNamed:@"test.jpg"];
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 150), NO, [UIScreen mainScreen].scale);
//    UIBezierPath * bpath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 200, 150) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)];
//    CGContextAddPath(UIGraphicsGetCurrentContext(), bpath.CGPath);
//    CGContextClip(UIGraphicsGetCurrentContext());
//    [image drawInRect:CGRectMake(0, 0, 200, 150)];
//    image = UIGraphicsGetImageFromCurrentImageContext();
//    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
//    UIGraphicsEndImageContext();
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
    imageView.image = image;
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.layer.cornerRadius = 10.0f;
    imageView.clipsToBounds = YES;
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
}






















@end
