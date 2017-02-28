//
//  LayoutViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/27.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "LayoutViewController.h"

@interface LayoutViewController ()

@property (nonatomic, strong) UIView * testView;
@property (weak, nonatomic) IBOutlet UIImageView *blueView;
@property (weak, nonatomic) IBOutlet UIImageView *purpleView;

@property (weak, nonatomic) IBOutlet UIImageView *clockImg;
@property (weak, nonatomic) IBOutlet UIImageView *hourImg;
@property (weak, nonatomic) IBOutlet UIImageView *minImg;
@property (weak, nonatomic) IBOutlet UIImageView *secImg;


@end

@implementation LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _testView = [[UIView alloc] init];
    _testView.frame = CGRectMake(50, 50, 60, 60);
    _testView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_testView];
    [self.view setNeedsLayout];
    
    
    [self changeAnchorPoint];
    
}

-(void)changeAnchorPoint{
    //改变三张图片的锚点，anchorPoint
    self.hourImg.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.minImg.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.secImg.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
}


-(void)testTrasform{
    //注意 记住当对图层做变换的时候，比如旋转或者缩放，frame实际上代表了覆盖在图层旋转之后的整个轴对齐的矩形区域，也就是说frame的宽高可能和bounds的宽高不再一致了（图3.2）
    NSLog(@"before%@",NSStringFromCGRect(_testView.frame));
    [UIView animateWithDuration:1.0 animations:^{
        _testView.transform = CGAffineTransformMakeRotation(M_PI/4);
    } completion:^(BOOL finished) {
        NSLog(@"after%@",NSStringFromCGRect(_testView.frame));
    }];
}
-(void)transZPositon{
    //修改图层的显示顺序 只需要修改对应layer的zposition属性就好
    if (_blueView.layer.zPosition > _purpleView.layer.zPosition) {
        _purpleView.layer.zPosition = _blueView.layer.zPosition + 1.0f;
    }else{
        _blueView.layer.zPosition = _purpleView.layer.zPosition + 1.0f;
    }
}

- (IBAction)rotation:(id)sender {
//    [self testTrasform];
//    [self transZPositon];
    
    NSTimer * time = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(clockRun) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:time forMode:NSDefaultRunLoopMode];
}

-(void)clockRun{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierRepublicOfChina];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents * components = [calendar components:units fromDate:[NSDate date]];
    
    CGFloat hourAngle  = (components.hour / 12.0) * M_PI * 2.0;
    CGFloat minAngle  = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secAngle  = (components.second / 60.0) * M_PI * 2.0;
    
    self.hourImg.transform = CGAffineTransformMakeRotation(hourAngle);
    self.minImg.transform = CGAffineTransformMakeRotation(minAngle);
    self.secImg.transform = CGAffineTransformMakeRotation(secAngle);
}
//UIView有三个比较重要的布局属性：frame，bounds和center，CALayer对应地叫做frame，bounds和position。为了能清楚区分，图层用了“position”，视图用了“center”，但是他们都代表同样的值。
//
//frame代表了图层的外部坐标（也就是在父图层上占据的空间），bounds是内部坐标（{0, 0}通常是图层的左上角），center和position都代表了相对于父图层anchorPoint所在的位置。anchorPoint的属性将会在后续介绍到，现在把它想成图层的中心点就好了
//   对于视图或者图层来说，frame并不是一个非常清晰的属性，它其实是一个虚拟属性，是根据bounds，position和transform计算而来，所以当其中任何一个值发生改变，frame都会变化。相反，改变frame的值同样会影响到他们当中的值
@end
