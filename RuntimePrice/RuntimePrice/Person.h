//
//  Person.h
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/14.
//  Copyright © 2017年 lt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
//无参数无返回值
-(void)eat;
//有参数无返回值
-(void)eat:(NSString *)arg1;
//无参数有返回值
-(NSString *)eat_noarg_returnvalue;
//带参数带返回值
-(NSString *)eat_arg_returnvalue;
-(void)dream;
-(void)sleep;
@end
