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

@end

@implementation XSMainCell

- (void)createView{
    [self.contentView addSubview:self.titleLabel];
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
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [XSTool colorWithHexString:@"#212B36"];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(14)];
    }
    return _titleLabel;
}

@end
