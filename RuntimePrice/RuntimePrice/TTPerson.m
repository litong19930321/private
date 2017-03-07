//
//  TTPerson.m
//  RuntimePrice
//
//  Created by 李曈 on 2017/3/4.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "TTPerson.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "TTCar.h"
@implementation TTPerson

-(id)copyWithZone:(NSZone *)zone{
    TTPerson * person = [TTPerson allocWithZone:zone];
    person.name = self.name;
    return person;
}
-(void)say{
    NSLog(@"hello");
 
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        [self setValue:[aDecoder decodeObjectForKey:@"name"] forKey:@"name"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:[self valueForKey:@"name"] forKey:@"name"];
}
+(BOOL)supportsSecureCoding{
    return YES;
}
//-(instancetype)copyWithZone:(NSZone *)zone{
//    TTPerson * person = [TTPerson allocWithZone:zone];
//    _.name = self.name;
//    return person;
//}

-(BOOL)isEqual:(id)object{
    if (self == object) {
        return YES;
    }else{
        TTPerson * person = (TTPerson *)object;
        if ([self.name isEqualToString:person.name]) {
            return YES;
        }
    }
    return NO;
}


//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    TTCar * car = [TTCar new];
//    if ([car respondsToSelector:aSelector]) {
//        return car;
//    }
//    return nil;
//}

-(void)forwardInvocation:(NSInvocation *)anInvocation{
//    [anInvocation setSelector:@selector(say)];
    
    [anInvocation setSelector:@selector(run)];
    //然后转发给这个对象
    [anInvocation invokeWithTarget:[TTCar new]];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    //先返回一个方法的签名
    NSMethodSignature * sig = [TTCar instanceMethodSignatureForSelector:@selector(run)];
    return sig;
}
@end
