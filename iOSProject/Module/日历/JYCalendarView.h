//
//  JYCalendarView.h
//  calendar
//
//  Created by 豆豆 on 2019/8/5.
//  Copyright © 2019 jimi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYCalendarView;
@protocol JYCalendarViewDelegate <NSObject>

@optional

- (void)calendarViewOfChangeMonth:(JYCalendarView *)calendarView date:(NSDate *)date;
- (void)calendarViewOfSelectDate:(JYCalendarView *)calendarView date:(NSDate *)date;


@end


@interface JYCalendarView : UIView

@property(nonatomic,strong)NSDate *date;
@property(nonatomic,weak)id <JYCalendarViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withBtnWidth:(CGFloat)btnWidth;

@end

NS_ASSUME_NONNULL_END
