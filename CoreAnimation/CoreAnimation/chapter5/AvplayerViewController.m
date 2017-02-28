//
//  AvplayerViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/28.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "AvplayerViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface AvplayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *playerView;

@end

@implementation AvplayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"background" ofType:@".mp4"];
    NSURL * url = [NSURL fileURLWithPath:path];
    AVPlayer * player = [AVPlayer playerWithURL:url];
    AVPlayerLayer * avLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    avLayer.frame = self.playerView.bounds;
    avLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.playerView.layer addSublayer:avLayer];
    
    [player play];
}

- (IBAction)startRotation:(id)sender {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    transform = CATransform3DMakeRotation(M_PI , 0, 1, 0);
    [UIView animateWithDuration:2.0 animations:^{
        self.playerView.layer.transform = transform;
    }];
}


@end
