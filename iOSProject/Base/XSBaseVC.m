//
//  XSBaseVC.m
//  iOSProject
//
//  Created by 小四 on 2019/5/9.
//  Copyright © 2019 小四. All rights reserved.
//

#import "XSBaseVC.h"
#import "WHC_KeyboardManager.h"

@interface XSBaseVC ()<UIGestureRecognizerDelegate>


@end

@implementation XSBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tabbarHeight = self.tabBarController.tabBar.frame.size.height;
    
    [[WHC_KeyboardManager share]addMonitorViewController:self];
    self.view.backgroundColor = [UIColor whiteColor];
    // ------
    
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)setBackBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, kScaleWidth(50), kScaleWidth(45));
    btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(15)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(handleBaseReturn) forControlEvents:UIControlEventTouchUpInside];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -CGRectGetWidth(btn.titleLabel.frame)-1.5, 0, CGRectGetWidth(btn.titleLabel.frame)+1.5)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, CGRectGetWidth(btn.imageView.bounds)+1.5, 0, -CGRectGetWidth(btn.imageView.bounds)-1.5)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)configLogin{
    if ([XSTool isBlank:[XSUserInfo getToken]]) {

    }
}

- (void)handleBaseReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hideBackBtn{
    self.navigationItem.hidesBackButton = YES;
}

- (void)pushVC:(UIViewController *)vc{
    if (self.navigationController.viewControllers.count > 0) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)resignKBFirstResponse{
    [[UIApplication sharedApplication]sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (NSString *)getToken{
    return [NSString stringWithFormat:@"?access_token=%@",[XSUserInfo getToken]];
}

- (void)dealloc {
    NSLog(@"%@控制器已释放",[self class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end





