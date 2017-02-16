//
//  RunLoopViewController.m
//  NetPractice
//
//  Created by 李曈 on 2017/2/16.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "RunLoopViewController.h"

@interface RunLoopViewController (){
    NSThread * _thread;
}

@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(newThread) object:@"线程名字"];
    _thread.name = @"自己创建的线程";
    [_thread start];
    //如果不在newThread中  获取runloop，则此方法会无法得到运行
    [self performSelector:@selector(performSomething) withObject:nil afterDelay:2];

    
    

}
-(void)newThread{
    NSRunLoop * loop = [NSRunLoop currentRunLoop];
    [loop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    [loop run];
}
-(void)performSomething{
    [self performSelector:@selector(sayHello) onThread:_thread withObject:nil waitUntilDone:YES];
}

-(void)stopRunloop{
    CFRunLoopStop(CFRunLoopGetCurrent());
}

-(void)sayHello{
    NSLog(@"hello");
}
- (IBAction)sendHelloBtn:(id)sender {
    [self performSelector:@selector(sayHello) onThread:_thread withObject:nil waitUntilDone:YES];
}
- (IBAction)stopRunLoop:(id)sender {
    [self performSelector:@selector(stopRunloop) onThread:_thread withObject:nil waitUntilDone:YES];
}


@end
