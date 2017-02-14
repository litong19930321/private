//
//  UIImage+ImageName.m
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/14.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "UIImage+ImageName.h"
#import <objc/runtime.h>

static const char  * strKey = "name";

@implementation UIImage (ImageName)
/**
 *    其实主要是在分类中声明的属性
 *    系统没有给自动生成相应的 get set方法
 *
 */
-(NSString *)name{
    return objc_getAssociatedObject(self, strKey);
}

-(void)setName:(NSString *)name{
    objc_setAssociatedObject(self, strKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
