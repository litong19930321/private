//
//  WebImgViewController.m
//  YYWebImageStudy
//
//  Created by 李曈 on 2017/2/21.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "WebImgViewController.h"
#import "YYWebImage.h"
#import <ImageIO/ImageIO.h>
#import "Person.h"
#import <objc/objc-runtime.h>
#import <pthread.h>
#import "YYAnimatedImageView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width -20
#define kCellHeight ceil((kScreenWidth) * 3.0 / 4.0)
typedef void(^TestBlock)(NSString * name);

@interface WebImgViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView_first;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_secend;
@property (nonatomic, strong) UIImageView * mainImageView;

@property (nonatomic,strong) CAShapeLayer * progressLayer;//进度条指示器

@end

@implementation WebImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainImageView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(10,70,kScreenWidth, kCellHeight)];
    _mainImageView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_mainImageView];
}





- (IBAction)startRequestImg:(id)sender {
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = CGRectMake(0, 0, _mainImageView.frame.size.width,  _mainImageView.frame.size.width);
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 2)];
    [path addLineToPoint:CGPointMake( _mainImageView.frame.size.width, 2)];
    _progressLayer.path = path.CGPath;
    _progressLayer.strokeColor = [UIColor colorWithRed:0.000 green:0.640 blue:1.000 alpha:0.720].CGColor;
    _progressLayer.lineCap = kCALineCapButt;
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd = 0;
    _progressLayer.lineWidth = 4;
    [_mainImageView.layer addSublayer:_progressLayer];
    NSURL * url = [NSURL URLWithString:@"https://s-media-cache-ak0.pinimg.com/1200x/2e/0c/c5/2e0cc5d86e7b7cd42af225c29f21c37f.jpg"];
    [_mainImageView yy_setImageWithURL:url placeholder:nil options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@"%ld",receivedSize);
        CGFloat progress = (CGFloat)receivedSize / expectedSize;
        progress = progress < 0 ? 0 : progress > 1 ? 1  : progress;
        if (_progressLayer.hidden) {
            _progressLayer.hidden = NO;
        }
        _progressLayer.strokeEnd = progress;
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        _progressLayer.hidden = YES;
    }];
    
}
- (IBAction)removeImg:(id)sender {
    [self.imageView_first setImage:nil];
    
    dispatch_queue_t queue = dispatch_queue_create("com.lt.test", DISPATCH_QUEUE_SERIAL);
    NSLog(@"hello1");
    dispatch_async(queue, ^{
         NSLog(@"hello3");
        dispatch_async(queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                 NSLog(@"hello4");
            });
        });
    });
    dispatch_async(queue, ^{
        NSLog(@"hello5");
        dispatch_async(queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"hello6");
            });
        });
    });
     NSLog(@"hello2");
}

- (IBAction)test:(id)sender {
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",path);
}




@end
