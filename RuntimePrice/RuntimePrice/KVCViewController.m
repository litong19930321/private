//
//  KVCViewController.m
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/15.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "KVCViewController.h"
#import "KVCModel.h"
#import <objc/runtime.h>
#import "NSObject+DLIntrospection.h"
#import "KVCModel_Private.h"
#import "Car.h"
#import "Student.h"
#import "Car+Test.h"
#import "Car.h"
#import "MJExtension.h"
@interface KVCViewController (){
    KVCModel * _kvcModel;
}

@end

@implementation KVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    KVCModel * model = [[KVCModel alloc] init];
    
    [model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    model.name = @"danker";

//     [model removeObserver:self forKeyPath:@"name"];
//    [model addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
//    [model setValue:@20 forKey:@"age"];
//    _kvcModel = model;
//    [model removeObserver:self forKeyPath:@"age"];
//    model.creditCardPassword = @"私有的";
   
    //测试是否不重写子类  会不会报错
//    Student * stu = [[Student alloc] init];
//    ((void (*)(id,SEL))objc_msgSend)(stu,@selector(mustRewrite));
    //测试如何在分类重写 原类的方法后 调用原类的方法
//    Car * car = [Car new];
//    if (car) {
//        unsigned int count;
//        Method * methodlists = class_copyMethodList([Car class], &count);
//        SEL sel = NULL;
//        IMP imp = NULL;
//        for (int i = 0; i < count; i ++) {
//            Method  method = methodlists[i];
//            NSString * methodName = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
//            NSLog(@"%@",methodName);
//            if ([methodName isEqualToString:@"run:"]) {
//                sel = method_getName(method);
//                imp = method_getImplementation(method);
//            }
//        }
//        ((void (*) (id,SEL,NSNumber *))imp)((id)car,sel,@100);
//    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
}




@end
