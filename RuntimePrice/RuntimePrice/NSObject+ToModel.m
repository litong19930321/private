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
        //取出model的成员变量  如果只取出 @propety的话 应该用 objc_propety_t
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
//属性类型  name值：T  value：变化
//编码类型  name值：C(copy) &(strong) W(weak) 空(assign) 等 value：无
//非/原子性 name值：空(atomic) N(Nonatomic)  value：无
//变量名称  name值：V  value：变化
+(instancetype)modelWithDictionaryProp:(NSDictionary *)dict{
    id objc = [[self alloc] init];
    unsigned int count;
    //取出所有的属性  (成员变量并没有取出)
    objc_property_t * properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t property = properties[i];
        NSString * propertyName = [NSString stringWithUTF8String:property_getName(property)];
        NSString * propertyAttribute = [NSString stringWithUTF8String:property_getAttributes(property)];
        NSLog(@"属性的名称：%@      属性的描述：%@",propertyName,propertyAttribute);
        
        
        NSString * attrs = @(property_getAttributes(property));
        NSUInteger dotLoc = [attrs rangeOfString:@","].location;
        NSString *code = nil;
        NSUInteger loc = 1;
        if (dotLoc == NSNotFound) { // 没有,
            code = [attrs substringFromIndex:loc];
        } else {
            code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
        }

        NSLog(@"--%@",code);
    }
    return objc;
}
@end
