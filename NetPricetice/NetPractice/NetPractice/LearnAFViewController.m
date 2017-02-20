//
//  LearnAFViewController.m
//  NetPractice
//
//  Created by 李曈 on 2017/2/17.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "LearnAFViewController.h"
#import "AFNetworking.h"
@interface LearnAFViewController (){
    NSThread * _globalThread;
}
@property (nonatomic,copy) NSString * name;

@end

@implementation LearnAFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个观察者  监听主runloop的各种状态
    CFRunLoopRef loop = CFRunLoopGetMain();
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"kCFRunLoopEntry");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"kCFRunLoopBeforeTimers");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"kCFRunLoopBeforeSources");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"kCFRunLoopBeforeWaiting");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"kCFRunLoopAfterWaiting");
                break;
            case kCFRunLoopExit:
                NSLog(@"kCFRunLoopExit");
                break;
            case kCFRunLoopAllActivities:
                NSLog(@"kCFRunLoopAllActivities");
                break;
            default:
                break;
        }
    });
    CFRunLoopAddObserver(loop, observer, kCFRunLoopDefaultMode);
}




- (IBAction)startGet:(id)sender {
    [self startNetWorking];
 
}
- (IBAction)startPost:(id)sender {
    [self startNetWorkingPost];
}


-(void)startNetWorking{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://localhost:10008/api/shoplist" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dict = responseObject;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString * json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"json -----  %@",json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@",error.localizedDescription);
    }];
}
-(void)startNetWorkingPost{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    AFSecurityPolicy * policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"lt.cer" ofType:nil];
        NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
        NSSet *certSet = [NSSet setWithObjects:certData, nil];
//        policy.pinnedCertificates = certSet;
     AFSecurityPolicy * policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone withPinnedCertificates:certSet];
//    policy.allowInvalidCertificates = YES;
    manager.securityPolicy = policy;
    policy.pinnedCertificates = certSet;
    policy.validatesDomainName = NO;
    
    NSDictionary * params = @{
                              @"name" : @"bang",
                              @"phone": @{@"mobile": @"xx", @"home": @"xx"},
                              @"families": @[@"father", @"mother"],
                              @"nums": [NSSet setWithObjects:@"1", @"2", nil] 
                              } ;
    [manager GET:@"https://127.0.0.1:10008/api/shoplist" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dict = responseObject;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString * json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"json -----  %@",json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error.localizedDescription);
    }];

}




@end
