//
//  BarrierViewController.m
//  GCD_and_OperationStudy
//
//  Created by 李曈 on 2017/2/20.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "BarrierViewController.h"
/*
dispatch_barrier_sync和dispatch_barrier_async的不共同点：
在将任务插入到queue的时候，dispatch_barrier_sync需要等待自己的任务（0）结束之后才会继续程序，然后插入被写在它后面的任务（4、5、6），然后执行后面的任务
而dispatch_barrier_async将自己的任务（0）插入到queue之后，不会等待自己的任务结束，它会继续把后面的任务（4、5、6）插入到queue

所以，dispatch_barrier_async的不等待（异步）特性体现在将任务插入队列的过程，它的等待特性体现在任务真正执行的过程。
 共同点：
 都会阻塞当前队列，等待自己的任务完成之后才会让队列的后续任务完成
 */
@interface BarrierViewController ()

@end

@implementation BarrierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test_barrier_async];
}
//关于  dispatch_barrier_async
-(void)test_barrier_async{
    
    dispatch_queue_t queue = dispatch_queue_create("test_1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1");
    });
    dispatch_async(queue, ^{
        NSLog(@"2");
    });
    dispatch_async(queue, ^{
        NSLog(@"3");
    });
    dispatch_barrier_async(queue, ^{
        for (NSInteger i = 0 ; i < 10000000; i ++) {
            if (i == 231231) {
                NSLog(@"%ld",i);
            }else if (i == 931231){
                NSLog(@"%ld",i);
            }
        }
        NSLog(@"阻塞执行barrier");
//        sleep(2);
    });
    NSLog(@"aaa");
    dispatch_async(queue, ^{
//        sleep(1);
        NSLog(@"4");
    });
    dispatch_async(queue, ^{
        NSLog(@"5");
    });
    NSLog(@"bbb");
    dispatch_async(queue, ^{
        NSLog(@"6");
    });
    
    
}

@end
