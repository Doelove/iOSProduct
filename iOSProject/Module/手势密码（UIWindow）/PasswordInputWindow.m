//
//  PasswordInputWindow.m
//  iOSProject
//
//  Created by 豆豆 on 2019/7/18.
//  Copyright © 2019 软素. All rights reserved.
//

#import "PasswordInputWindow.h"

@interface PasswordInputWindow ()<UITextFieldDelegate>

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITextField *inputTextField;
@property(nonatomic,strong)UIButton *btn;


@end

@implementation PasswordInputWindow

+ (PasswordInputWindow *)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return sharedInstance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.inputTextField];
        [self addSubview:self.btn];
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)show{
    [self makeKeyWindow];
    self.hidden = NO;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 200, 20)];
        _titleLabel.textColor = [XSTool colorWithHexString:@"#212B36"];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(14)];
        _titleLabel.text = @"请输入密码";
    }
    return _titleLabel;
}

- (UITextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 80, 200, 20)];
        _inputTextField.delegate = self;
        _inputTextField.backgroundColor = [XSTool colorWithHexString:@"#FAFAFA"];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        _inputTextField.leftView = view;
        _inputTextField.leftViewMode = UITextFieldViewModeAlways;
        _inputTextField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(12)];
        _inputTextField.layer.cornerRadius = 2;
        _inputTextField.layer.masksToBounds = YES;
    }
    return _inputTextField;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(10, 110, 200, 44);
        _btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(16)];
        [_btn setTitle:@"确定" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)handleSelectAction:(UIButton *)sender{
    if ([self.inputTextField.text isEqualToString:@"abcd"]) {
        [self.inputTextField resignFirstResponder];
        self.hidden = YES;
    }else{
        [SVProgressHUD showInfoWithStatus:@"密码错误"];
        [SVProgressHUD dismissWithDelay:2];
    }
}


@end
