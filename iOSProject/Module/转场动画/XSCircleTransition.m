//
//  XSCircleTransition.m
//  iOSProject
//
//  Created by 豆豆 on 2019/12/24.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSCircleTransition.h"
#import "XSCustomAnimationFirstVC.h"
#import "XSCustomAnimationSecondVC.h"


/*
    拆分动画
    1.其实动画就是2个圆圈，用贝塞尔画两个圆形，圆形的中心在右下角按钮的中心
    2.实现过渡动画
 
 */

@interface XSCircleTransition ()<CAAnimationDelegate>

@property(nonatomic,strong)id <UIViewControllerContextTransitioning> context; // 动画上下文

@end


@implementation XSCircleTransition


// 转场动画市场
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return .8;
}


// 定义转场动画内容
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    // 1.先拿到上下文：context。  上下文中保存了动画的基本信息 包括fromVC toVC
    _context = transitionContext;
    
    // 2.动画实现的view
    UIView *containerView = [transitionContext containerView];
    
    // 3.获取toVC/fromVC
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    
    // 4.创建一个公共按钮 （fromVC和toVC同一位置的按钮）
    UIButton *btn;
    XSCustomAnimationFirstVC *vc1;
    XSCustomAnimationSecondVC *vc2;
    
    
    if (self.isPush) {
        vc1 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        vc2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        btn = vc1.firstBtn;
    }else{
        vc2 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        vc1 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        btn = vc2.secondBtn;
    }
    
    // 5. 转场动画 实质 vc1.view 转换 vc2.view 所以需要把这两个vc的view添加到动画载体（containerView）上
    [containerView addSubview:vc1.view];
    [containerView addSubview:vc2.view];
    
    
    
    // 6. 拿到按钮的圆心
    CGPoint centerP = btn.center;
    
    // 7. 求的大圆半径
    CGFloat radius = 0.0;
    CGFloat y = CGRectGetHeight(toVC.view.bounds)-CGRectGetMaxY(btn.frame)+CGRectGetHeight(btn.bounds)/2;
    CGFloat x = CGRectGetWidth(toVC.view.bounds)-CGRectGetMaxX(btn.frame)+CGRectGetWidth(btn.bounds)/2;
    
    // 计算圆心在第几象限 不同象限计算大圆半径不同
    if (CGRectGetMidX(btn.frame) > CGRectGetWidth(toVC.view.bounds)/2) {
        if (CGRectGetMaxY(btn.frame) < CGRectGetHeight(toVC.view.bounds)/2) {
            // 第一象限
            radius = sqrtf(btn.center.x*btn.center.x + y*y);
        }else{
            radius = sqrtf(btn.center.x*btn.center.x + btn.center.y*btn.center.y);
        }
    }else{
        if (CGRectGetMidY(btn.frame) < CGRectGetHeight(toVC.view.bounds)/2) {
            radius = sqrtf(x*x+y*y);
        }else{
            radius = sqrtf(x*x + btn.center.y*btn.center.y);
        }
    }
    
    // 8.贝塞尔画出来 smallPath bigPath
    UIBezierPath *smallPath = [UIBezierPath bezierPathWithRect:btn.frame];
    UIBezierPath *bigPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    
    // 9.贝塞尔画出来 需要使用 CAShaperLayer 特殊图层
    CAShapeLayer *shaperLayer = [[CAShapeLayer alloc]init];
    if (self.isPush) {
        shaperLayer.path = bigPath.CGPath;
    }else{
        shaperLayer.path = smallPath.CGPath;
    }
    
    
    // 10.蒙版的形式 添加view 当前的vc的view
    UIViewController *vc;
    if (self.isPush) {
        vc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    }else{
        vc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    }
    
    vc.view.layer.mask = shaperLayer;
    
    // 11. shaperLayer 完成path
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"]; // 基本动画 修改的是path 路径
    if (self.isPush) {
        anim.fromValue = (id)smallPath.CGPath;
        anim.toValue = (id)bigPath.CGPath;
    }else{
        anim.fromValue = (id)bigPath.CGPath;
        anim.toValue = (id)smallPath.CGPath;
    }
    anim.duration = [self transitionDuration:transitionContext];
    anim.delegate = self;
    
    // 12. 给shaperLayer添加动画
    [shaperLayer addAnimation:anim forKey:nil];
    
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_context completeTransition:YES];
}

@end
