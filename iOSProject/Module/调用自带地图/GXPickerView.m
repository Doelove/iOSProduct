//
//  GXPickerView.m
//  GXCRM_iPhone
//
//  Created by 豆豆 on 2020/1/7.
//  Copyright © 2020 豆豆. All rights reserved.
//

#import "GXPickerView.h"
#import <CoreLocation/CoreLocation.h>
#import <Masonry/Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>

// 屏幕宽度
#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height
// 比例
#define kScaleWidth(width)  (width * (kScreenWidth / 375.0))

@interface GXPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *baseView;
@property(nonatomic,strong)UIPickerView *picker;
@property(nonatomic,strong)UIButton *confirmBtn;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,copy)NSString *selectStr;
@property(nonatomic,copy)NSString *selectId;

@end


@implementation GXPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    [self addSubview:self.bgView];
    [self addSubview:self.baseView];
    [self.baseView addSubview:self.cancelBtn];
    [self.baseView addSubview:self.confirmBtn];
    [self.baseView addSubview:self.picker];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
}

- (void)setDataList:(NSArray <CLPlacemark *>*)dataList{
    _dataList = dataList;
    if (dataList.count == 0) {
        [SVProgressHUD showInfoWithStatus:@"数据为空"];
        [SVProgressHUD dismissWithDelay:2];
    }else{
        CLPlacemark *mark = dataList.firstObject;
//        GXPickerModel *model = dataList[0];
        self.selectId = @"0";
        self.selectStr = mark.name;
        [self.picker reloadAllComponents];
    }
}

- (void)remakePicker{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
//        weakSelf.baseView.y = kScreenHeight-kScaleWidth(244);
//        weakSelf.baseView.
    }];
}


- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.4;
        _bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeSelf)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (void)removeSelf{
    [self removeFromSuperview];
}

- (UIView *)baseView{
    if (!_baseView) {
        _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-bottomMargin-kScaleWidth(244), kScreenWidth, kScaleWidth(244))];
        _baseView.backgroundColor = [self colorWithHexString:@"#F9F9F9"];
    }
    return _baseView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(0, 0, kScaleWidth(50), kScaleWidth(44));
        _cancelBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(14)];
        [_cancelBtn setTitle:@"清除" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[self colorWithHexString:@"498ffb"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(handleSelectClear) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (void)handleSelectClear{
    if ([self.delegate respondsToSelector:@selector(handleSelectCode:value:)]) {
        [self.delegate handleSelectCode:@"" value:@""];
    }
    [self removeFromSuperview];
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(kScreenWidth-kScaleWidth(50), 0, kScaleWidth(50), kScaleWidth(44));
        _confirmBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(14)];
        [_confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[self colorWithHexString:@"498ffb"] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(handleSelectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (void)handleSelectAction{
    if ([self.delegate respondsToSelector:@selector(handleSelectCode:value:)]) {
        [self.delegate handleSelectCode:self.selectId value:self.selectStr];
    }
    [self removeFromSuperview];
}

- (UIPickerView *)picker{
    if (!_picker) {
        _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kScaleWidth(44), kScreenWidth, kScaleWidth(200))];
        _picker.backgroundColor = [UIColor whiteColor];
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}

#pragma mark -- picker delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    CLPlacemark *mark = self.dataList[row];
    return mark.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    CLPlacemark *mark = self.dataList[row];
    self.selectId = [NSString stringWithFormat:@"%ld",(long)row];
    self.selectStr = mark.name;
}


#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
- (UIColor *)colorWithHexString:(NSString*)color{
    NSString* cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString* rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString* gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString* bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f)green:((float)g / 255.0f)blue:((float)b / 255.0f)alpha:1.0f];
}

@end
