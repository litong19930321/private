//
//  ContentRectViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/27.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "ContentRectViewController.h"

@interface ContentRectViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *firstImgView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImgView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImgView;
@property (weak, nonatomic) IBOutlet UIImageView *lastImgView;

@end

@implementation ContentRectViewController
// contentsRect在app中最有趣的地方在于一个叫做image sprites（图片拼合）的用法
// 相比多次载入不同的图片，这样做能够带来很多方面的好处：内存使用，载入时间，渲染性能等等
// 默认的contentsRect是{0, 0, 1, 1}，这意味着整个寄宿图默认都是可见的，如果我们指定一个小一点的矩形，图片就会被裁剪
- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage * image = [UIImage imageNamed:@"test.jpg"];
    
    [self addpartImg:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:_firstImgView.layer];
    [self addpartImg:image withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:_secondImgView.layer];
    [self addpartImg:image withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:_thirdImgView.layer];
    [self addpartImg:image withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:_lastImgView.layer];
}
-(void)addpartImg:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer{
    
    layer.contentsScale = [UIScreen mainScreen].scale;//此处应该保持跟手机的 点/pix比例一样
    //layer的contents属性 接受的是CGImageRef类型，但是CGImageRef类型有事 core Foundation中的所有用brige进行桥接
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsRect = rect;
    layer.contentsGravity = kCAGravityResizeAspect;
}



@end
