//
//  XSCustomAnimationSecondVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/12/24.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSCustomAnimationSecondVC.h"
#import "XSCircleTransition.h"

@interface XSCustomAnimationSecondVC ()<UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation XSCustomAnimationSecondVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.secondBtn];
    [self.secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(kScaleWidth(50));
        make.right.mas_equalTo(-kScaleWidth(20));
        make.top.mas_equalTo(kScaleWidth(20));
    }];
    self.secondBtn.layer.masksToBounds = YES;
    self.secondBtn.layer.cornerRadius = kScaleWidth(25);
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
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"架啊还是独立空间发了开始";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        
        // 自定义动画
        XSCircleTransition *tr = [[XSCircleTransition alloc]init];
        tr.isPush = NO;
        return tr;
        
    }
    return nil;
}

- (UIButton *)secondBtn{
    if (!_secondBtn) {
        _secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _secondBtn.backgroundColor = [UIColor blackColor];
        [_secondBtn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secondBtn;
}

- (void)handleSelectAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
