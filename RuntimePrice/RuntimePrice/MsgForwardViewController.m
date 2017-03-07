//
//  MsgForwardViewController.m
//  RuntimePrice
//
//  Created by 李曈 on 2017/3/4.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "MsgForwardViewController.h"
#import "TTPerson.h"
#import "TTCar.h"
#import <objc/runtime.h>
@interface MsgForwardViewController ()

@end

@implementation MsgForwardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    TTPerson * peroson = [[TTPerson alloc] init];
    peroson.name = @"oldname";
    NSLog(@"out : %p",peroson);
    void (^myblock)() = ^{
        peroson.name = @"newname";
        NSLog(@"in : %p",peroson);
    };
    NSLog(@"before name : %@",peroson.name);
    myblock();
    NSLog(@"after name : %@",peroson.name);
    
    
//    [self testForwardingTargetForSelector];
//    
//    NSString * one = @"one";
//    NSString * two = @"two";
//    NSMutableArray * marr = [[NSMutableArray alloc] initWithObjects:one,two, nil];
//    NSArray * arr = [marr copy];
//    
//    NSLog(@"one : %p",one);
//    NSLog(@"marr[0] : %p,marr[1] : %p",marr[0],marr[1]);
//    one = marr[0];
//    NSLog(@"newone : %p",one);
//    NSLog(@"marr[0] : %p,marr[1] : %p",marr[0],marr[1]);
//    NSLog(@"arr[0] : %p,arr[1] : %p",arr[0],arr[1]);
//    NSLog(@"arr:%@",arr);
//    NSLog(@"marr:%@",marr);
    
//    TTPerson * person_1 = [TTPerson new];
//    [person_1 setValue:@"name" forKey:@"name"];
    
   
    
    
//    person_1.name = @"name1";
//    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test.data"];
//    [NSKeyedArchiver archiveRootObject:person_1 toFile:path];
//    
//    TTPerson * newPeroson = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    
    
}
//测试  备援接受者
-(void)testForwardingTargetForSelector{
    TTPerson * person = [TTPerson new];
//    [person performSelector:@selector(hello)];
  
    
}
//测试完整消息转发
-(void)testMethoForwarding{
    
}
@end
