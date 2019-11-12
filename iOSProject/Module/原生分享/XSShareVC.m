//
//  XSShareVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/11/7.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSShareVC.h"

@interface XSShareVC ()

@property(nonatomic,strong)UIButton *btn;

@end

@implementation XSShareVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"原生分享";
    [self.view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScaleWidth(20));
        make.right.mas_equalTo(-kScaleWidth(20));
        make.top.mas_equalTo(kScaleWidth(150));
        make.height.mas_equalTo(kScaleWidth(44));
    }];
}


- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor cyanColor];
        _btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(16)];
        [_btn setTitle:@"分享" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)handleSelectAction:(UIButton *)sender{
    NSString *text = @"要分享的文本内容";
    UIImage *image = [UIImage imageNamed:@"80"];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSArray *activityItems = @[text,image,url];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:@[]];
    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypeAirDrop,UIActivityTypePostToWeibo,UIActivityTypePostToTencentWeibo];
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        
        if (completed) {
            NSLog(@"success");
            [SVProgressHUD showInfoWithStatus:@"success"];
        }else{
            NSLog(@"failed");
            [SVProgressHUD showInfoWithStatus:@"failed"];
        }
        
    };
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

@end
