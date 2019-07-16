//
//  XSTool.m
//  iOSProject
//
//  Created by 小四 on 2019/5/9.
//  Copyright © 2019 小四. All rights reserved.
//

#import "XSTool.h"


static XSTool * _tools = nil;

@implementation XSTool

+ (instancetype)shareTools{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tools = [[super allocWithZone:NULL]init];
    });
    
    
    
    return _tools;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self shareTools];
}

- (id)copyWithZone:(NSZone *)zone{
    return _tools;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return _tools;
}


#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *)colorWithHexString:(NSString*)color{
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

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
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
    return [UIColor colorWithRed:((float)r / 255.0f)green:((float)g / 255.0f)blue:((float)b / 255.0f)alpha:alpha];
}

+ (NSAttributedString *)willBecomeColorNeedStrOfAllStr:(NSString *)allStr needBecomeStr:(NSString *)becomeStr needColor:(UIColor *)color needFont:(UIFont *)font
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:allStr];
    NSRange range = [allStr rangeOfString:becomeStr];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    return attributedString;
}

+ (UIViewController *)appRootVC{
    UIViewController *topVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVc.presentedViewController != nil) {
        topVc = topVc.presentedViewController;
    }
    return topVc;
}

+ (BOOL)isBlank:(NSString *)string {
    if(nil != string) {
        if((string.length > 0)
           && (![string isEqualToString:@"<null>"])
           && (![string isEqualToString:@"<NULL>"])
           && (![string isEqualToString:@"<Null>"])
           && (![string isEqualToString:@" "])
           ) {
            return false;
        }
    }
    return true;
}

// 网络判断
+(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
    }
    return isExistenceNetwork;
}

// 当前控制器
+ (UIViewController *)currentViewController
{
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController)
    {
        vc = vc.presentedViewController;
        
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            vc = [(UINavigationController *)vc visibleViewController];
        }
        else if ([vc isKindOfClass:[UITabBarController class]])
        {
            vc = [(UITabBarController *)vc selectedViewController];
        }
    }
    return vc;
}

//获取字符串的高度
+ (CGFloat)getHeightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width
{
    CGRect rect = [value boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.height;
}

@end
