//
//  XSCornerShadowVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/6/28.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSCornerShadowVC.h"

@interface XSCornerShadowVC ()

@property(nonatomic,strong)UIView *baseView;
@property(nonatomic,strong)UIImageView *imgV;


@end

@implementation XSCornerShadowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBtn];
    [self.view addSubview:self.baseView];
    [self.view addSubview:self.imgV];
    
    // uiview 可以直接这样写圆角阴影 其他不可以
    self.baseView.layer.cornerRadius = 10;
    self.baseView.layer.masksToBounds = NO;
    self.baseView.layer.shadowColor = [UIColor redColor].CGColor;
    self.baseView.layer.shadowOpacity = 10;
    self.baseView.layer.shadowOffset = CGSizeMake(3, 3);
    self.baseView.layer.shadowRadius = 4;

    self.imgV.layer.cornerRadius = 10;
    self.imgV.layer.masksToBounds = NO;
    self.imgV.layer.shadowColor = [UIColor redColor].CGColor;
    self.imgV.layer.shadowOpacity = 10;
    self.imgV.layer.shadowOffset = CGSizeMake(3, 3);
    self.imgV.layer.shadowRadius = 4;
    
    

}

- (UIView *)baseView{
    if (!_baseView) {
        _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScaleWidth(100), kScaleWidth(100))];
        _baseView.center = self.view.center;
        _baseView.backgroundColor = [XSTool colorWithHexString:@"#F9F900"];
    }
    return _baseView;
}

- (UIImageView *)imgV{
    if (!_imgV) {
        _imgV = [[UIImageView alloc]initWithFrame:CGRectMake(kScaleWidth(15), kScaleWidth(30), kScreenWidth-kScaleWidth(30), kScaleWidth(70))];
        _imgV.image = [UIImage imageNamed:@"mineBanner"];
        _imgV.contentMode = UIViewContentModeScaleToFill;
    }
    return _imgV;
}

@end
