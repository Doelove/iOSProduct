//
//  XSUserDefaultTool.h
//  iOSProject
//
//  Created by 小四 on 2019/5/10.
//  Copyright © 2019 小四. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSUserDefaultTool : NSObject

// 首次打开
+ (void)setIsFirstLaunch:(BOOL)firstLaunch;
+ (BOOL)getFirstLaunch;



@end

NS_ASSUME_NONNULL_END
