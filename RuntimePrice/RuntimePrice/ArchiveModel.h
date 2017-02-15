//
//  ArchiveModel.h
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/15.
//  Copyright © 2017年 lt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ArchiveModel : NSObject<NSSecureCoding>

@property (nonatomic,copy) NSString * name;

@property (nonatomic,strong) NSNumber * age;

@property (nonatomic,assign) NSInteger  count;

@property (nonatomic,strong) UIImage * image;

@end
