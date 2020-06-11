//
//  XSLocationVC.m
//  iOSProject
//
//  Created by 豆豆 on 2020/3/15.
//  Copyright © 2020 软素. All rights reserved.
//

#import "XSLocationVC.h"
#import <CoreLocation/CoreLocation.h>


@interface XSLocationVC ()<CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *locManager;


@end

@implementation XSLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([CLLocationManager locationServicesEnabled]) {
        _locManager = [[CLLocationManager alloc]init];
        _locManager.delegate = self;
        [_locManager requestAlwaysAuthorization];
        [_locManager  requestWhenInUseAuthorization];
        
        _locManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locManager.distanceFilter = 5.0;
        [_locManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [_locManager stopUpdatingHeading];
    
    CLLocation *currentLoc = locations.lastObject;
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    JYWeakSelf
    
    [geoCoder reverseGeocodeLocation:currentLoc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            NSString *city = placeMark.locality;
            NSLog(@"国家：%@",placeMark.country);
            [SVProgressHUD showInfoWithStatus: placeMark.country];
        }else{
            [SVProgressHUD showInfoWithStatus:error.description];
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [SVProgressHUD showInfoWithStatus:@"定位失败"];
}


@end
