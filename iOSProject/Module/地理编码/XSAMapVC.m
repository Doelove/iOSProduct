//
//  XSAMapVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/10/24.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSAMapVC.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <MAMapKit/MAMapKit.h>

@interface XSAMapVC ()<AMapSearchDelegate,UITextFieldDelegate,MAMapViewDelegate>

@property(nonatomic,strong)AMapSearchAPI *search;
@property(nonatomic,strong)UITextField *inputTextField;
@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,strong)MAPointAnnotation *point;

@end

@implementation XSAMapVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [AMapServices sharedServices].enableHTTPS = YES;
    self.search = [[AMapSearchAPI alloc]init];
    self.search.delegate = self;
    [self.view addSubview:self.inputTextField];
    
    self.mapView.zoomLevel = 15.5;
    [self.view addSubview:self.mapView];
    
}

- (UITextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(kScaleWidth(10), kScaleWidth(100), kScreenWidth-kScaleWidth(20), kScaleWidth(45))];
        _inputTextField.delegate = self;
        _inputTextField.placeholder = @"请输入要定位的地址";
        _inputTextField.backgroundColor = [XSTool colorWithHexString:@"#FAFAFA"];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        _inputTextField.leftView = view;
        _inputTextField.leftViewMode = UITextFieldViewModeAlways;
        _inputTextField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kScaleWidth(12)];
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
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc]init];
    geo.address = textField.text;
    [self.search AMapGeocodeSearch:geo];
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    if (response.geocodes.count == 0) {
        return;
    }
    AMapGeocode *reult = response.geocodes.firstObject;
    NSLog(@"结果\n%f",reult.location.latitude);
    NSLog(@"lng%f",reult.location.longitude);
    
    
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(reult.location.latitude, reult.location.longitude) animated:YES];
    self.point.coordinate = CLLocationCoordinate2DMake(reult.location.latitude, reult.location.longitude);
    [self.mapView addAnnotation:self.point];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointId = @"pointId";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointId];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointId];
        }
        return annotationView;
        
    }
    return nil;
}


- (MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.inputTextField.frame)+kScaleWidth(15), kScreenWidth, kScaleWidth(400))];
        _mapView.delegate = self;
    }
    return _mapView;
}

- (MAPointAnnotation *)point{
    if (!_point) {
        _point = [[MAPointAnnotation alloc]init];
    }
    return _point;
}

@end
