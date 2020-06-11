//
//  ViewController.m
//  iOSProject
//
//  Created by 小四 on 2019/6/11.
//  Copyright © 2019 小四. All rights reserved.
//

#import "ViewController.h"
#import "XSMainCell.h"
#import "XSSideMenuMainVC.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataList;
@property(nonatomic,strong)NSArray *nameList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOS Project";
    [self.view addSubview:self.tableView];
    self.dataList = @[@"表头放大",@"图片放大",@"圆角加阴影",@"动画回弹",@"腾讯云播放器",@"轮播",@"uiwindow",@"cell左滑编辑",@"日历",@"侧边栏",@"地理编码",@"原生分享",@"本地通知",@"runloop导致timer暂停",@"同页面请求多个接口",@"创建pdf",@"转场动画",@"自定义转场动画分析",@"指南针",@"原生定位",@"XSGPUImageTest01",@"XSGPUImageTest02棕色滤镜",@"骑行导航"];
    self.nameList = @[@"XSTableHeaderBigVC",@"XSImagePinchPan",@"XSCornerShadowVC",@"XSSpringVC",@"XSViderPlayerVC",@"XSSliderGalleryMainVC",@"",@"XSCellEditVC",@"XSCalendarVC",@"",@"XSAMapVC",@"XSShareVC",@"XSLocalNotiVC",@"XSRunLoopTimerVC",@"XSAsyncRequestVC",@"XSCreatePDFVC",@"XSAnimationFirstVC",@"XSCustomAnimationFirstVC",@"XSCompassVC",@"XSLocationVC",@"XSGPUImageTest01",@"XSGPUImageTest02",@"XSCyclingNavigationVC"];

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
    JYWeakSelf
    return [self setCellTitle:self.dataList[indexPath.row] indexPath:indexPath block:^{
        [weakSelf createVCOfName:weakSelf.nameList[indexPath.row] index:indexPath.row];
    }];
}


- (void)createVCOfName:(NSString *)vcName index:(NSInteger)index{
    if (index == 9) {
        XSSideMenuHomeVC *homeVC = [[XSSideMenuHomeVC alloc]init];
        XSSideMenuRightVC *rightVC = [[XSSideMenuRightVC alloc]init];
        XSSideMenuMainVC *vc = [XSSideMenuMainVC createMainVCWithHomeVC:homeVC rightVC:rightVC];
        [self pushVC:vc];
    }else{
        UIViewController *vc = [[NSClassFromString(vcName) alloc]init];
        [self pushVC:vc];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (XSMainCell *)setCellTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath block:(SelectBlock)block{
    XSMainCell *cell = [self.tableView dequeueReusableCellWithIdentifier:XSMainCellID forIndexPath:indexPath];
    cell.title = title;
    cell.block = block;
    return cell;
}

@end
