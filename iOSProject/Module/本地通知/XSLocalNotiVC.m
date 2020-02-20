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
@property(nonatomic,strong)UIButton *btn2;

@end

@implementation XSLocalNotiVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.btn];
    [self.view addSubview:self.btn2];
    
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

- (UIButton *)btn2{
    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.frame = CGRectMake(10, 240, self.view.frame.size.width, 44);
        _btn2.backgroundColor = [UIColor cyanColor];
        [_btn2 setTitle:@"发送通知" forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn2 addTarget:self action:@selector(handleSelect2Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}

- (void)handleSelect2Action:(UIButton *)sender{
    [self postTimingNotifi];
}


- (void)handleAlertTitle:(NSString *)title contentStr:(NSString *)contentStr{
    if (@available(iOS 10.0, *)) {
        // 通知中心
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
        
        
        // 发送通知
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


- (void)postTimingNotifi{
    
    if (@available(iOS 10.0, *)) {
        // 通知中心
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        
        UNMutableNotificationContent *content = [UNMutableNotificationContent new];
        content.title = [NSString localizedUserNotificationStringForKey:@"定时推送" arguments:nil];
        content.body = [NSString localizedUserNotificationStringForKey:@"早上好" arguments:nil];
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"80" ofType:@"png"];
        UNNotificationAttachment *att = [UNNotificationAttachment attachmentWithIdentifier:@"id" URL:[NSURL fileURLWithPath:path] options:nil error:nil];
        content.attachments = @[att]; //添加在通知消息右侧的图片
        content.launchImageName = @"App_logo.png";
        content.sound = [UNNotificationSound defaultSound];
        content.badge = [NSNumber numberWithInt:2];
        
        // 设置时间容器
        // 定时 每到每分钟的十秒钟时 推送一次
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"ss"];
        NSDate *date = [formatter dateFromString:@"10"];
        
        NSDateComponents *components = [[NSCalendar currentCalendar]components:NSCalendarUnitSecond fromDate:date];
        
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
        
        // 发送通知
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"requestId" content:content trigger:trigger];
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
            noti.alertTitle = @"定时推送";
        }
        noti.alertBody = @"早上好";
        noti.alertLaunchImage = @"App_logo";
        [[UIApplication sharedApplication] scheduleLocalNotification:noti];
    }
    
}


@end
