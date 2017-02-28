//
//  ReplicatorViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/28.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "ReplicatorViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TTImageView : UIImageView

@end

@implementation TTImageView

+(Class)layerClass{
    
    return [CAReplicatorLayer class];
}

-(void)setUp{
    CAReplicatorLayer * layer = (CAReplicatorLayer *)self.layer;
    layer.instanceCount = 2;
    
    CATransform3D transform = CATransform3DIdentity;
    
    transform = CATransform3DTranslate(transform, 0, self.bounds.size.height + 2, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    layer.instanceTransform = transform;
    layer.backgroundColor = [UIColor orangeColor].CGColor;
//    layer.contents = (__bridge id)[UIImage imageNamed:@"test.jpg"].CGImage;
    layer.instanceAlphaOffset = -0.5;
//    [self.layer addSublayer:layer];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}



@end

@interface ReplicatorViewController ()
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UIImageView *mainImgView;

@end

@implementation ReplicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createReplicator];
    [self showDaoYing];
   
}

-(void)createReplicator{
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.containView.bounds;
    [self.containView.layer addSublayer:replicator];
    
    //configure the replicator
    replicator.instanceCount = 10;
    
    //apply a transform for each instance
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 200, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    replicator.instanceTransform = transform;
    
    //apply a color shift for each instance
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    
    //create a sublayer and place it inside the replicator
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
}

-(void)showDaoYing{
//    CAReplicatorLayer * replicator = [CAReplicatorLayer layer];
//    replicator.frame = self.mainImgView.bounds;
//    [self.mainImgView.layer addSublayer:replicator];
//    replicator.contents = (__bridge id)[UIImage imageNamed:@"test.jpg"].CGImage;
//    replicator.instanceCount = 2;
//    
//    CATransform3D transform = CATransform3DIdentity;
//    transform = CATransform3DTranslate(transform, 0, self.mainImgView.bounds.size.height, 0);
//    transform = CATransform3DScale(transform, 1, -1, 0);
//    replicator.instanceTransform = transform;
//    replicator.instanceAlphaOffset = -0.3;
   
    
    TTImageView * ima = [[TTImageView alloc] initWithFrame:CGRectMake(100, 300, 200, 150)];

    [self.view addSubview:ima];

}

@end




















