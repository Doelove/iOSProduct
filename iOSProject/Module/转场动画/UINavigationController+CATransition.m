//
//  UINavigationController+CATransition.m
//  iOSProject
//
//  Created by 豆豆 on 2019/12/23.
//  Copyright © 2019 软素. All rights reserved.
//

#import "UINavigationController+CATransition.h"

#define kTransitionDur 0.7

@implementation UINavigationController (CATransition)


- (void)pushViewController:(UIViewController *)viewController withCATransitionTypeStr:(NSString *)typeStr subTypeStr:(NSString *)subTypeStr animated:(BOOL)animated{
    
    CATransition *transition = [CATransition animation];
    transition.duration = kTransitionDur;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = typeStr;
    transition.subtype = subTypeStr;
    [self.view.layer addAnimation:transition forKey:@"animation"];
    [self pushViewController:viewController animated:animated];
}

- (void)popViewControllerWithCATransitionTypeStr:(NSString *)typeStr subTypeStr:(NSString *)subTypeStr animated:(BOOL)animated{
    
    CATransition *transition = [CATransition animation];
    transition.duration = kTransitionDur;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = typeStr;
    transition.subtype = subTypeStr;
    [self.view.layer addAnimation:transition forKey:@"animation"];
    [self popViewControllerAnimated:animated];
}

- (void)pushViewController:(UIViewController *)viewController withCATransitionType:(XSCATransitionType)type subType:(XSCATransitionSubType)subType animated:(BOOL)animated{
    
    NSString *typeStr = [self getCATransitionTypeStrWithCATransitionType:type];
    NSString *typeSubStr = [self getCATransitionSubType:subType];
    [self pushViewController:viewController withCATransitionTypeStr:typeStr subTypeStr:typeSubStr animated:animated];
}

- (void)popViewControllerWithCATransitionType:(XSCATransitionType)type subType:(XSCATransitionSubType)subType animated:(BOOL)animated{
    
    NSString *typeStr = [self getCATransitionTypeStrWithCATransitionType:type];
    NSString *typeSubStr = [self getCATransitionSubType:subType];
    [self popViewControllerWithCATransitionTypeStr:typeStr subTypeStr:typeSubStr animated:animated];
}


- (NSString *)getCATransitionSubType:(XSCATransitionSubType)subType{
    
    switch (subType) {
        case XSCATransitionSubTypeFromTop:
            return kCATransitionFromTop;
            break;
        case XSCATransitionSubTypeFromLeft:
            return kCATransitionFromLeft;
            break;
        case XSCATransitionSubTypeFromRight:
            return kCATransitionFromRight;
            break;
        case XSCATransitionSubTypeFromBottom:
            return kCATransitionFromBottom;
            break;
        default:
            break;
    }
}

- (NSString *)getCATransitionTypeStrWithCATransitionType:(XSCATransitionType)type{
    switch (type) {
        case XSCATransitionTypeFade:
            return kCATransitionFade;
            break;
        case XSCATransitionTypeMoveIn:
            return kCATransitionMoveIn;
            break;
        case XSCATransitionTypePush:
            return kCATransitionPush;
            break;
        case XSCATransitionTypeReveal:
            return kCATransitionReveal;
            break;
        case XSCATransitionTypeCube:
            return @"cube";
            break;
        case XSCATransitionTypeSuckEffect:
            return @"suckEffect";
            break;
        case XSCATransitionTypeOglFlip:
            return @"oglFlip";
            break;
        case XSCATransitionTypeRippleEffect:
            return @"rippleEffect";
            break;
        case XSCATransitionTypePageCurl:
            return @"pageCurl";
            break;
        case XSCATransitionTypePageUnCurl:
            return @"pageUnCurl";
            break;
        case XSCATransitionTypeCameraIrisHollowOpen:
            return @"cameraIrisHollowOpen";
            break;
        case XSCATransitionTypeCameraIrisHollowClose:
            return @"cameraIrisHollowClose";
            break;
        default:
            return @"";
            break;
    }
}






@end
