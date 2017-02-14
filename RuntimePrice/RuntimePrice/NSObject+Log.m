//
//  NSObject+Log.m
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/14.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "NSObject+Log.h"

@implementation NSObject (Log)


//自动打印属性字符串
+(void)resoveDict:(NSDictionary *)dict{
    //拼接属性字符串代码
    NSMutableString * mStr = [NSMutableString string];
    //遍历字典，把字典中的所有key取出来生成对应的属性
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString * type;
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFString")]) {
            type = @"NSString";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFArray")]){
            type = @"NSArray";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){
            type = @"NSDictionary";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
            type = @"NSNumber";
        }
        
        // 属性字符串
        NSString *str;
        if ([type containsString:@"NS"]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, strong) %@ *%@;",type,key];
        }else{
            str = [NSString stringWithFormat:@"@property (nonatomic, assign) %@ %@;",type,key];
        }
        
        // 每生成属性字符串，就自动换行。
        [mStr appendFormat:@"\n%@\n",str];
        
        NSLog(@"%@",mStr);
    }];
}

@end
