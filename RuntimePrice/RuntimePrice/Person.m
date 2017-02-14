//
//  Person.m
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/14.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
@implementation Person


//无参数无返回值
-(void)eat{
    NSLog(@"%s was called, and it has no arguments and return value", __FUNCTION__);
}
//有参数无返回值
-(void)eat:(NSString *)arg1{
    NSLog(@"%s was called, and it has one arguments %@ and return value", __FUNCTION__,arg1);
}
//无参数有返回值
-(NSString *)eat_noarg_returnvalue{
    NSLog(@"%s was called, and it has no arguments but has return value", __FUNCTION__);
    return @"不带参数，有返回值";
}
//带参数带返回值
-(NSString *)eat_arg_returnvalue{
    NSLog(@"%s was called, and it has no arguments but has return value", __FUNCTION__);
    return @"带参数，有返回值";
}
void  running (id self,SEL sel){
    NSLog(@"running");
}
+(BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(running)) {
        //动态添加run的方法
        //可以把这句注释掉 然后加断点 看看下一步走哪个方法
        class_addMethod(self,@selector(running),(IMP)running,"v@:");
    }
    return [super resolveInstanceMethod:sel];
}

/**
 重新签名方法 此方法在 resolveinstanceMethod之后调用 防止崩溃的挽留方法
 @param aSelector 方法名
 @return 方法签名
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if ([self respondsToSelector:aSelector]) {
        return [super methodSignatureForSelector:aSelector];
    }else{
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
}
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"注册一个没有 实现的方法");
}
-(void)dream{
    NSLog(@"dream");
}
-(void)sleep{
    NSLog(@"sleep");
}
@end
