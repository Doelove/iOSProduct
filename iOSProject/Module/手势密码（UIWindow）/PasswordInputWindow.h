//
//  PasswordInputWindow.h
//  iOSProject
//
//  Created by 豆豆 on 2019/7/18.
//  Copyright © 2019 软素. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PasswordInputWindow : UIWindow

+ (PasswordInputWindow *)sharedInstance;
- (void)show;

@end

NS_ASSUME_NONNULL_END
