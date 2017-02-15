//
//  MJFoundation.h
//  MJExtensionExample
//
//  Created by MJ Lee on 14/7/16.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJFoundation : NSObject

/**

 @param c class
 @return   定义了一个集合 如果类属于集合中 则返回YES  否则返回NO
 */
+ (BOOL)isClassFromFoundation:(Class)c;
@end
