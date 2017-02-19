//
//  LearnAFViewController.m
//  NetPractice
//
//  Created by 李曈 on 2017/2/17.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "LearnAFViewController.h"
#import "AFNetworking.h"
@interface LearnAFViewController ()

@end

@implementation LearnAFViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    NSDictionary * params = @{
                              @"name" : @"bang",
                              @"phone": @{@"mobile": @"xx", @"home": @"xx"},
                              @"families": @[@"father", @"mother"],
                              @"nums": [NSSet setWithObjects:@"1", @"2", nil] 
                              } ;
    [manager POST:@"http://localhost:10008/api/post" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
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
