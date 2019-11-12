//
//  XSLocalNotiVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/11/8.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSLocalNotiVC.h"
#import <UserNotifications/UserNotifications.h>


@interface XSLocalNotiVC ()<UNUserNotificationCenterDelegate>

@property(nonatomic,strong)UIButton *btn;

@end

@implementation XSLocalNotiVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.btn];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // 获取用户是否同意开启通知
        }
    }];
}


- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(10, 150, self.view.frame.size.width, 44);
        _btn.backgroundColor = [UIColor cyanColor];
        [_btn setTitle:@"发送通知" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)handleSelectAction:(UIButton *)sender{
    [self handleAlertTitle:@"title21" contentStr:@"content33"];
}

- (void)handleAlertTitle:(NSString *)title contentStr:(NSString *)contentStr{
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        UNMutableNotificationContent *content = [UNMutableNotificationContent new];
        content.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
        content.body = [NSString localizedUserNotificationStringForKey:contentStr arguments:nil];
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"80" ofType:@"png"];
        UNNotificationAttachment *att = [UNNotificationAttachment attachmentWithIdentifier:@"id" URL:[NSURL fileURLWithPath:path] options:nil error:nil];
        content.attachments = @[att]; //添加在通知消息右侧的图片
        content.launchImageName = @"App_logo.png";
        
        content.sound = [UNNotificationSound defaultSound];
        
        content.badge = [NSNumber numberWithInt:2];
        
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"requestId" content:content trigger:nil];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (!error) {
                NSLog(@"成功");
            }else{
                NSLog(@"失败");
            }
        }];
    }else{
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeAlert|UIUserNotificationTypeSound  categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
        UILocalNotification *noti = [UILocalNotification new];
        noti.timeZone = [NSTimeZone localTimeZone];
        noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
        noti.repeatInterval = 1;
        noti.repeatCalendar = [NSCalendar currentCalendar];
        if (@available(iOS 8.2, *)) {
            noti.alertTitle = title;
        }
        noti.alertBody = contentStr;
        noti.alertLaunchImage = @"App_logo";
        [[UIApplication sharedApplication] scheduleLocalNotification:noti];
    }
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge);
    
}


@end
