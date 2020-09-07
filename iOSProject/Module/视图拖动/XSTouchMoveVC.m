//
//  XSTouchMoveVC.m
//  iOSProject
//
//  Created by 豆豆 on 2020/8/7.
//  Copyright © 2020 软素. All rights reserved.
//

#import "XSTouchMoveVC.h"
#import "XSTouchView.h"

@interface XSTouchMoveVC ()

@end

@implementation XSTouchMoveVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    XSTouchView *touchView = [[XSTouchView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    touchView.backgroundColor = [XSTool colorWithHexString:navcolor];
    [self.view addSubview:touchView];
    
    UIView *panView = [[UIView alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
    panView.backgroundColor = [UIColor orangeColor];
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [panView addGestureRecognizer:panGR];
    [self.view addSubview:panView];

}

- (void)handlePan:(UIPanGestureRecognizer *)panGR{
    if (panGR.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始");
    }else if (panGR.state == UIGestureRecognizerStateChanged){
        
        CGPoint location = [panGR locationInView:self.view];
        
        CGFloat viewH = self.view.frame.size.height;
        
        if (location.y-100 < 0 || location.y > viewH-100) {
            return;
        }
        CGPoint translation = [panGR translationInView:self.view];
        panGR.view.center = CGPointMake(panGR.view.center.x + translation.x, panGR.view.center.y + translation.y);
        [panGR setTranslation:CGPointZero inView:self.view];
    }else if (panGR.state == UIGestureRecognizerStateEnded){
        NSLog(@"结束");
    }
}


@end
