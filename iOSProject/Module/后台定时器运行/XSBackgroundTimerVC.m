//
//  XSBackgroundTimerVC.m
//  iOSProject
//
//  Created by 豆豆 on 2020/8/7.
//  Copyright © 2020 软素. All rights reserved.
//

#import "XSBackgroundTimerVC.h"

@interface XSBackgroundTimerVC ()

@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, assign)int count;

@end

@implementation XSBackgroundTimerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleLabel];
    self.count = 0;
    
    
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication]endBackgroundTask:UIBackgroundTaskInvalid];
    }];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)handleTimer{
    
    NSString *str = [NSString stringWithFormat:@"%d",self.count++];
    self.titleLabel.text = str;
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 200, kScreenWidth-40, 45)];
        _titleLabel.textColor = [XSTool colorWithHexString:textcolor];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(14)];
        _titleLabel.text = @"0";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
