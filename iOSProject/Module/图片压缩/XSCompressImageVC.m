//
//  XSCompressImageVC.m
//  iOSProject
//
//  Created by 豆豆 on 2020/8/14.
//  Copyright © 2020 软素. All rights reserved.
//

#import "XSCompressImageVC.h"
#import <CoreServices/CoreServices.h>

#define kMaxImageLength 300*1024*8

@interface XSCompressImageVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic, strong)UIButton *cameraBtn;
@property(nonatomic, strong)UIButton *libraryBtn;

@property(nonatomic,strong)UIImagePickerController *libraryPicker;
@property(nonatomic,strong)UIImagePickerController *cameraPicker;

@property(nonatomic, strong)UIImageView *scaleImageView;

@end

@implementation XSCompressImageVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.cameraBtn];
    [self.view addSubview:self.libraryBtn];
    [self.cameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScaleWidth(20));
        make.right.mas_equalTo(-kScaleWidth(20));
        make.height.mas_equalTo(kScaleWidth(45));
        make.bottom.mas_equalTo(-kScaleWidth(50));
    }];
    JYWeakSelf
    [self.libraryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf.cameraBtn.mas_width);
        make.height.mas_equalTo(weakSelf.cameraBtn.mas_height);
        make.centerX.mas_equalTo(weakSelf.cameraBtn.mas_centerX);
        make.bottom.mas_equalTo(weakSelf.cameraBtn.mas_top).mas_offset(-kScaleWidth(20));
    }];
    self.cameraBtn.layer.cornerRadius = kScaleWidth(5);
    self.cameraBtn.layer.masksToBounds = YES;
    self.libraryBtn.layer.cornerRadius = kScaleWidth(5);
    self.libraryBtn.layer.masksToBounds = YES;
}



#pragma mark -- 调用 拍照 相册
- (UIImagePickerController *)cameraPicker{
    if (!_cameraPicker) {
        _cameraPicker = [[UIImagePickerController alloc] init];
        _cameraPicker.delegate = self;
        _cameraPicker.allowsEditing = YES;// 设置可编辑
        _cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _cameraPicker.modalPresentationStyle = UIModalPresentationFullScreen;
        _cameraPicker.mediaTypes = @[(NSString *)kUTTypeImage];
        _cameraPicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    }
    return _cameraPicker;
}

- (UIImagePickerController *)libraryPicker{
    if (!_libraryPicker) {
        _libraryPicker = [[UIImagePickerController alloc] init];
        _libraryPicker.delegate = self;
        _libraryPicker.allowsEditing = YES;// 设置可编辑
        _libraryPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    return _libraryPicker;
}

#pragma mark -- picker image 代理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    CGImageRef cgImageRef = [image CGImage];
    CGFloat width = CGImageGetWidth(cgImageRef);
    CGFloat height = CGImageGetHeight(cgImageRef);
    NSData *photoData = UIImageJPEGRepresentation(image, 1);
    

    NSData *scaleData = [self compressImage:image];
    UIImage *scaleImage = [UIImage imageWithData:scaleData];
    
    CGImageRef scaleImageRef = [scaleImage CGImage];
    CGFloat scaleWidth = CGImageGetWidth(scaleImageRef);
    CGFloat scaleHeight = CGImageGetHeight(scaleImageRef);
    
    
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self createImageWithData:photoData scaleData:scaleData];
    }];
    
    CGFloat imageMemory = photoData.length/8/1024;
    CGFloat scaleMemory = scaleData.length/8/1024;
    
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"压缩尺寸前大小：%lukb、宽：%.2f、高：%.2f\n压缩尺寸后大小：%lukb，宽：%.2f，高：%.2f",(unsigned long)imageMemory,width,height,(unsigned long)scaleMemory,scaleWidth,scaleHeight] message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
    
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (NSData *)compressImage:(UIImage *)image{
    NSData *imgData = UIImageJPEGRepresentation(image, 1);
    if (imgData.length > kMaxImageLength) {
        CGImageRef cgImageRef = [image CGImage];
        CGFloat width = CGImageGetWidth(cgImageRef);
        CGFloat height = CGImageGetHeight(cgImageRef);
        if (width > kScreenWidth*2) {
//            CGFloat scale = width / (kScreenWidth*2);
            CGSize newSize = CGSizeMake(width/2, height/2);
            UIGraphicsBeginImageContext(newSize);
            [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
            UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            imgData = UIImageJPEGRepresentation(scaleImage, 1);
        }else{
            imgData = UIImageJPEGRepresentation(image, 0.5);
        }
    }
    return imgData;
}


- (void)createImageWithData:(NSData *)imageData scaleData:(NSData *)scaleData{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];

    
    UIImage *image1 = [UIImage imageWithData:scaleData];
    CGImageRef cgImageRef1 = [image1 CGImage];
    CGFloat width1 = CGImageGetWidth(cgImageRef1);
    CGFloat height1 = CGImageGetHeight(cgImageRef1);
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageView1.contentMode = UIViewContentModeScaleAspectFit;
    imageView1.image = image1;
    imageView1.center = self.view.center;
    imageView1.userInteractionEnabled = YES;
    [imageView1 addGestureRecognizer:tap];
    [self.view addSubview:imageView1];
    
    
    self.scaleImageView = imageView1;
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBaseView:)];
    
    UIView *baseView = [[UIView alloc]initWithFrame:self.view.bounds];
    baseView.backgroundColor = [UIColor blackColor];
    baseView.userInteractionEnabled = YES;
    
    UIImageView *selectImgV = self.scaleImageView;
    selectImgV.frame = CGRectMake(0, 0, CGRectGetWidth(self.scaleImageView.frame), CGRectGetHeight(self.scaleImageView.frame));
    selectImgV.center = self.view.center;

    
    
    [baseView addGestureRecognizer:tap2];
    [self.view insertSubview:baseView belowSubview:selectImgV];
}

- (void)tapBaseView:(UITapGestureRecognizer *)tap{
    UIView *view = tap.view;
    [view removeFromSuperview];
    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error != nil) {
        //保存失败
    }
}



- (UIButton *)cameraBtn{
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cameraBtn.backgroundColor = [UIColor cyanColor];
        _cameraBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(16)];
        [_cameraBtn setTitle:@"相机" forState:UIControlStateNormal];
        [_cameraBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cameraBtn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraBtn;
}


- (UIButton *)libraryBtn{
    if (!_libraryBtn) {
        _libraryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _libraryBtn.backgroundColor = [UIColor cyanColor];
        _libraryBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(16)];
        [_libraryBtn setTitle:@"相册" forState:UIControlStateNormal];
        [_libraryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_libraryBtn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _libraryBtn;
}

- (void)handleSelectAction:(UIButton *)sender{
    
    if (sender == self.libraryBtn) {
        [self presentViewController:self.libraryPicker animated:YES completion:nil];
    }else{
        [self presentViewController:self.cameraPicker animated:YES completion:nil];
    }
    
}

@end
