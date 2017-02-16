//
//  KVCModel.m
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/15.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "KVCModel.h"
#import "KVCModel_Private.h"

@implementation KVCModel



-(void)setCreditCardPassword:(NSString *)creditCardPassword{
    _creditCardPassword = creditCardPassword;
}



-(void)willChangeValueForKey:(NSString *)key{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [super willChangeValueForKey:key];
}
-(void)didChangeValueForKey:(NSString *)key{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [super didChangeValueForKey:key];
}

@end
