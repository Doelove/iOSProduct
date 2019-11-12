//
//  XSSideMenuHomeVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/8/26.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSSideMenuHomeVC.h"
#import "XSMainCell.h"

@interface XSSideMenuHomeVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView *navView;
@property(nonatomic,strong)UIButton *rightBarBtn;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataList;

@end

@implementation XSSideMenuHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createNavBar];
     self.dataList = @[@"表头放大",@"图片放大",@"圆角加阴影",@"动画回弹",@"腾讯云播放器",@"轮播",@"uiwindow",@"cell左滑编辑",@"日历",@"侧边栏"];
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)setIsRightSelected:(BOOL)isRightSelected{
    self.rightBarBtn.selected = isRightSelected;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), kScreenWidth, kScreenHeight-CGRectGetHeight(self.navView.frame)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = kScaleWidth(44);
        _tableView.backgroundColor = [XSTool colorWithHexString:tableViewColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[XSMainCell class] forCellReuseIdentifier:XSMainCellID];
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self setCellTitle:self.dataList[indexPath.row] indexPath:indexPath];
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


#pragma mark -- leftBar
- (void)createNavBar{
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, navgationHeight)];
    self.navView.backgroundColor = [XSTool colorWithHexString:@"1397E8"];
    [self.view addSubview:self.navView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, statusBarHeight, kScaleWidth(100), 44)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"主页";
    titleLabel.centerX = self.navView.centerX;
    [self.navView addSubview:titleLabel];
    UIButton *leftBtn = [self createNavBtnWithImg:@"back" tag:10010 frame:CGRectMake(kScaleWidth(10), statusBarHeight, kScaleWidth(44), 44)];
    [self.navView addSubview:leftBtn];
    self.rightBarBtn = [self createNavBtnWithImg:@"CRM_TargetIns_Structure" tag:10000 frame:CGRectMake(kScreenWidth-kScaleWidth(54), statusBarHeight, kScaleWidth(44), 44)];
    [self.navView addSubview:self.rightBarBtn];
}

- (UIButton *)createNavBtnWithImg:(NSString *)img tag:(NSInteger)tag frame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
    btn.frame = frame;
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(handleNavAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)handleNavAction:(UIButton *)sender{
    if (sender.tag == 10010) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        sender.selected = !sender.selected;
        if (self.block) {
            self.block(sender.selected);
        }
    }
}

@end
