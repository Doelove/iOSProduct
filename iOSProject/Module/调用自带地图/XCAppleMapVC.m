//
//  XCAppleMapVC.m
//  iOSProject
//
//  Created by 豆豆 on 2020/10/19.
//  Copyright © 2020 软素. All rights reserved.
//

#import "XCAppleMapVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "GXPickerView.h"

@interface XCAppleMapVC ()<UITextFieldDelegate,GXPickerViewDelegate>

@property(nonatomic, strong)UIButton *btn;
@property(nonatomic, strong)UITextField *inputTextField;

@property(nonatomic, assign)float lat;
@property(nonatomic, assign)float lon;

@property(nonatomic, strong)CLGeocoder *geoCoder;
@property(nonatomic, strong)GXPickerView *pickerView;


@end

@implementation XCAppleMapVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.view addSubview:self.btn];
    [self.view addSubview:self.inputTextField];

}

- (UITextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 300, 200, 50)];
        _inputTextField.delegate = self;
        _inputTextField.backgroundColor = [UIColor lightGrayColor];
        _inputTextField.layer.cornerRadius = 2;
        _inputTextField.layer.masksToBounds = YES;
    }
    return _inputTextField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    __weak typeof(self) weakSelf = self;
    
    [self.geoCoder geocodeAddressString:textField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error) {
            [SVProgressHUD showInfoWithStatus:@"报错"];
            return;
        }
       
        if (!placemarks.count || error) {
            [SVProgressHUD showInfoWithStatus:@"没有找到相关经纬度"];
            return;
        }
        
        [weakSelf createAlertTitle:@"提示" message:[NSString stringWithFormat:@"一共查询到%lu条数据",(unsigned long)placemarks.count] leftTitle:@"取消" rightTitle:@"确定" block:^{
            
            [weakSelf createPickerWithList:placemarks];
            
        }];
        
        
        
    }];
}

- (CLGeocoder *)geoCoder{
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc]init];
    }
    return _geoCoder;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(50, 200, 200, 50);
        _btn.backgroundColor = [UIColor cyanColor];
        _btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        [_btn setTitle:@"地图" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)handleSelectAction:(UIButton *)sender{
    
    MKMapItem *myLocation = [MKMapItem mapItemForCurrentLocation];

    CLLocationCoordinate2D coords2 = CLLocationCoordinate2DMake(self.lat, self.lon);
    
    MKMapItem *toLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:coords2 addressDictionary:nil]];
    
    toLocation.name = @"目的地";
    NSArray *items = [NSArray arrayWithObjects:myLocation,toLocation, nil];
    NSDictionary *options =@{
        MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
        MKLaunchOptionsMapTypeKey:[NSNumber numberWithInteger:MKMapTypeStandard],
        MKLaunchOptionsShowsTrafficKey:@YES
    };
    [MKMapItem openMapsWithItems:items launchOptions:options];
}


- (void)createAlertTitle:(NSString *)title message:(NSString *)message leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle block:(SelectBlock)block{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleCancel handler:nil]];
    [alertC addAction:[UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block();
        }
    }]];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (UIViewController *)appRootVC{
    UIViewController *topVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVc.presentedViewController != nil) {
        topVc = topVc.presentedViewController;
    }
    return topVc;
}


#pragma mark -- pickerView
- (void)createPickerWithList:(NSArray *)list{
    GXPickerView *view = [[GXPickerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.delegate = self;
    self.pickerView = view;
    view.dataList = list;
    [self.view addSubview:view];
    [view remakePicker];
}

- (void)handleSelectCode:(NSString *)code value:(NSString *)value{
    
    NSInteger index = [code integerValue];
    CLPlacemark *mark = self.pickerView.dataList[index];
    
    self.lat = mark.location.coordinate.latitude;
    self.lon = mark.location.coordinate.longitude;
}


@end
