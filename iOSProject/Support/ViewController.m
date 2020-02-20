//
//  ViewController.m
//  iOSProject
//
//  Created by 小四 on 2019/6/11.
//  Copyright © 2019 小四. All rights reserved.
//

#import "ViewController.h"
#import "XSTableHeaderBigVC.h"
#import "XSImagePinchPan.h"
#import "XSCornerShadowVC.h"
#import "XSSpringVC.h"
#import "XSViderPlayerVC.h"
#import "XSSliderGalleryMainVC.h"
#import "XSMainCell.h"
#import "XSCellEditVC.h"
#import "XSCalendarVC.h"
#import "XSSideMenuMainVC.h"
#import "XSAMapVC.h"
#import "XSShareVC.h"
#import "XSLocalNotiVC.h"
#import "XSRunLoopTimerVC.h"
#import "XSAsyncRequestVC.h"
#import "XSCreatePDFVC.h"
#import "XSAnimationFirstVC.h"
#import "XSCustomAnimationFirstVC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOS Project";
    [self.view addSubview:self.tableView];
    self.dataList = @[@"表头放大",@"图片放大",@"圆角加阴影",@"动画回弹",@"腾讯云播放器",@"轮播",@"uiwindow",@"cell左滑编辑",@"日历",@"侧边栏",@"地理编码",@"原生分享",@"本地通知",@"runloop导致timer暂停",@"同页面请求多个接口",@"创建pdf",@"转场动画",@"自定义转场动画分析"];

}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-navgationHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [XSTool colorWithHexString:tableViewColor];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_tableView registerClass:[XSMainCell class] forCellReuseIdentifier:XSMainCellID];
    }
    return _tableView;
}

#pragma mark -- tableView 代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self setCellTitle:self.dataList[indexPath.row] indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        XSTableHeaderBigVC *vc = [[XSTableHeaderBigVC alloc]init];
        [self pushVC:vc];
    }else if(indexPath.row == 1){
        XSImagePinchPan *vc = [[XSImagePinchPan alloc]init];
        [self pushVC:vc];
    }else if(indexPath.row == 2){
        XSCornerShadowVC *vc = [[XSCornerShadowVC alloc]init];
        [self pushVC:vc];
    }else if(indexPath.row == 3){
        XSSpringVC *vc = [[XSSpringVC alloc]init];
        [self pushVC:vc];
    }else if(indexPath.row == 4){
        XSViderPlayerVC *vc = [[XSViderPlayerVC alloc]init];
        [self pushVC:vc];
    }else if(indexPath.row == 5){
        XSSliderGalleryMainVC *vc = [[XSSliderGalleryMainVC alloc]init];
        [self pushVC:vc];
    }else if (indexPath.row == 7){
        XSCellEditVC *vc = [[XSCellEditVC alloc]init];
        [self pushVC:vc];
    }else if (indexPath.row == 8){
        XSCalendarVC *vc = [[XSCalendarVC alloc]init];
        [self pushVC:vc];
    }else if (indexPath.row == 9){
        XSSideMenuHomeVC *homeVC = [[XSSideMenuHomeVC alloc]init];
        XSSideMenuRightVC *rightVC = [[XSSideMenuRightVC alloc]init];
        XSSideMenuMainVC *vc = [XSSideMenuMainVC createMainVCWithHomeVC:homeVC rightVC:rightVC];
        [self pushVC:vc];
    }else if (indexPath.row == 10){
        XSAMapVC *vc = [[XSAMapVC alloc]init];
        [self pushVC:vc];
    }else if (indexPath.row == 11){
        XSShareVC *vc = [[XSShareVC alloc]init];
        [self pushVC:vc];
    }else if (indexPath.row == 12){
        XSLocalNotiVC *vc = [[XSLocalNotiVC alloc]init];
        [self pushVC:vc];
    }else if (indexPath.row == 13){
        XSRunLoopTimerVC *vc = [[XSRunLoopTimerVC alloc]init];
        [self pushVC:vc];
    }else if (indexPath.row == 14){
        XSAsyncRequestVC *vc = [[XSAsyncRequestVC alloc]init];
        [self pushVC:vc];
    }else if (indexPath.row == 15){
        XSCreatePDFVC *vc = [[XSCreatePDFVC alloc]init];
        [self pushVC:vc];
    }else if (indexPath.row == 16){
        XSAnimationFirstVC *vc = [[XSAnimationFirstVC alloc]init];
        [self pushVC:vc];
    }else if (indexPath.row == 17){
        
        XSCustomAnimationFirstVC *vc = [[XSCustomAnimationFirstVC alloc]init];
        [self pushVC:vc];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (XSMainCell *)setCellTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath{
    XSMainCell *cell = [self.tableView dequeueReusableCellWithIdentifier:XSMainCellID forIndexPath:indexPath];
    cell.title = title;
    return cell;
}

@end
