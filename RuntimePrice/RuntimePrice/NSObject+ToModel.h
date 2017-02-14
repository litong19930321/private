//
//  NSObject+ToModel.h
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/14.
//  Copyright © 2017年 lt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ToModel)
+(instancetype)modelWithDictionary:(NSDictionary *)dict;
@end
