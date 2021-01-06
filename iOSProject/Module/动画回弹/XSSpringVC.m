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

@property(nonatomic,strong)CAEmitterLayer *fireEmitter;

@end

@implementation XSSpringVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self createFire];
    [self createAnimate];
    
}

- (void)createAnimate{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    //
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=[NSNumber numberWithFloat:0.5];
    animation.toValue=[NSNumber numberWithFloat:1.0];
    animation.duration=2;
    animation.autoreverses=YES;
    animation.repeatCount=MAXFLOAT;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [view.layer addAnimation:animation forKey:@"zoom"];
    
    
    [self.view addSubview:self.view1];
    [self.view addSubview:self.view2];
    
    JYWeakSelf
    // 回弹
    /**
     + (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
     
     dampingRatio：弹簧效果的强弱 1没有回弹 0会有剧烈的阻尼回弹
     velocity：设置弹簧的初始速度
     */
    
    // UIView动画可以操作的视图属性有 frame，bounds，center，transform，alpha，backgroundColor，contentStretch
    
    [UIView animateWithDuration:0.5 delay:1 usingSpringWithDamping:0.7 initialSpringVelocity:30 options:0 animations:^{
        weakSelf.view1.y = 200;
        [weakSelf.view1 layoutIfNeeded];
        
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:1 usingSpringWithDamping:0.9 initialSpringVelocity:10 options:0 animations:^{
        weakSelf.view2.y = 200;
    } completion:nil];
    
}

- (UIView *)view1{
    if (!_view1) {
        _view1 = [[UIView alloc]initWithFrame:CGRectMake(50, 0, 100, 100)];
        _view1.backgroundColor = [XSTool colorWithHexString:@"#F9F000"];
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


- (void)createFire{
    self.view.backgroundColor=[UIColor blackColor];
    //设置发射器
    _fireEmitter=[[CAEmitterLayer alloc]init];
    _fireEmitter.emitterPosition=CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height-20);
    _fireEmitter.emitterSize=CGSizeMake(self.view.frame.size.width-100, 20);
    _fireEmitter.renderMode = kCAEmitterLayerAdditive;
    //发射单元
    //火焰
    CAEmitterCell * fire = [CAEmitterCell emitterCell];
    fire.birthRate=800;
    fire.lifetime=2.0;
    fire.lifetimeRange=1.5;
    fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
    fire.contents=(id)[[UIImage imageNamed:@"Particles_fire.png"]CGImage];
    [fire setName:@"fire"];
    
    fire.velocity=160;
    fire.velocityRange=80;
    fire.emissionLongitude=M_PI+M_PI_2;
    fire.emissionRange=M_PI_2;
    
    
    
    fire.scaleSpeed=0.3;
    fire.spin=0.2;
    
    //烟雾
    CAEmitterCell * smoke = [CAEmitterCell emitterCell];
    smoke.birthRate=400;
    smoke.lifetime=3.0;
    smoke.lifetimeRange=1.5;
    smoke.color=[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.05]CGColor];
    smoke.contents=(id)[[UIImage imageNamed:@"Particles_fire.png"]CGImage];
    [fire setName:@"smoke"];
    
    smoke.velocity=250;
    smoke.velocityRange=100;
    smoke.emissionLongitude=M_PI+M_PI_2;
    smoke.emissionRange=M_PI_2;
    
    _fireEmitter.emitterCells=[NSArray arrayWithObjects:smoke,fire,nil];
    [self.view.layer addSublayer:_fireEmitter];
}



@end
