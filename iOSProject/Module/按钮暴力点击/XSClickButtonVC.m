//
//  XSClickButtonVC.m
//  iOSProject
//
//  Created by 豆豆 on 2020/9/27.
//  Copyright © 2020 软素. All rights reserved.
//

#import "XSClickButtonVC.h"
//#import "UIButton+click.h"
#import "UIControl+click.h"

@interface XSClickButtonVC ()

@property(nonatomic, strong)UIButton *clickBtn;
@property(nonatomic, assign)int number;


@end

@implementation XSClickButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.number = 0;
    [self.view addSubview:self.clickBtn];
    [self.clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScaleWidth(15));
        make.top.mas_equalTo(kScaleWidth(100));
        make.right.mas_equalTo(-kScaleWidth(15));
        make.height.mas_equalTo(kScaleWidth(45));
    }];

}

- (UIButton *)clickBtn{
    if (!_clickBtn) {
        _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clickBtn.backgroundColor = [UIColor lightGrayColor];
        _clickBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(16)];
        [_clickBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_clickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_clickBtn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        _clickBtn.qi_eventInterval = 2;
    }
    return _clickBtn;
}

- (void)handleSelectAction:(UIButton *)sender{
    self.number += 1;
    NSLog(@"点击：%d",self.number);
}

@end
