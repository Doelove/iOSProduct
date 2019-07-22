//
//  JYGesturePasswordVC.h
//  手势解锁GestureUnlock
//
//  Created by 软素 on 2019/5/7.
//  Copyright © 2019 软素. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GestureVCTypeSetting,
    GestureVCTypeLogin
}GestureVCType;



@interface JYGesturePasswordVC : XSBaseVC


@property(nonatomic,assign)GestureVCType type;


@end
