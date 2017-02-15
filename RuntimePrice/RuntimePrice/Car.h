//
//  Car.h
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/15.
//  Copyright © 2017年 lt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/objc-runtime.h>
@interface Car : NSObject<NSSecureCoding>{
    NSNumber * price;//成员变量
}

@property (nonatomic, copy) NSString * name;

@property (nonatomic, assign) NSNumber * displacement;

@property (nonatomic, copy) NSString * type;

@property (nonatomic, strong) NSDictionary * configure;
//Name	Typedef	Header	True Value	False Value
//BOOL	signed char	objc.h	YES	NO
//bool	_Bool (int)	stdbool.h	true	false
//Boolean	unsigned char	MacTypes.h	TRUE	FALSE
//NSNumber	__NSCFBoolean	Foundation.h	@(YES)	@(NO)
//CFBooleanRef	struct	CoreFoundation.h	kCFBooleanTrue	kCFBooleanFalse
@property (nonatomic, assign) bool afterFlooding;//用于测试bool类型的值 b或c

@property (nonatomic, assign) Method method;
@end
