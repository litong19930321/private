//
//  Person.m
//  YYWebImageStudy
//
//  Created by 李曈 on 2017/2/21.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "Person.h"



@implementation Person

@synthesize name = _name;

-(void)setName:(NSString *)name{
    _name = name;
}
-(NSString *)name{
    return _name;
}
+(BOOL)automaticallyNotifiesObserversOfName{
    return false;
}
@end
