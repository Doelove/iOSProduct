//
//  XSSpringVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/7/8.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSSpringVC.h"

@interface XSSpringVC ()

@property(nonatomic,strong)UIView *view1;
@property(nonatomic,strong)UIView *view2;

@end

@implementation XSSpringVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBtn];
    [self.view addSubview:self.view1];
    [self.view addSubview:self.view2];
    
    JYWeakSelf
    [UIView animateWithDuration:0.5 delay:1 usingSpringWithDamping:0.7 initialSpringVelocity:10 options:0 animations:^{
        weakSelf.view1.y = 200;
        [weakSelf.view1 layoutIfNeeded];
        
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:1 usingSpringWithDamping:0.9 initialSpringVelocity:10 options:0 animations:^{
        weakSelf.view2.y = 200;
    } completion:nil];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
//
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=[NSNumber numberWithFloat:0.5];
    animation.toValue=[NSNumber numberWithFloat:1.0];
    animation.duration=0.3;
    animation.autoreverses=YES;
    animation.repeatCount=0;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [view.layer addAnimation:animation forKey:@"zoom"];
    
}

- (UIView *)view1{
    if (!_view1) {
        _view1 = [[UIView alloc]initWithFrame:CGRectMake(50, 0, 100, 100)];
        _view1.backgroundColor = [XSTool colorWithHexString:@"#F90000"];
    }
    return _view1;
}

- (UIView *)view2{
    if (!_view2) {
        _view2 = [[UIView alloc]initWithFrame:CGRectMake(200, 0, 100, 100)];
        _view2.backgroundColor = [XSTool colorWithHexString:@"#00F900"];
    }
    return _view2;
}



@end
