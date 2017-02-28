//
//  ScalingfilterViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/28.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "ScalingfilterViewController.h"

@interface ScalingfilterViewController ()
@property (weak, nonatomic) IBOutlet UIView *imageView1;

@property (weak, nonatomic) IBOutlet UIView *imageView2;
@property (weak, nonatomic) IBOutlet UIView *imageView4;
@property (weak, nonatomic) IBOutlet UIView *imageView3;
@property (weak, nonatomic) IBOutlet UIView *imageView5;
@property (weak, nonatomic) IBOutlet UIView *imageView6;


@property (nonatomic,strong) NSArray * digitViews;
@end

@implementation ScalingfilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage * image = [UIImage imageNamed:@"disgt@2x.png"];
    _digitViews = @[_imageView1,_imageView2,_imageView3,_imageView4,_imageView5,_imageView6];
    for (UIImageView * imgView in _digitViews) {
        imgView.layer.contents = (__bridge id)image.CGImage;
        imgView.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.0);
        imgView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        imgView.layer.contentsGravity = kCAGravityResizeAspect;
//        imgView.layer.magnificationFilter = kCAFilterNearest;
    }
    
    NSTimer * timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(clockRun) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    
    
    //create opaque button
    UIButton *button1 = [self customButton];
    button1.center = CGPointMake(100, 50);
    [self.view addSubview:button1];
    
    //create translucent button
    UIButton *button2 = [self customButton];
    button2.center = CGPointMake(250, 50);
    button2.alpha = 0.5;
    [self.view addSubview:button2];
//    button2.layer.shouldRasterize = YES;
//    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
    //enable rasterization for the translucent button
//    button2.layer.shouldRasterize = YES;
//    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
}


- (void)setDigit:(NSInteger)digit forView:(UIView *)view
{
    //adjust contentsRect to select correct digit
    view.layer.contentsRect = CGRectMake(digit * 0.1, 0, 0.1, 1.0);
}

-(void)clockRun{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierRepublicOfChina];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents * components = [calendar components:units fromDate:[NSDate date]];
    
    //set hours
    [self setDigit:components.hour / 10 forView:self.digitViews[0]];
    [self setDigit:components.hour % 10 forView:self.digitViews[1]];
    
    //set minutes
    [self setDigit:components.minute / 10 forView:self.digitViews[2]];
    [self setDigit:components.minute % 10 forView:self.digitViews[3]];
    
    //set seconds
    [self setDigit:components.second / 10 forView:self.digitViews[4]];
    [self setDigit:components.second % 10 forView:self.digitViews[5]];

}
- (UIButton *)customButton
{
    //create button
    CGRect frame = CGRectMake(0, 0, 150, 50);
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor orangeColor];
    button.layer.cornerRadius = 10;
    
    //add label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = @"Hello World";
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    
    return button;
}


@end
