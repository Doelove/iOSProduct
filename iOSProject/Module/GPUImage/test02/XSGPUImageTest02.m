//
//  XSGPUImageTest02.m
//  iOSProject
//
//  Created by 豆豆 on 2020/3/27.
//  Copyright © 2020 软素. All rights reserved.
//

#import "XSGPUImageTest02.h"
#import <GPUImageView.h>
#import <GPUImageVideoCamera.h>
#import <GPUImageSepiaFilter.h>  // 棕褐色滤镜


@interface XSGPUImageTest02 ()

@property(nonatomic,strong)GPUImageView *dGPUImageView;
@property(nonatomic,strong)GPUImageVideoCamera *dVideoCamera;

@end

@implementation XSGPUImageTest02

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dVideoCamera = [[GPUImageVideoCamera alloc]initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    
    
    self.dGPUImageView.fillMode = kGPUImageFillModeStretch;
    
    //棕褐色滤镜 初始化
    GPUImageSepiaFilter *filter = [[GPUImageSepiaFilter alloc]init];
    
    //videoCamera获取的图像帧添加上滤镜
    [self.dVideoCamera addTarget:filter];
    
    // 添加到最终的显示imgview
    [filter addTarget:self.dGPUImageView];

    
    [self.dVideoCamera startCameraCapture];

}


- (GPUImageView *)dGPUImageView{
    if (!_dGPUImageView) {
        _dGPUImageView = [[GPUImageView alloc]initWithFrame:self.view.bounds];
    }
    return _dGPUImageView;
}








@end
