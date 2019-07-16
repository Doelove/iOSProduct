//
//  XSTool.h
//  iOSProject
//
//  Created by 小四 on 2019/5/9.
//  Copyright © 2019 小四. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XSTool : NSObject

+ (instancetype)shareTools;

// 颜色
+ (UIColor *)colorWithHexString:(NSString*)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
//设置字符串中某字段的颜色和字体
+ (NSAttributedString *)willBecomeColorNeedStrOfAllStr:(NSString *)allStr needBecomeStr:(NSString *)becomeStr needColor:(UIColor *)color needFont:(UIFont *)font;

+ (UIViewController *)appRootVC;
//字符是否为空
+ (BOOL)isBlank:(NSString *)string;

// 网络判断
+(BOOL)isConnectionAvailable;

+ (UIViewController *)currentViewController;


//获取字符串的高度
+ (CGFloat)getHeightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width;

@end
