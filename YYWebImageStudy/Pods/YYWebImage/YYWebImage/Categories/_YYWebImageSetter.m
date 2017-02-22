//
//  _YYWebImageSetter.m
//  YYWebImage <https://github.com/ibireme/YYWebImage>
//
//  Created by ibireme on 15/7/15.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "_YYWebImageSetter.h"
#import "YYWebImageOperation.h"
#import <libkern/OSAtomic.h>

NSString *const _YYWebImageFadeAnimationKey = @"YYWebImageFade";
const NSTimeInterval _YYWebImageFadeTime = 0.2;
const NSTimeInterval _YYWebImageProgressiveFadeTime = 0.4;


@implementation _YYWebImageSetter {
    dispatch_semaphore_t _lock;
    NSURL *_imageURL;
    NSOperation *_operation;
    int32_t _sentinel;
}

- (instancetype)init {
    self = [super init];
    _lock = dispatch_semaphore_create(1);
    return self;
}

- (NSURL *)imageURL {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    NSURL *imageURL = _imageURL;
    dispatch_semaphore_signal(_lock);
    return imageURL;
}

- (void)dealloc {
    OSAtomicIncrement32(&_sentinel);
    [_operation cancel];
}

- (int32_t)setOperationWithSentinel:(int32_t)sentinel
                                url:(NSURL *)imageURL
                            options:(YYWebImageOptions)options
                            manager:(YYWebImageManager *)manager
                           progress:(YYWebImageProgressBlock)progress
                          transform:(YYWebImageTransformBlock)transform
                         completion:(YYWebImageCompletionBlock)completion {
    //判断如果  标志位不同 直接返回  错误信息为 YYWebImageStageCancelled
    if (sentinel != _sentinel) {
        if (completion) completion(nil, imageURL, YYWebImageFromNone, YYWebImageStageCancelled, nil);
        return _sentinel;
    }
    //yyimagemanager 执行operation  这个方法  返回一个 YYImageOperation的对象
    //从这 进入到 manager查看
    NSOperation *operation = [manager requestImageWithURL:imageURL options:options progress:progress transform:transform completion:completion];
    //如果没完成创建operation且 有complete实现  则回调  错误原因
    if (!operation && completion) {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : @"YYWebImageOperation create failed." };
        completion(nil, imageURL, YYWebImageFromNone, YYWebImageStageFinished, [NSError errorWithDomain:@"com.ibireme.webimage" code:-1 userInfo:userInfo]);
    }
    //使用信号量 进行加锁操作
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    if (sentinel == _sentinel) {
        //如果之前有operation  则把之前的取消  重新进行请求
        if (_operation) [_operation cancel];
        _operation = operation;
        sentinel = OSAtomicIncrement32(&_sentinel);
    } else {
        //这个 情况加 同最初的那个判断，但是已经创建了  operation  所以要取消
        [operation cancel];
    }
    //释放信号量
    dispatch_semaphore_signal(_lock);
    return sentinel;
}

- (int32_t)cancel {
    return [self cancelWithNewURL:nil];
}

- (int32_t)cancelWithNewURL:(NSURL *)imageURL {
    int32_t sentinel;
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    if (_operation) {
        [_operation cancel];
        _operation = nil;
    }
    _imageURL = imageURL;
    sentinel = OSAtomicIncrement32(&_sentinel);
    dispatch_semaphore_signal(_lock);
    return sentinel;
}

+ (dispatch_queue_t)setterQueue {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.ibireme.webimage.setter", DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(queue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    });
    return queue;
}

@end
