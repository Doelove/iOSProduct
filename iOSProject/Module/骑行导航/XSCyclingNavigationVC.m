//
//  XSCyclingNavigationVC.m
//  iOSProject
//
//  Created by 豆豆 on 2020/6/11.
//  Copyright © 2020 软素. All rights reserved.
//

#import "XSCyclingNavigationVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>

@interface XSCyclingNavigationVC ()<MAMapViewDelegate,AMapNaviRideManagerDelegate,AMapNaviRideViewDelegate,AMapNaviDriveManagerDelegate>

@property(nonatomic, strong)MAMapView *mapView;
// 骑行导航管理类 提供计算规划路线，路线重算等
@property(nonatomic, strong)AMapNaviRideManager *rideManager;
// 导航界面
@property(nonatomic, strong)AMapNaviRideView *driveView;
@property(nonatomic, strong)AMapNaviPoint *startPoint;
@property(nonatomic, strong)AMapNaviPoint *endPoint;


@end

@implementation XSCyclingNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];


    [self.view addSubview:self.mapView];
    [self.view addSubview:self.driveView];
    [self initProperties];
    [self.rideManager calculateRideRouteWithStartPoint:self.startPoint endPoint:self.endPoint];
    
}

- (void)initProperties{
//    121.418828,31.240614
    self.startPoint = [AMapNaviPoint locationWithLatitude:31.240614 longitude:121.418828];
    //121.420974,31.235403
    self.endPoint = [AMapNaviPoint locationWithLatitude:31.235403 longitude:121.420974];
}

- (MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _mapView.delegate = self;
    }
    return _mapView;
}

// 骑行导航页面
- (AMapNaviRideView *)driveView{
    if (!_driveView) {
        _driveView = [[AMapNaviRideView alloc]initWithFrame:self.view.bounds];
        _driveView.delegate = self;
        _driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _driveView;
}

// 骑行导航管理类
- (AMapNaviRideManager *)rideManager{
    if (!_rideManager) {
        _rideManager = [[AMapNaviRideManager alloc]init];
        _rideManager.delegate = self;
    }
    return _rideManager;
}

// 骑行导航管理类 代理
- (void)rideManagerOnCalculateRouteSuccess:(AMapNaviRideManager *)rideManager{
    
    [self.rideManager addDataRepresentative:self.driveView];
    [self.rideManager startGPSNavi];
    
}

- (void)rideManagerOnArrivedDestination:(AMapNaviRideManager *)rideManager{
    [self.rideManager stopNavi];
}

- (void)dealloc
{
    [self.rideManager stopNavi];
    [self.rideManager removeDataRepresentative:self.driveView];
    [SVProgressHUD showInfoWithStatus:@"destory"];
}


@end
