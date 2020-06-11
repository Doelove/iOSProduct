//
//  XSMainCell.m
//  iOSProject
//
//  Created by 豆豆 on 2019/6/28.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSMainCell.h"

@interface XSMainCell ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *btn;

@end

@implementation XSMainCell

- (void)createView{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.btn];
}

- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    JYWeakSelf
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScaleWidth(15));
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(0);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [XSTool colorWithHexString:@"#212B36"];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(14)];
    }
    return _titleLabel;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)handleSelectAction:(UIButton *)sender{
    if (self.block) {
        self.block();
    }
}

@end
