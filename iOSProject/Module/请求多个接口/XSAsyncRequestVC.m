//
//  XSAsyncRequestVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/11/28.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSAsyncRequestVC.h"

@interface XSAsyncRequestVC ()

@end

@implementation XSAsyncRequestVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self handleAsyncRequest];

}

- (void)handleAsyncRequest{
    // 创建组
    dispatch_group_t group = dispatch_group_create();
    
    JYWeakSelf
    // 将第一个请求添加到组  异步处理多个接口
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakSelf requestFirst];
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakSelf requestSecond];
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakSelf requestThird];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //注：如果要对UI进行操作，第二个参数就传dispatch_get_main_queue()
        NSLog(@"完成了网络请求，无论成功或失败");
    });
    
}


- (void)requestFirst{
    //创建信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [XSRequestManager post:@"http://www.baidu.com" params:@{} success:^(XSBaseModel * _Nonnull response) {
        if (response.success) {
            // 如果请求成功，发送信号量
            dispatch_semaphore_signal(semaphore);
            NSLog(@"第一个请求");
        }else{
            // 如果请求失败，发送信号量
            dispatch_semaphore_signal(semaphore);
            NSLog(@"第一个请求");
        }
    } failure:^(NSError * _Nonnull error) {
        // 如果请求失败，发送信号量
        dispatch_semaphore_signal(semaphore);
        NSLog(@"第一个请求");
    }];
    // 在网络请求任务成功之前，信号量等待中
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)requestSecond{
    //创建信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [XSRequestManager post:@"http://www.baidu.com" params:@{} success:^(XSBaseModel * _Nonnull response) {
        if (response.success) {
            // 如果请求成功，发送信号量
            dispatch_semaphore_signal(semaphore);
            NSLog(@"第二个请求");
        }else{
            // 如果请求失败，发送信号量
            dispatch_semaphore_signal(semaphore);
            NSLog(@"第二个请求");
        }
    } failure:^(NSError * _Nonnull error) {
        // 如果请求失败，发送信号量
        dispatch_semaphore_signal(semaphore);
        NSLog(@"第二个请求");
    }];
    // 在网络请求任务成功之前，信号量等待中
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)requestThird{
    //创建信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [XSRequestManager post:@"http://www.baidu.com" params:@{} success:^(XSBaseModel * _Nonnull response) {
        if (response.success) {
            // 如果请求成功，发送信号量
            dispatch_semaphore_signal(semaphore);
            NSLog(@"第三个请求");
        }else{
            // 如果请求失败，发送信号量
            dispatch_semaphore_signal(semaphore);
            NSLog(@"第三个请求");
        }
    } failure:^(NSError * _Nonnull error) {
        // 如果请求失败，发送信号量
        dispatch_semaphore_signal(semaphore);
        NSLog(@"第三个请求");
    }];
    // 在网络请求任务成功之前，信号量等待中
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}



@end
