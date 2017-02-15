//
//  Car.m
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/15.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "Car.h"
#import <objc/runtime.h>
@implementation Car


//用于将model 归档 实现NSCODING协议
-(id)initWithCoder:(NSCoder *)aCoder{
    if (self = [super init]) {
        unsigned int count;
        Ivar * ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            NSString * name = [NSString stringWithUTF8String:ivar_getName(ivar)];
            [self setValue:[aCoder decodeObjectForKey:name] forKey:name];
        }
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int outCount;
    Ivar * ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}
+(BOOL)supportsSecureCoding{
    return YES;
}
@end
