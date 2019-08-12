//
//  XSCellEditVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/8/12.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSCellEditVC.h"
#import "XSMainCell.h"

@interface XSCellEditVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataList;

@end

@implementation XSCellEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"edit";
    self.dataList = @[
                      @{@"title":@"title01",@"isCanEdit":[NSNumber numberWithBool:YES]},
                      @{@"title":@"title02",@"isCanEdit":[NSNumber numberWithBool:NO]},
                      @{@"title":@"title03",@"isCanEdit":[NSNumber numberWithBool:NO]},
                      @{@"title":@"title04",@"isCanEdit":[NSNumber numberWithBool:YES]},
                      @{@"title":@"title05",@"isCanEdit":[NSNumber numberWithBool:YES]},
                      @{@"title":@"title06",@"isCanEdit":[NSNumber numberWithBool:YES]},
                      ];
    [self.view addSubview:self.tableView];

}

#pragma mark -- tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-navgationHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[XSMainCell class] forCellReuseIdentifier:XSMainCellID];
    }
    return _tableView;
}

#pragma mark -- tableview deledate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataList[indexPath.row];
    return [self setCellTitle:dic[@"title"] indexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataList[indexPath.row];
    BOOL isEdit = [[dic objectForKey:@"isCanEdit"] boolValue];
    return isEdit;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *edit01 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"edit01" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [SVProgressHUD showInfoWithStatus:@"edit01"];
    }];
    edit01.backgroundColor = [XSTool colorWithHexString:@"419DE7"];
    UITableViewRowAction *edit02 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"edit02" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [SVProgressHUD showInfoWithStatus:@"edit02"];
    }];
    edit02.backgroundColor = [XSTool colorWithHexString:@"E3F1FC"];
    return @[edit02,edit01];
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view setNeedsLayout];
}

- (void)viewWillLayoutSubviews{
    // 修改左滑cell的文字颜色
    for (UIView *subview in self.tableView.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]) {
            [self configPullView:subview];
        }
    }
}

- (void)configPullView:(UIView *)pullView{
    for (UIView *subview in pullView.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionStandardButton")] && [subview isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subview;
            if ([btn.titleLabel.text isEqualToString:@"edit02"]) {
                btn.titleLabel.textColor = [XSTool colorWithHexString:@"#419DE7"];
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

#pragma mark -- set cell
- (XSMainCell *)setCellTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath{
    XSMainCell *cell = [self.tableView dequeueReusableCellWithIdentifier:XSMainCellID forIndexPath:indexPath];
    cell.title = title;
    return cell;
}

@end
