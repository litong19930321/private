//
//  URLSessionViewController.m
//  NetPractice
//
//  Created by 李曈 on 2017/2/16.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "URLSessionViewController.h"
#import "URLSessionViewController.h"
#import <objc/runtime.h>
@interface URLSessionViewController ()<NSURLSessionDataDelegate,NSURLSessionDownloadDelegate>
@property (nonatomic,strong)  NSMutableData * mData;
@property (nonatomic,strong) NSURLSessionDownloadTask * downloadTask;//这个用于断点下载
@property (nonatomic,strong) NSURLSession * resumeSession;//这个是用于断点下载恢复的session
@property (nonatomic,strong) NSURLSessionTask * commontask;
@property (nonatomic,strong) NSData * gloableData;//这个是存储当前下载的data
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@end

@implementation URLSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //使用block回调调用session data task
//    [self useNSURLSessionDataTask];
    //使用代理方法调用session data task
    _mData = [[NSMutableData alloc] init];
    [self useDeleageteUrlSession];
    //使用block 调用 session dowmloadtask
//    [self useNSURLSessionDownloadTask];
    //使用delegate方法调用  urlsessiondownloadtask
//    [self useNSURLSessionDownloadTaskByDelegate];
}
- (IBAction)suspend:(id)sender {
//    [_downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
//        self.gloableData = resumeData;
//    }];
}
- (IBAction)resume:(id)sender {
    if (self.gloableData) {
        NSURLSessionDownloadTask * task =  [_resumeSession downloadTaskWithResumeData:self.gloableData];
        [task resume];
    }else{
        NSAssert(NO, @"gloableData is nil");
    }
}
/**
 使用 urlsessiondatatask进行网络请求
 */
-(void)useNSURLSessionDataTask{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://localhost:10008/api/shoplist"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
      NSDictionary *dict =   [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSString * json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//        
        NSLog(@"%@",json);
    }];
    [dataTask resume];
}
/**
 使用代理方法完成对urlsession的请求处理
 */
-(void)useDeleageteUrlSession{
    _mData = [NSMutableData data];
//    NSURL * getUrl = [NSURL URLWithString:@"http://localhost:10008/api/shoplist"];
    NSURL * postUrl = [NSURL URLWithString:@"https://s-media-cache-ak0.pinimg.com/1200x/2e/0c/c5/2e0cc5d86e7b7cd42af225c29f21c37f.jpg"];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:postUrl];
//    request.HTTPMethod = @"POST";
//    request.HTTPBody = [@"username=daka&pwd=123" dataUsingEncoding:NSUTF8StringEncoding];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    _commontask = [session dataTaskWithRequest:request];
    [_commontask resume];
}

/**
 使用 urlsessiondownLoadTask  用block的方式
 */
-(void)useNSURLSessionDownloadTask{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask * task = [session downloadTaskWithURL:[NSURL URLWithString:@"http://img.qzcns.com/2017/0215/20170215054646515.jpg"] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString * ptah = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test.jpg"];
//        [[NSFileManager defaultManager] createFileAtPath:ptah contents:nil attributes:nil];
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:ptah] error:nil];
        NSLog(@"%@",ptah);
    }];
    [task resume];
}

/**
 用代理的方式实现下载
 */
-(void)useNSURLSessionDownloadTaskByDelegate{
    _resumeSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    _downloadTask = [_resumeSession downloadTaskWithURL:[NSURL URLWithString:@"http://img.qzcns.com/2017/0215/20170215054646515.jpg"]];
    [_downloadTask resume];
}
#pragma mark - NSURLSessionDataDelegate
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    completionHandler(NSURLSessionResponseAllow);
}
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    [_mData appendData:data];
}
-(void)URLSession:(NSURLSession *)session task:(nonnull NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    UIImage * image = [[UIImage alloc] initWithData:_mData.copy];
    dispatch_async(dispatch_get_main_queue(), ^{
        _mainImageView.image = image;
    });
    
    
    
//    NSString * string = [[NSString alloc] initWithData:_mData encoding:NSUTF8StringEncoding];
//    NSLog(@"收到%@",string);
//    NSLog(@"完成");
//    self.gloableData = error.userInfo[NSURLSessionDownloadTaskResumeData];
}
#pragma mark - NSURLSessionDownloadDelegate
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    // location还是一个临时路径,需要自己挪到需要的路径
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test1.jpg"];
    NSLog(@"%@",filePath);
    //此方法默认情况下并不会覆盖同名文件，可以采用先删除之前的文件再移动的方法处理覆盖问题
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:filePath] error:nil];
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    CGFloat progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
    NSLog(@"total : %lld",totalBytesExpectedToWrite);
    NSLog(@"%f",progress);
    //这个 方法是 暂停当前的下载任务并保存 当前的下载内容
    
//    [_downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
//        _gloableData = resumeData;
//    }];
}
@end
