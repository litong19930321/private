//
//  HitTestViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/27.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "HitTestViewController.h"

@interface HitTestViewController ()
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (strong, nonatomic) CALayer * layer;
@end

@implementation HitTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _layer = [CALayer layer];
    _layer.frame = CGRectMake(50, 50, 50, 50);
    _layer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.blueView.layer addSublayer:_layer];
    
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
//    
//    touchPoint = [self.view.layer convertPoint:touchPoint toLayer:self.blueView.layer];
//    if ([self.blueView.layer containsPoint:touchPoint]) {
//        touchPoint = [self.blueView.layer convertPoint:touchPoint toLayer:self.layer];
//        if ([self.layer containsPoint:touchPoint]) {
//            NSLog(@"layer");
//        }else{
//            NSLog(@"blueView.layer");
//        }
//    }else{
//        NSLog(@"self.view.layer");
//    }
//}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];

    CALayer * layer = [self.view.layer hitTest:touchPoint];
    if (layer == self.layer) {
        NSLog(@"layer");
    }else if(layer == self.blueView.layer){
        NSLog(@"self.blue.layer");
    }else{
        NSLog(@"self.view.layer");
    }
}


@end
