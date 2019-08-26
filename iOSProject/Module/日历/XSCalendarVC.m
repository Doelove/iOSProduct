//
//  XSCalendarVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/8/26.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSCalendarVC.h"
#import "NSDate+DaboExtension.h"
#import "JYCalendarView.h"

@interface XSCalendarVC ()<JYCalendarViewDelegate>

@property(nonatomic,strong)JYCalendarView *calendarView;
@property(nonatomic,strong)NSDate *date;


@end

@implementation XSCalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.date = [NSDate date];
    [self setBackBtn];
    self.title = @"日历";
    [self createCalendarView];

}


- (void)createCalendarView{
    [self.calendarView removeFromSuperview];
    CGFloat btnWidth = (kScreenWidth-kScaleWidth(110))/7.0f;
    JYCalendarView *calendarView = [[JYCalendarView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, btnWidth*8 + kScaleWidth(50)) withBtnWidth:btnWidth];
    calendarView.date = self.date;
    calendarView.delegate = self;
    [self.view addSubview:calendarView];
    self.calendarView = calendarView;
}

- (void)calendarViewOfSelectDate:(JYCalendarView *)calendarView date:(NSDate *)date{
    NSString *selectDay = [NSDate stringFromDate:date andNSDateFmt:NSDateFmtYYYYMMdd];
    NSLog(@"选中的日期是%@",selectDay);
}

- (void)calendarViewOfChangeMonth:(JYCalendarView *)calendarView date:(NSDate *)date{
    self.date = date;
    [self createCalendarView];
}


@end
