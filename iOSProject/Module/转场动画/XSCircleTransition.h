//
//  XSCircleTransition.h
//  iOSProject
//
//  Created by 豆豆 on 2019/12/24.
//  Copyright © 2019 软素. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 导入transitioning 协议
@interface XSCircleTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign)BOOL isPush;


@end

NS_ASSUME_NONNULL_END
