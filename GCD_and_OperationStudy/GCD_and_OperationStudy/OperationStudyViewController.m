//
//  OperationStudyViewController.m
//  GCD_and_OperationStudy
//
//  Created by 李曈 on 2017/2/22.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "OperationStudyViewController.h"
#import <objc/objc-runtime.h>
@implementation OperationStudyViewController

-(void)viewDidLoad{
    [super viewDidLoad];
}

- (IBAction)start:(id)sender {
    ((void (*) (id,SEL))objc_msgSend)(self,@selector(asyncOperation));
}

-(void)asyncOperation{
    
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }];
    
    [queue addOperation:operation];
    
}
@end
