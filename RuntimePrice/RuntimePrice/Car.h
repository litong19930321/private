//
//  Car.h
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/15.
//  Copyright © 2017年 lt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject<NSCoding>{
    NSNumber * price;//成员变量
}

@property (nonatomic, copy) NSString * name;

@property (nonatomic, assign) NSNumber * displacement;

@property (nonatomic, copy) NSString * type;

@property (nonatomic, strong) NSDictionary * configure;

@end
