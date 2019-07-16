//
//  XSUserDefaultTool.m
//  iOSProject
//
//  Created by 小四 on 2019/5/10.
//  Copyright © 2019 小四. All rights reserved.
//

#import "XSUserDefaultTool.h"

static NSString *const kLoginStatus = @"kLoginStatus";
static NSString *const kFirstLaunch = @"kFirstLaunch";



@implementation XSUserDefaultTool

// 第一次打开
+ (void)setIsFirstLaunch:(BOOL)firstLaunch{
     [[NSUserDefaults standardUserDefaults] setBool:firstLaunch forKey:kFirstLaunch];
     [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getFirstLaunch{
     return [[NSUserDefaults standardUserDefaults] boolForKey:kFirstLaunch];
}


@end
