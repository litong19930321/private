//
//  GcdViewController.m
//  GCD_and_OperationStudy
//
//  Created by 李曈 on 2017/2/20.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "GcdViewController.h"

//18410107137
@interface People : NSObject
@property (nonatomic,copy) NSString * name;
@end
@implementation People
@end
@interface GcdViewController ()

@end

@implementation GcdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self dispatch_group];
//    [self nssetTest];
//    [self dispatch_block_cancleDemo];
    
}
//dispatch_group的使用
-(void)dispatch_group{
    dispatch_group_t group = dispatch_group_create();
    
    
    //相当于对group的任务量加一
    dispatch_group_enter(group);
    dispatch_queue_t  queue = dispatch_queue_create("com.lt.gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        sleep(5);
        NSLog(@"第一个任务");
        //相当于对group的任务量减一
        dispatch_group_leave(group);
    });
 
    
     //相当于对group的任务量加一
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"第二个任务");
        //相当于对group的任务量减一
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"所有任务都完成了");
    });
}
//set的测试
-(void)nssetTest{
    People * people = [[People alloc] init];
    people.name = @"ksfsf";
    People * people_1 = [[People alloc] init];
    people_1.name = @"sggrege";
    People * people_2 = [[People alloc] init];
    people_2.name = @"sggrege";
    NSSet * set = [NSSet setWithObjects:people,people_1,people_2,nil];
    NSArray * array = [NSArray arrayWithObjects:people,people_1,people_2,nil];
    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"_name" ascending:YES];
    
    NSArray * sortarray = [set sortedArrayUsingDescriptors:@[sort]];
    
}

//取消block 测试
-(void)dispatch_block_cancleDemo{
        dispatch_queue_t serialQueue = dispatch_queue_create("com.lt", DISPATCH_QUEUE_SERIAL);
        dispatch_block_t firstBlock = dispatch_block_create(0, ^{
            NSLog(@"first block start");
            [NSThread sleepForTimeInterval:2.f];
            NSLog(@"first block end");
        });
        dispatch_block_t secondBlock = dispatch_block_create(0, ^{
            NSLog(@"second block run");
        });
        dispatch_async(serialQueue, firstBlock);
        dispatch_async(serialQueue, secondBlock);
        //取消secondBlock
        dispatch_block_cancel(secondBlock);

}
@end
