//
//  XSMacro.h
//  iOSProject
//
//  Created by 小四 on 2019/5/9.
//  Copyright © 2019 小四. All rights reserved.
//

#ifndef XSMacro_h
#define XSMacro_h
#import "XSMainTabBarC.h"

#define kOpenTouchIDNoti @"kOpenTouchIDNoti"

#define KEY_WINDOW          [[UIApplication sharedApplication] keyWindow]
#define JYAppDelegate       (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define IOS_VERSION         [[[UIDevice currentDevice] systemVersion] floatValue]

// 屏幕宽度
#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height
// 屏幕bounds
#define kScreenBounds       ([[UIScreen mainScreen] bounds])

// 比例
#define kScaleWidth(width)  (width * (kScreenWidth / 375.0))

#define JYWeakSelf          __weak typeof(self) weakSelf = self;

//导航栏的高度
#define navgationHeight (kScreenWidth == 812.0? 88:64)
// 状态栏的高度
#define statusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define isIPhoneX kScreenHeight == 812
#define bottomMargin (isIPhoneX ? (84+34) : 64)

typedef void(^ReturnBlock)(id value);
typedef void(^ReturnIntBlock)(int num);
typedef void(^BoolBlock)(BOOL isSelect);
typedef void(^SelectBlock)(void);



#define kNotiSaveCall       @"kNotiSaveCall"
#define kNotiConfigLogin    @"kNotiConfigLogin"


#define linecolor       @"eeeeee"
#define textcolor       @"212B36"
#define tableViewColor  @"F5F7FA"
#define navcolor        @"1397E8"








#endif /* XSMacro_h */
