//
//  AffineTransViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/28.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "AffineTransViewController.h"

@interface AffineTransViewController ()
@property (weak, nonatomic) IBOutlet UIView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *layerVeiw1;
@property (weak, nonatomic) IBOutlet UIImageView *layerView2;
@property (weak, nonatomic) IBOutlet UIView *containView;

@end

@implementation AffineTransViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage * image = [UIImage imageNamed:@"test.jpg"];
    _imgView.layer.contents = (__bridge id)image.CGImage;
    
}

- (IBAction)startRotation:(id)sender {
    //UIView可以通过设置transform属性做变换，但实际上它只是封装了内部图层的变换。
    
    // CALayer同样也有一个transform属性，但它的类型是CATransform3D，而不是CGAffineTransform，本章后续将会详细解释。CALayer对应于UIView的transform属性叫做affineTransform
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI / 4);
    _imgView.layer.affineTransform = transform;
    
}
- (IBAction)startCombin:(id)sender {
    //其实_imgView的默认值是   CGAffineTransformIdentity
    CGAffineTransform transform = _imgView.transform;
    //先缩放50%
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    //在旋转60
    transform = CGAffineTransformRotate(transform, M_PI / 6);
    //在平移x = 50
    transform = CGAffineTransformTranslate(transform, 50, 0);
    [UIView animateWithDuration:2.0 animations:^{
        _imgView.layer.affineTransform = transform;
    } completion:nil];
    
}
- (IBAction)reset:(id)sender {
    _imgView.transform = CGAffineTransformIdentity;
    _layerVeiw1.layer.transform = CATransform3DIdentity;
    _layerView2.layer.transform = CATransform3DIdentity;
}
//倾斜变换
- (IBAction)shearTransform:(id)sender {
    CGAffineTransform sheartransform = CGAffineTransformIdentity;
    sheartransform.c = -1;
    sheartransform.b = 0;
    [UIView animateWithDuration:2.0 animations:^{
        _imgView.layer.affineTransform = sheartransform;
    } completion:nil];
}
//透视投影
- (IBAction)perspective:(id)sender {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    [UIView animateWithDuration:2.0 animations:^{
        _imgView.layer.transform = transform;
    } completion:nil];
}
//sublayertransform属性
- (IBAction)sublayertransform:(id)sender {
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = - 1.0/500.0;
    
    _containView.layer.sublayerTransform = perspective;
    
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    //这个默认值是 yes，图层的两面都进行绘制
    //如果设置为NO的话只绘制正面
    _layerVeiw1.layer.doubleSided = NO;
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    [UIView animateWithDuration:2.0 animations:^{
        self.layerVeiw1.layer.transform = transform1;
        self.layerView2.layer.transform = transform2;
    } completion:nil];
   
    
}



@end
