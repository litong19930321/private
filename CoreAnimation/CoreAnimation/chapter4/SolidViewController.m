//
//  SolidViewController.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/28.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "SolidViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

@interface SolidViewController ()
@property (weak, nonatomic) IBOutlet UIView *containView;

@property (strong, nonatomic)  UIView *face1;
@property (strong, nonatomic)  UIView *face2;
@property (strong, nonatomic)  UIView *face3;
@property (strong, nonatomic)  UIView *face4;
@property (strong, nonatomic)  UIView *face5;
@property (strong, nonatomic)  UIView *face6;

@property (strong, nonatomic) NSMutableArray * faces;

@end

@implementation SolidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    // Do any additional setup after loading the view from its nib.
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.containView.layer.sublayerTransform = perspective;
    //add cube face 1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];
    //add cube face 2
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    //add cube face 3
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
}

-(void)createView{
    _faces = [[NSMutableArray alloc] init];
    for (int i = 0; i < 6; i++) {
        UIView * view  = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, 200, 200);
        int a = arc4random()%255;
        int b = arc4random()%255;
        int c = arc4random()%255;
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        label.textAlignment =NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%d",i + 1];
        label.font = [UIFont systemFontOfSize:20];
        label.center = view.center;
        [view addSubview:label];
        
        view.backgroundColor = [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1];
        [_faces addObject:view];
    }
}
- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform
{
    //get the face view and add it to the container
    UIView *face = self.faces[index];
    [self.containView addSubview:face];
    //center the face view within the container
    CGSize containerSize = self.containView.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    // apply the transform
    face.layer.transform = transform;
    [self applyLightingToFace:face.layer];
}
- (IBAction)rote:(id)sender {
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, -M_PI_4, 1, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_4, 0, 1, 0);
    [UIView animateWithDuration:2.0 animations:^{
        self.containView.layer.sublayerTransform = transform;
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}

@end
