//
//  XSSideMenuMainVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/8/26.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSSideMenuMainVC.h"


@interface XSSideMenuMainVC ()

@property(nonatomic,strong)XSSideMenuHomeVC *homeVC;
@property(nonatomic,strong)XSSideMenuRightVC *rightVC;

@property(nonatomic,strong)UITapGestureRecognizer *tapGesture;
@property(nonatomic,strong)UIPanGestureRecognizer *pan;

@end

@implementation XSSideMenuMainVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 需要自定义导航栏，系统导航栏无法跟随移动
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // 关闭侧边左滑返回上页面
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


+ (instancetype)createMainVCWithHomeVC:(XSSideMenuHomeVC *)homdeVC rightVC:(XSSideMenuRightVC *)rightVC{
    return [[XSSideMenuMainVC alloc]initWithHomeVC:homdeVC rightVC:rightVC];
}

- (instancetype)initWithHomeVC:(XSSideMenuHomeVC *)homeVC rightVC:(XSSideMenuRightVC *)rightVC{
    self = [super init];
    if (self) {
        self.homeVC = homeVC;
        self.rightVC = rightVC;
        [self setupUI];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    [self addChildViewController:self.homeVC];
    [self addChildViewController:self.rightVC];
    
    self.homeVC.view.frame = self.view.bounds;
    self.rightVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth-kScaleWidth(100), kScreenHeight);
    
    [self.view addSubview:self.rightVC.view]; // 侧边栏放在底层
    [self.view addSubview:self.homeVC.view];
    
    [self.homeVC.view addGestureRecognizer:self.pan];
    [self.homeVC.view addGestureRecognizer:self.tapGesture];
    
    JYWeakSelf
    self.homeVC.block = ^(BOOL isSelect) {
        if (isSelect) {
            [weakSelf showLeftVC];
        }else{
            [weakSelf hideLeftVC];
        }
    };
    
}

- (void)screenGesture:(UIPanGestureRecognizer *)pan{
    // 移动的距离
    CGPoint point = [pan translationInView:pan.view];
    // 移动控件
    self.homeVC.view.transform = CGAffineTransformTranslate(self.homeVC.view.transform, point.x, 0);
    self.rightVC.view.transform = CGAffineTransformTranslate(self.homeVC.view.transform, point.x, 0);
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (self.homeVC.view.x >= -kScreenWidth+200) {
            [self hideLeftVC];
        }else{
            [self showLeftVC];
        }
    }
    // 复位,表示相对上一次
    [pan setTranslation:CGPointZero inView:pan.view];
}

- (void)hideLeftVC{
    JYWeakSelf
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.homeVC.view.x = 0;
        weakSelf.rightVC.view.x = kScreenWidth;
    } completion:^(BOOL finished) {
        weakSelf.pan.enabled = NO;
        weakSelf.tapGesture.enabled = NO;
    }];
}

- (void)showLeftVC{
    JYWeakSelf
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.homeVC.view.x = -kScreenWidth+kScaleWidth(100);
        weakSelf.rightVC.view.x = kScaleWidth(100);
    } completion:^(BOOL finished) {
        weakSelf.pan.enabled = YES;
        weakSelf.tapGesture.enabled = YES;
    }];
    self.homeVC.isRightSelected = NO;
}

- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideLeftVC)];
    }
    return _tapGesture;
}

-(UIPanGestureRecognizer *)pan{
    if (!_pan) {
        _pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(screenGesture:)];
        _pan.enabled = NO;
    }
    return _pan;
}

@end
