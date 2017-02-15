//
//  ArchiveModel.m
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/15.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "ArchiveModel.h"
#import <objc/runtime.h>
#import "MJExtension.h"

@implementation ArchiveModel

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        unsigned int count;
        objc_property_t * properties = class_copyPropertyList([self class], &count);
        for (int i = 0; i < count; i ++) {
            objc_property_t property = properties[i];
            NSString * key = [NSString stringWithUTF8String:property_getName(property)];
            NSString *attrs = @(property_getAttributes(property));
            NSUInteger dotLoc = [attrs rangeOfString:@","].location;
            NSString *code = nil;
            NSUInteger loc = 1;
            if (dotLoc == NSNotFound) { // 没有,
                code = [attrs substringFromIndex:loc];
            } else {
                //此处获取出成员变量的类型  比如 数组类型 @"NSArray"
                code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
            }
            id value = nil;
            value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        
    }
    return self;
}

+(BOOL)supportsSecureCoding{
    return YES;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count;
    objc_property_t * properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t property = properties[i];
        NSString * key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *attrs = @(property_getAttributes(property));
        NSUInteger dotLoc = [attrs rangeOfString:@","].location;
        NSString *code = nil;
        NSUInteger loc = 1;
        if (dotLoc == NSNotFound) { // 没有,
            code = [attrs substringFromIndex:loc];
        } else {
            //此处获取出成员变量的类型  比如 数组类型 @"NSArray"
            code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
        }
        id value = [self valueForKey:key];
         [aCoder encodeObject:value forKey:key];
    }
}

@end
