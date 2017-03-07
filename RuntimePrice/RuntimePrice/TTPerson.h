//
//  TTPerson.h
//  RuntimePrice
//
//  Created by 李曈 on 2017/3/4.
//  Copyright © 2017年 lt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTPerson : NSObject<NSSecureCoding,NSCopying>

@property (nonatomic,copy) NSString * name;
-(void)say;


@end
