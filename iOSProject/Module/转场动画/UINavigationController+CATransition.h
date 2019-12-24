//
//  UINavigationController+CATransition.h
//  iOSProject
//
//  Created by 豆豆 on 2019/12/23.
//  Copyright © 2019 软素. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XSCATransitionType) {
    XSCATransitionTypeFade = 1,                 // 淡化
    XSCATransitionTypeMoveIn,                   // 覆盖
    XSCATransitionTypePush,                     // push
    XSCATransitionTypeReveal,                   // 揭开
    
    XSCATransitionTypeCube,                     // 3D立方
    XSCATransitionTypeSuckEffect,               // 吮吸
    XSCATransitionTypeOglFlip,                  // 翻转
    XSCATransitionTypeRippleEffect,             // 波纹
    
    XSCATransitionTypePageCurl,                 // 翻页
    XSCATransitionTypePageUnCurl,               // 反翻页
    XSCATransitionTypeCameraIrisHollowOpen,     // 开镜头
    XSCATransitionTypeCameraIrisHollowClose,    // 关镜头
    
    
};

typedef NS_ENUM(NSInteger,XSCATransitionSubType) {
    XSCATransitionSubTypeFromRight = 1,
    XSCATransitionSubTypeFromLeft,
    XSCATransitionSubTypeFromTop,
    XSCATransitionSubTypeFromBottom
};

@interface UINavigationController (CATransition)


- (void)pushViewController:(UIViewController *)viewController withCATransitionType:(XSCATransitionType)type subType:(XSCATransitionSubType)subType animated:(BOOL)animated;
- (void)popViewControllerWithCATransitionType:(XSCATransitionType)type subType:(XSCATransitionSubType)subType animated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
