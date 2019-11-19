//
//  XSKYClearClassVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/11/19.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSKYClearClassVC.h"
#import "JYPendApprovalManagerView.h"

@interface XSKYClearClassVC ()<JYPendApprovalManagerViewDelegate>

@property(nonatomic,strong)JYPendApprovalManagerView *managerView;

@end

@implementation XSKYClearClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"clear class";
    
    [self.view addSubview:self.managerView];

}

- (JYPendApprovalManagerView *)managerView{
    if (!_managerView) {
        _managerView = [[JYPendApprovalManagerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScaleWidth(60))];
        _managerView.delegate = self;
    }
    return _managerView;
}

- (void)managerView:(JYPendApprovalManagerView *)managerView isPass:(BOOL)isPass{
    NSString *str = isPass ? @"通过":@"否决";
    [SVProgressHUD showInfoWithStatus:str];
}

@end
