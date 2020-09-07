//
//  XSTouchView.m
//  iOSProject
//
//  Created by 豆豆 on 2020/8/7.
//  Copyright © 2020 软素. All rights reserved.
//

#import "XSTouchView.h"

@interface XSTouchView ()

@property(nonatomic, strong)UILabel *titleLabel;

@end

@implementation XSTouchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

// 拖动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    // 当前位置
    CGPoint currentPoint = [touch locationInView:self];
    // 上一个位置
    CGPoint prePoint = [touch previousLocationInView:self];
    
    // 偏移量
    CGFloat offsetX = currentPoint.x - prePoint.x;
    CGFloat offsetY = currentPoint.y - prePoint.y;
    
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}


- (void)setupView{
    [self addSubview:self.titleLabel];
    JYWeakSelf
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(14)];
        _titleLabel.text = @"自定义View";
    }
    return _titleLabel;
}

@end
