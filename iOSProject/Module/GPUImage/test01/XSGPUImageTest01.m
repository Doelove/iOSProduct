//
//  XSGPUImageTest01.m
//  iOSProject
//
//  Created by 豆豆 on 2020/3/27.
//  Copyright © 2020 软素. All rights reserved.
//

#import "XSGPUImageTest01.h"
#import <GPUImage/GPUImage.h>
#import <GPUImageView.h>

@interface XSGPUImageTest01 ()

@property(nonatomic,strong)UIImageView *mImgV;

@end

@implementation XSGPUImageTest01

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.view addSubview:self.mImgV];
    
    GPUImageFilter *filter = [[GPUImageFilter alloc]init];
    UIImage *img = [UIImage imageNamed:@"2.jpeg"];
    self.mImgV.image = [filter imageByFilteringImage:img];

}

- (UIImageView *)mImgV{
    if (!_mImgV) {
        _mImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _mImgV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _mImgV;
}



@end
