//
//  KVCViewController.m
//  RuntimePrice
//
//  Created by 李曈 on 2017/2/15.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "KVCViewController.h"
#import "KVCModel.h"
#import <objc/runtime.h>
#import "NSObject+DLIntrospection.h"
#import "KVCModel_Private.h"
#import "Car.h"
@interface KVCViewController ()

@end

@implementation KVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    KVCModel * model = [[KVCModel alloc] init];
    
    [model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];

//    [model addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
    
    model.name = @"danker";
    model.creditCardPassword = @"私有的";
    [model removeObserver:self forKeyPath:@"name"];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
}




@end
