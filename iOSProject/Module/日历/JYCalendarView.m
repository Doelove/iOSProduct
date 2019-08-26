//
//  JYCalendarView.m
//  calendar
//
//  Created by 豆豆 on 2019/8/5.
//  Copyright © 2019 jimi. All rights reserved.
//

#import "JYCalendarView.h"
#import "XSTool.h"
#import "XSMacro.h"
#import "NSDate+DaboExtension.h"

@interface JYCalendarView ()

@property(nonatomic,strong)NSMutableArray *dateBtnList;
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIView *weekBg;
@property(nonatomic,strong)UILabel *headLabel;
@property(nonatomic,strong)UIImage *dateAlreadyImage;
@property(nonatomic,strong)UIImage *dateImage;
@property(nonatomic,strong)UIImage *dateOutOfImage;
@property(nonatomic,strong)UIView *bottomView;

@property(nonatomic,assign)CGFloat btnWidth;

@end

@implementation JYCalendarView


- (instancetype)initWithFrame:(CGRect)frame withBtnWidth:(CGFloat)btnWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.btnWidth = btnWidth;
        [self createView];
    }
    return self;
}

- (CGFloat)btnWidth{
    return (kScreenWidth-kScaleWidth(110))/7.0f;
}

- (void)createView{
    [self addSubview:self.topView];
    [self addSubview:self.weekBg];
}

- (void)setDate:(NSDate *)date{
    _date = date;
    _headLabel.text = [NSString stringWithFormat:@"%li年%li月",(long)date.year,(long)date.month];
    [self createCalendarWithDate:date];
}

- (void)createCalendarWithDate:(NSDate *)date{
    
    NSInteger daysInThisMonth = date.numberOfDaysInCurrentMonth;
    NSInteger Wweek = date.weeklyOrdinality;
    BOOL ord = (Wweek-2) < 0;
    NSInteger firstWeekIndex = ord  ? 6 : date.weeklyOrdinality - 2; // 第一天的位置
    
    for (int i = 0; i < self.dateBtnList.count; i++) {
        UIButton *dayBtn = self.dateBtnList[i];
        NSInteger day = 0;
        
        if (i < firstWeekIndex) {
            NSDate *preDate = [date dayInThePreviousMonth];
            NSInteger daysInPreMonth = preDate.numberOfDaysInCurrentMonth;
            day = daysInPreMonth-firstWeekIndex+i+1;
            [dayBtn setTitle:[NSString stringWithFormat:@"%ld",(long)day] forState:UIControlStateNormal];
            [self setStyle_BeyondThisMonth:dayBtn];
        }else if (i > firstWeekIndex+daysInThisMonth-1){
            day = i - daysInThisMonth - firstWeekIndex + 1;
            [dayBtn setTitle:[NSString stringWithFormat:@"%ld",(long)day] forState:UIControlStateNormal];
            [self setStyle_BeyondThisMonth:dayBtn];
        }else{
            day = i - firstWeekIndex + 1;
            [dayBtn setTitle:[NSString stringWithFormat:@"%ld",(long)day] forState:UIControlStateNormal];
            [self setStyle_AfterToday:dayBtn];
        }
    }
}


#pragma mark --  日历按钮style
- (void)setStyle_BeyondThisMonth:(UIButton *)btn{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:nil forState:UIControlStateNormal];
}

- (void)setStyle_Today:(UIButton *)btn{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:self.dateOutOfImage forState:UIControlStateNormal];
}

- (void)setStyle_AfterToday:(UIButton *)btn{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor colorWithWhite:0.316 alpha:1.000] forState:UIControlStateNormal];
}

