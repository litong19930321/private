//
//  Student.m
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/15.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "Student.h"

@implementation Student
//+ (void)initialize
//{
//    if (self == [Person class]) {
//        NSLog(@"调用 initialize 方法");
//    }
//}

//子类如果不重写 则会直接抛出错误  
-(void)mustRewrite{
    NSLog(@"rewrite");
}
@end
