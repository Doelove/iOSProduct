//
//  XSSideMenuMainVC.h
//  iOSProject
//
//  Created by 豆豆 on 2019/8/26.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSBaseVC.h"
#import "XSSideMenuHomeVC.h"
#import "XSSideMenuRightVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSSideMenuMainVC : XSBaseVC

+ (instancetype)createMainVCWithHomeVC:(XSSideMenuHomeVC *)homdeVC rightVC:(XSSideMenuRightVC *)rightVC;


@end

NS_ASSUME_NONNULL_END
