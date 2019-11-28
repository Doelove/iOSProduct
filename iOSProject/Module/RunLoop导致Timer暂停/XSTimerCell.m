//
//  XSTimerCell.m
//  iOSProject
//
//  Created by 豆豆 on 2019/11/28.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSTimerCell.h"

@interface XSTimerCell ()

@property(nonatomic,strong)UILabel *timerLabel;
@property(nonatomic,assign)int timerNum;
@property(nonatomic,strong)UIImageView *itemImageView;

@end

@implementation XSTimerCell


- (void)createView{
    self.timerNum = 0;
    [self.contentView addSubview:self.timerLabel];
    [self.contentView addSubview:self.itemImageView];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleAddTime) userInfo:nil repeats:YES];
    
    
    
    
    
    /*  NSTimer不再计数的原因是，runloop的mode切换导致。
        开启NSTimer，实质是在当前的runloop中注册了一个新的事件源，此时RunLoop的Mode为kCFRunLoopDefaultMode，即定时器属于kCFRunLoopDefaultMode，当滑动UITableView时，Runloop的Mode会切换到UITrackingRunLoopMode，因此主线程的定时器就不会再计数，NSTimer调用的方法不会再执行，当停止滑动时，RunLoop的Mode切换回kCFRunLoopDefaultMode，NSTimer就又开始调用方法，进行计数。
     
        如何让timer在两个模式下都可以运行呢？
        1 在两个模式下都添加timer 是可以的，但是timer添加了两次，并不是同一个timer
        2 添加NSRunLoopCommonModes标记，凡是被打上NSRunLoopCommonModes标记的都可以运行，下面两种模式被打上标签
     0 : <CFString 0x10b7fe210 [0x10a8c7a40]>{contents = "UITrackingRunLoopMode"}
     2 : <CFString 0x10a8e85e0 [0x10a8c7a40]>{contents = "kCFRunLoopDefaultMode"}
      也就是说如果我们使用NSRunLoopCommonModes，timer可以在UITrackingRunLoopMode，kCFRunLoopDefaultMode两种模式下运行
     
      另一种解释
        需要一个 Timer，在两个 Mode 中都能得到回调，一种办法就是将这个 Timer 分别加入这两个 Mode。还有一种方式，就是将 Timer 加入到顶层的 RunLoop 的 “commonModeItems” 中。”commonModeItems” 被 RunLoop 自动更新到所有具有”Common”属性的 Mode 里去。
    */
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    
    /*
        performSelector默认是在default模式下运行，因此在滑动时，图片不会加载
     */
    [self.itemImageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"mineBanner"] afterDelay:2 inModes:@[UITrackingRunLoopMode]];

}

- (void)handleAddTime{
    self.timerNum += 1;
    NSString *str = [NSString stringWithFormat:@"time:%d",self.timerNum];
    self.timerLabel.text = str;
}

- (UILabel *)timerLabel{
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScaleWidth(20), 0, kScreenWidth-kScaleWidth(10), kScaleWidth(44))];
        _timerLabel.textColor = [UIColor blackColor];
        _timerLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(16)];
        _timerLabel.text = @"time:0";
    }
    return _timerLabel;
}

- (UIImageView *)itemImageView{
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScaleWidth(20), CGRectGetMaxY(self.timerLabel.frame)+kScaleWidth(6), kScaleWidth(50), kScaleWidth(50))];
//        _itemImageView.image = [UIImage imageNamed:@"80"];
    }
    return _itemImageView;
}

@end
