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
#import "XSMainCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOS Project";
    [self.view addSubview:self.tableView];
    self.dataList = @[@"表头放大",@"图片放大",@"圆角加阴影",@"动画回弹",@"腾讯云播放器"];

}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-navgationHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = self.tableViewColor;
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
    }else{
        XSViderPlayerVC *vc = [[XSViderPlayerVC alloc]init];
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
