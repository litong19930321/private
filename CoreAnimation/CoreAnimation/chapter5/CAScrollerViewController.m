//
//  CAScrollerViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/28.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "CAScrollerViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ScrollView : UIView


@end

@implementation ScrollView

+(Class)layerClass{
    return [CAScrollLayer class];
}

-(void)setUp{
    self.layer.masksToBounds = YES;
    UIPanGestureRecognizer * pan = nil;
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}
- (id)initWithFrame:(CGRect)frame
{
    //this is called when view is created in code
    if ((self = [super initWithFrame:frame])) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //this is called when view is created from a nib
    [self setUp];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer
{
    //get the offset by subtracting the pan gesture
    //translation from the current bounds origin
    CGPoint offset = self.bounds.origin;
    offset.x -= [recognizer translationInView:self].x;
    offset.y -= [recognizer translationInView:self].y;
    
    //scroll the layer
    [(CAScrollLayer *)self.layer scrollToPoint:offset];
    
    //reset the pan gesture translation
    [recognizer setTranslation:CGPointZero inView:self];
}
@end




@interface CAScrollerViewController ()

@end

@implementation CAScrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


@end
