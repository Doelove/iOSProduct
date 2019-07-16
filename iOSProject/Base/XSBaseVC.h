//
//  XSBaseVC.h
//  iOSProject
//
//  Created by 小四 on 2019/5/9.
//  Copyright © 2019 小四. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSBaseVC : UIViewController

@property(nonatomic,assign)CGFloat tabbarHeight;
@property(nonatomic,strong)UIColor *tableViewColor;


- (void)pushVC:(UIViewController *)vc;

- (void)setBackBtn;
- (void)handleBaseReturn;
- (void)hideBackBtn;
- (NSString *)getToken;
- (void)configLogin;
/*
    退出输入框
 */
- (void)resignKBFirstResponse;

@end
