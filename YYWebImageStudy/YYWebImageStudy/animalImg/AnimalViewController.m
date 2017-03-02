//
//  AnimalViewController.m
//  YYWebImageStudy
//
//  Created by 李曈 on 2017/3/2.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "AnimalViewController.h"
#import "YYAnimatedImageView.h"
#import "YYWebImage.h"
#import "YYImage.h"
//@"http://i.imgur.com/uoBwCLj.gif",
//@"http://i.imgur.com/8KHKhxI.gif",
//@"http://i.imgur.com/WXJaqof.gif",
@interface AnimalViewController ()
@property (nonatomic, strong) YYAnimatedImageView * mainAnimalImg;


@end

@implementation AnimalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createAnimal];
}

-(void)createAnimal{
    _mainAnimalImg = [[YYAnimatedImageView alloc] init];
    _mainAnimalImg.backgroundColor = [UIColor orangeColor];
    _mainAnimalImg.frame = CGRectMake(0, 0, 300, 200);
    _mainAnimalImg.center = self.view.center;
    _mainAnimalImg.contentMode = UIViewContentModeScaleAspectFit;
    YYImage * image = [YYImage imageNamed:@"gif.gif"];
    _mainAnimalImg.image = image;
    

//    _mainAnimalImg.autoPlayAnimatedImage = YES;
//    [_mainAnimalImg startAnimating];
    [self.view addSubview:_mainAnimalImg];
}
- (IBAction)startSetImg:(id)sender {
    
    _mainAnimalImg.image = nil;
    YYAnimatedImageView * animatedView = [[YYAnimatedImageView alloc] init];
    animatedView.frame = CGRectMake(0, 0, 200, 150);
    animatedView.center = self.view.center;
    [self.view addSubview:animatedView];
    YYImage * image = [YYImage imageNamed:@"test.gif"];
    animatedView.image = image;
     _mainAnimalImg.image = image;
}



@end
