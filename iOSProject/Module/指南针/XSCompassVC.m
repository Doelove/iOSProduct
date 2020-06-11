//
//  XSCompassVC.m
//  iOSProject
//
//  Created by 豆豆 on 2020/3/1.
//  Copyright © 2020 软素. All rights reserved.
//

#import "XSCompassVC.h"
#import <CoreLocation/CoreLocation.h>

@interface XSCompassVC ()<CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *mgr;

@property(nonatomic,strong)UIImageView *compassPointer;

@end

@implementation XSCompassVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"指南针"]];
    iv.center = self.view.center;
    [self.view addSubview:iv];
    self.compassPointer = iv;

    self.mgr.delegate = self;
    
    if ([CLLocationManager headingAvailable]) {
        //精度
        self.mgr.desiredAccuracy = kCLLocationAccuracyBest;
        self.mgr.distanceFilter = 0;
        self.mgr.headingFilter = kCLHeadingFilterNone;
        [self.mgr startUpdatingHeading];
        
    }
    
    [self.mgr requestWhenInUseAuthorization];


}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    
    
    self.compassPointer.transform = CGAffineTransformIdentity;
    
    CGFloat angle = newHeading.magneticHeading*M_PI/180;
    
    self.compassPointer.transform = CGAffineTransformMakeRotation(-angle);
    
}

- (CLLocationManager *)mgr{
    if (!_mgr) {
        _mgr = [[CLLocationManager alloc]init];
    }
    return _mgr;
}


@end
