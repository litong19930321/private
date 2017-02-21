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

typedef void(^TestBlock)(NSString * name);

@interface WebImgViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView_first;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_secend;

@end

@implementation WebImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person * person = [Person new];
    person.name = @"hah";
    
    
    
    
}





- (IBAction)startRequestImg:(id)sender {
    [self.imageView_first yy_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/-0U0bnSm1A5BphGlnYG/tam-ogel/f153812406eddc1c6a6d2b1f505ec76d_254_144.jpg"] placeholder:nil options:YYWebImageOptionProgressive completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        NSLog(@"%@",[NSThread currentThread]);
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





@end
