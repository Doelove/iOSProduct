//
//  JYGesturePasswordVC.m
//  手势解锁GestureUnlock
//
//  Created by 软素 on 2019/5/7.
//  Copyright © 2019 软素. All rights reserved.
//

#import "JYGesturePasswordVC.h"
#import "PCCircleView.h"
#import "PCCircle.h"
#import "PCCircleViewConst.h"
#import "PCLockLabel.h"
#import "PCCircleInfoView.h"
#import "AppDelegate.h"

@interface JYGesturePasswordVC ()<UINavigationControllerDelegate,CircleViewDelegate>

@property(nonatomic,strong)PCLockLabel *msgLabel;
@property(nonatomic,strong)PCCircleView *lockView;
@property(nonatomic,strong)PCCircleInfoView *infoView;

@end

@implementation JYGesturePasswordVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [PCCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:CircleViewBackgroundColor];
    self.navigationController.delegate = self;
    [self setupUI];
    
    switch (self.type) {
        case GestureVCTypeLogin:
            [self setupSubViewsLoginVC];
            break;
        case GestureVCTypeSetting:
            [self setupSubViewsSettingVC];
            break;
        default:
            break;
    }
}

- (void)setupUI{
    // 解锁界面
    PCCircleView *lockView = [[PCCircleView alloc] init];
    lockView.delegate = self;
    self.lockView = lockView;
    [self.view addSubview:lockView];
    
    PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
    msgLabel.frame = CGRectMake(0, 0, kScreenW, 14);
    msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 30);
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
}

- (void)setupSubViewsSettingVC{
    [self.lockView setType:CircleViewTypeSetting];
    
    [self.msgLabel showNormalMsg:gestureTextBeforeSet];
    
    PCCircleInfoView *infoView = [[PCCircleInfoView alloc]init];
    infoView.frame = CGRectMake(0, 0, CircleRadius * 2 * 0.6, CircleRadius * 2 * 0.6);
    infoView.center = CGPointMake(kScreenW/2, CGRectGetMinY(self.msgLabel.frame) - CGRectGetHeight(infoView.frame)/2 - 10);
    self.infoView = infoView;
    [self.view addSubview:infoView];
}


- (void)setupSubViewsLoginVC{
    
    [self.lockView setType:CircleViewTypeLogin];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
    imageView.center = CGPointMake(kScreenW/2, kScreenH/5);
    imageView.image = [UIImage imageNamed:@"head"];
    [self.view addSubview:imageView];
}

#pragma mark -- setting delegate
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type connectCirclesLessThanNeedWithGesture:(NSString *)gesture{
    NSString *gestureOne = [PCCircleViewConst getGestureWithKey:gestureOneSaveKey];
    if ([gestureOne length]) {
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
    }else{
        [self.msgLabel showWarnMsgAndShake:gestureTextConnectLess];
    }
}

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteSetFirstGesture:(NSString *)gesture{
    [self.msgLabel showWarnMsg:gestureTextDrawAgain];
    [self infoViewSelectedSubviewsSameAsCircleView:view];
    
}

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal{
    if (equal) {
        [self.msgLabel showWarnMsg:gestureTextSetSuccess];
        [PCCircleViewConst saveGesture:gesture Key:gestureFinalSaveKey];
//        [JYAppDelegate returnRootMainTabbar];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
    }
}

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal{
    if (type == CircleViewTypeLogin) {
        if (equal) {
//            [JYAppDelegate returnRootMainTabbar];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.msgLabel showWarnMsgAndShake:gestureTextGestureVerifyError];
        }
    }else if (type == CircleViewTypeVerify){
        if (equal) {
            NSLog(@"验证成功，跳转到设置手势界面");
        } else {
            [SVProgressHUD showInfoWithStatus:@"原手势密码输入错误！"];
            [SVProgressHUD dismissWithDelay:0.3];
        }
    }
    
}

#pragma mark -- infoView
- (void)infoViewSelectedSubviewsSameAsCircleView:(PCCircleView *)circleView{
    for (PCCircle *circle in circleView.subviews) {
        if (circle.cState == CircleStateSelected || circle.cState == CircleStateLastOneSelected) {
            for (PCCircle *infoCircle in self.infoView.subviews) {
                if (infoCircle.tag == circle.tag) {
                    [infoCircle setCState:CircleStateSelected];
                }
            }
        }
    }
}

- (void)infoViewdeselectedSubviews{
    [self.infoView.subviews enumerateObjectsUsingBlock:^(PCCircle *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setCState:CircleStateNormal];
    }];
}

- (PCCircleView *)lockView{
    if (!_lockView) {
        _lockView = [[PCCircleView alloc]init];
        _lockView.delegate = self;
    }
    return _lockView;
}

- (PCLockLabel *)msgLabel{
    if (!_msgLabel) {
        _msgLabel = [[PCLockLabel alloc]init];
        _msgLabel.frame = CGRectMake(0, 0, kScreenW, 14);
        _msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(self.lockView.frame)-30);
    }
    return _msgLabel;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



































@end