#pragma mark -- 日历
- (NSMutableArray *)dateBtnList{
    if (!_dateBtnList) {
        _dateBtnList = [NSMutableArray array];
        for (int i = 0; i<42; i++) {
            UIButton *dayBtn = [UIButton buttonWithType: UIButtonTypeCustom];
            dayBtn.frame = CGRectMake(kScaleWidth(25) + (self.btnWidth + kScaleWidth(10)) * (i % 7) , (i / 7) * (self.btnWidth + kScaleWidth(0)) + CGRectGetMaxY(self.weekBg.frame), self.btnWidth, self.btnWidth);
            dayBtn.tag = 10086+i;
            dayBtn.titleLabel.font = [UIFont systemFontOfSize:kScaleWidth(13)];
            dayBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [dayBtn setBackgroundImage:self.dateImage forState:UIControlStateNormal];
            [dayBtn setBackgroundImage:self.dateAlreadyImage forState:UIControlStateSelected];
            [dayBtn addTarget:self action:@selector(handleDayClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:dayBtn];
            [_dateBtnList addObject:dayBtn];
        }
    }
    return _dateBtnList;
}

- (void)handleDayClick:(UIButton *)sender{
    for (UIButton *btn in self.dateBtnList) {
        btn.selected = NO;
    }
    sender.selected = YES;
    if ([self.delegate respondsToSelector:@selector(calendarViewOfSelectDate:date:)]) {
        NSInteger day = [sender titleForState:UIControlStateNormal].integerValue;
        NSDate *chooseDate = [NSDate dateWithYear:self.date.year Month:self.date.month Day:day Hour:0 Minute:0 Second:0];
        [self.delegate calendarViewOfSelectDate:self date:chooseDate];
    }
}

#pragma mark -- weekbg
- (UIView *)weekBg{
    if (!_weekBg) {
        _weekBg = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), kScreenWidth, self.btnWidth)];
        NSArray *list = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
        for (int i = 0; i<list.count; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScaleWidth(25) + (self.btnWidth + kScaleWidth(10)) * i, 0, self.btnWidth, self.btnWidth)];
            label.text = list[i];
            label.font = [UIFont systemFontOfSize:kScaleWidth(14)];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [XSTool colorWithHexString:@"212B36"];
            [_weekBg addSubview:label];
        }
    }
    return _weekBg;
}

#pragma mark -- topView
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScaleWidth(50))];
        UIButton *leftBtn = [self createBtnWithFrame:CGRectMake(kScaleWidth(10), 0, CGRectGetHeight(_topView.frame), CGRectGetHeight(_topView.frame)) tag:100111 img:@"avoidParking_zuo"];
        [leftBtn setTitle:@"上个月" forState:UIControlStateNormal];
        UIButton *rightBtn = [self createBtnWithFrame:CGRectMake(kScreenWidth-kScaleWidth(60), 0, CGRectGetHeight(_topView.frame), CGRectGetHeight(_topView.frame)) tag:100110 img:@"avoidParking_you"];
        [rightBtn setTitle:@"下个月" forState:UIControlStateNormal];
        [_topView addSubview:self.headLabel];
        self.headLabel.center = _topView.center;
        [_topView addSubview:leftBtn];
        [_topView addSubview:rightBtn];
    }
    return _topView;
}

- (UIButton *)createBtnWithFrame:(CGRect)frame tag:(NSInteger)tag img:(NSString *)img{
    UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
    btn.tag = tag;
    btn.frame = frame;
    btn.titleLabel.font = [UIFont systemFontOfSize:kScaleWidth(12)];
    [btn setTitleColor:[XSTool colorWithHexString:@"21b338"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(handleChangeMonth:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)handleChangeMonth:(UIButton *)sender{
    if (sender.tag == 100111) {
        if ([self.delegate respondsToSelector:@selector(calendarViewOfChangeMonth:date:)]) {
            [self.delegate calendarViewOfChangeMonth:self date:self.date.dayInThePreviousMonth];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(calendarViewOfChangeMonth:date:)]) {
            [self.delegate calendarViewOfChangeMonth:self date:self.date.dayInTheFollowingMonth];
        }
    }
}

- (UILabel *)headLabel{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScaleWidth(200), kScaleWidth(50))];
        _headLabel.textAlignment = NSTextAlignmentCenter;
        _headLabel.textColor = [XSTool colorWithHexString:@"#212B36"];
        _headLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(16)];
    }
    return _headLabel;
}


//MARK:---选中时
- (UIImage *)dateAlreadyImage{
    if (!_dateAlreadyImage) {
        _dateAlreadyImage = [self imageWithColor:[UIColor greenColor]];
    }
    return _dateAlreadyImage;
}

//MARK:---未选中时
- (UIImage *)dateImage{
    if (!_dateImage) {
        _dateImage = [self imageWithColor:[UIColor whiteColor]];
    }
    return _dateImage;
}

- (UIImage *)dateOutOfImage{
    if (!_dateOutOfImage) {
        _dateOutOfImage = [self imageWithColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
    }
    return _dateOutOfImage;
}

//MARK:----每一天的颜色背景设置
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        
        
        
    }
    return _bottomView;
}

@end
