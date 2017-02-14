//
//  ViewController.m
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/14.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "Person.h"
#import "UIImage+ImageName.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //此处是关于objc_msgSend的相关内容
//    void (*msgSend) (id,SEL);
//    msgSend = (void (*) (id,SEL))[self methodForSelector:@selector(question_AboutSendMsg)];
//    msgSend(self,@selector(question_AboutSendMsg));
//    ((void (*) (id,SEL))objc_msgSend)(self,@selector(question_AboutSendMsg));
    
    //给分类增加 属性的测试
    [self addPropetyForCategory];
//    void (*categoryPropety) (id,SEL);
//    categoryPropety = (void (*) (id,SEL))[self methodForSelector:@selector(addPropetyForCategory)];
//    categoryPropety(self,@selector(addPropetyForCategory));
    
    //交换方法的测试
    ((void (*) (id,SEL))objc_msgSend)(self,@selector(exchangeMethod));
    ((void (*) (id,SEL))objc_msgSend)(self,@selector(exchangeMethod));
}
#pragma mark ---- 关于sendMsg问题
-(void)question_AboutSendMsg{
    Person * p = [[Person alloc] init];
    // 1.直接用对象调用方法
    //    [p eat];      //此句的效果如下
    ((void (*)(id, SEL))objc_msgSend)((id)p, @selector(eat));
    // 2.调用一个有参数无返回值的
    //    [p eat:@"chocolates"];
    ((void (*) (id,SEL,id))objc_msgSend)((id)p,@selector(eat:),@"巧克力");
    // 3.调用无参数无返回值方法
    // [p eat_noarg_returnvalue];
    id value_1 = ((id (*) (id,SEL))objc_msgSend)((id)p,@selector(eat_noarg_returnvalue));
    NSLog(@"%@",value_1);
    // 4.带参数带返回值
    // [p eat_noarg_returnvalue];
    id value_2 = ((id (*) (id,SEL,id arg))objc_msgSend)((id)p,@selector(eat_arg_returnvalue),@"巧克力");
    NSLog(@"%@",value_2);
    //  5.动态的增加方法，在Person类中 如果收到msg_send(self,@@selector(running))中 自动创建running 方法
    ((void (*) (id,SEL))objc_msgSend)((id)p,@selector(running));
    
    /*
     * On some architectures, use objc_msgSend_stret for some struct return types. //结构体
     * On some architectures, use objc_msgSend_fpret for some float return types.  //浮点数
     * On some architectures, use objc_msgSend_fp2ret for some float return types.
     */
}
#pragma mark ---- 动态给分类添加属性
-(void)addPropetyForCategory{
    UIImage * image = [[UIImage alloc] init];
    image.name = @"第一张图片";
    NSLog(@"image.imageName is %@",image.name);
}
#pragma mark ---- exchangeMethod
-(void)exchangeMethod{
    Method method_1 = class_getInstanceMethod([Person class], @selector(sleep));
    Method method_2 = class_getInstanceMethod([Person class], @selector(dream));
    method_exchangeImplementations(method_1, method_2);
    Person * p = [[Person alloc] init];
    //原本输出应该是 sleep dream  ,交换之后的输出 为 dream  sleep
    //注意防止多次交换带来的问题
    [p sleep];
    [p dream];
    
}
@end