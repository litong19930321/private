//
//  Layer0flatteningViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/28.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "Layer0flatteningViewController.h"

@interface Layer0flatteningViewController ()
@property (weak, nonatomic) IBOutlet UIView *outSideView;
@property (weak, nonatomic) IBOutlet UIView *inSideView;

@end

@implementation Layer0flatteningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
//先绕着Z轴转
- (IBAction)start:(id)sender {
    
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI/4, 0, 0, 1);
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI/4, 0, 0, 1);
    //如果内部图层相对外部图层做了相反的变换（这里是绕Z轴的旋转），那么按照逻辑这两个变换将被相互抵消
    [UIView animateWithDuration:2.0 animations:^{
        _outSideView.layer.transform = transform1;
        _inSideView.layer.transform = transform2;
    } completion:^(BOOL finished) {
        
    }];
    
}
//在相同场景下的任何3D表面必须和同样的图层保持一致，这是因为每个的父视图都把它的子视图扁平化了。
- (IBAction)startY:(id)sender {
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI/4, 0,1, 0);
    transform1.m34 = -1.0/500;
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI/4, 0, 1, 0);
    transform2.m34 = -1.0/500;
    [UIView animateWithDuration:2.0 animations:^{
        _outSideView.layer.transform = transform1;
//        _inSideView.layer.transform = transform2;
    } completion:^(BOOL finished) {
        
    }];
}


@end
