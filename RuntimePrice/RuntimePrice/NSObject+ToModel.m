//
//  NSObject+ToModel.m
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/14.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "NSObject+ToModel.h"
#import <objc/runtime.h>
@implementation NSObject (ToModel)

+(instancetype)modelWithDictionary:(NSDictionary *)dict{
    id objc = [[self alloc] init];
    unsigned int count;
    Ivar * ivars =  class_copyIvarList(self, &count);
    
    for (int i = 0; i < count; i ++) {
        //取出model的属性
        Ivar ivar = ivars[i];
        NSString * propName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSLog(@"propName : %@",propName);
        //因为打印出来的属性值前面都是带_，所以要先进行截取
        propName = [propName substringFromIndex:1];
        //然后从字典里拿取对应的值
        if ([dict objectForKey:propName]) {
            [objc setValue:[dict objectForKey:propName] forKey:propName];
        }
    }
    return objc;
}

@end
