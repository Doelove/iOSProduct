//
//  XSSideMenuRightVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/8/26.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSSideMenuRightVC.h"
#import "XSMainCell.h"

@interface XSSideMenuRightVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataList;

@end

@implementation XSSideMenuRightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataList = @[@"腾讯云播放器",@"轮播",@"uiwindow",@"cell左滑编辑",@"日历",@"侧边栏"];
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor whiteColor];

}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-navgationHeight) style:UITableViewStylePlain];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kScaleWidth(50))];
    headerView.backgroundColor = [UIColor orangeColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kScaleWidth(50);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (XSMainCell *)setCellTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath{
    XSMainCell *cell = [self.tableView dequeueReusableCellWithIdentifier:XSMainCellID forIndexPath:indexPath];
    cell.title = title;
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
