//
//  XSAssestPhotoVC.m
//  iOSProject
//
//  Created by 豆豆 on 2020/6/12.
//  Copyright © 2020 软素. All rights reserved.
//

#import "XSAssestPhotoVC.h"
#import "XSAssetOperator.h"

@interface XSAssestPhotoVC ()

@property(nonatomic, strong)UIButton *saveBtn;
@property(nonatomic, strong)UIButton *deleteBtn;
@property(nonatomic, strong)XSAssetOperator *operator;


@end

@implementation XSAssestPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.saveBtn];
    [self.view addSubview:self.deleteBtn];
    
    JYWeakSelf
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(kScaleWidth(100));
        make.height.mas_equalTo(kScaleWidth(45));
        make.top.mas_equalTo(kScaleWidth(200));
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.saveBtn.mas_bottom).mas_offset(kScaleWidth(15));
        make.width.mas_equalTo(weakSelf.saveBtn.mas_width);
        make.height.mas_equalTo(weakSelf.saveBtn.mas_height);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
    }];

    
    self.operator = [[XSAssetOperator alloc]initWithFolderName:@"xiaosi"];
    
}


- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(16)];
        _saveBtn.backgroundColor = [UIColor cyanColor];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

- (void)handleSelectAction:(UIButton *)sender{
    [SVProgressHUD showInfoWithStatus:@"保存"];
    
    NSString *imagePath = [[NSBundle mainBundle]pathForResource:@"mineBanner" ofType:@"png"];
    [self.operator saveImagePath:imagePath];
    
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(16)];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteBtn.backgroundColor = [UIColor cyanColor];
        [_deleteBtn addTarget:self action:@selector(handleDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (void)handleDeleteAction:(UIButton *)sender{
    [SVProgressHUD showInfoWithStatus:@"删除"];
    
    NSString *imagePath = [[NSBundle mainBundle]pathForResource:@"mineBanner" ofType:@"png"];
    [self.operator deleteFile:imagePath];
    
}

@end
