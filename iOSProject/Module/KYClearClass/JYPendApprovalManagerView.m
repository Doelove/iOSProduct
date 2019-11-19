//
//  JYPendApprovalManagerView.m
//  JYCRM_iPhone
//
//  Created by 软素 on 2019/7/3.
//  Copyright © 2019 软素. All rights reserved.
//

#import "JYPendApprovalManagerView.h"

@interface JYPendApprovalManagerView ()

@property(nonatomic,strong)UIButton *passBtn;
@property(nonatomic,strong)UIButton *vetoBtn;
//@property(nonatomic,strong)UIButton *managerBtn;

@end

@implementation JYPendApprovalManagerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    [self addSubview:self.passBtn];
    [self addSubview:self.vetoBtn];
//    [self addSubview:self.managerBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    JYWeakSelf
    [self.passBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScaleWidth(15));
        make.width.mas_equalTo(kScaleWidth(95));
        make.height.mas_equalTo(kScaleWidth(21));
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
    [self.vetoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kScaleWidth(15));
        make.width.mas_equalTo(weakSelf.passBtn.mas_width);
        make.height.mas_equalTo(weakSelf.passBtn.mas_height);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
}

- (UIButton *)passBtn{
    if (!_passBtn) {
        _passBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _passBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(15)];
        _passBtn.tag = 1092;
        [_passBtn setBackgroundImage:[UIImage imageNamed:@"CRM_pendPass"] forState:UIControlStateNormal];
        [_passBtn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passBtn;
}

- (UIButton *)vetoBtn{
    if (!_vetoBtn) {
        _vetoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _vetoBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(15)];
        _vetoBtn.tag = 1091;
        [_vetoBtn setBackgroundImage:[UIImage imageNamed:@"CRM_pendVeto"] forState:UIControlStateNormal];
        [_vetoBtn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _vetoBtn;
}

- (void)handleSelectAction:(UIButton *)sender{
    BOOL isPass = sender.tag == 1091 ? NO:YES;
    if ([self.delegate respondsToSelector:@selector(managerView:isPass:)]) {
        [self.delegate managerView:self isPass:isPass];
    }
}
@end
