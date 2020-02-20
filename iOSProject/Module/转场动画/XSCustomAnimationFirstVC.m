//
//  XSCustomAnimationFirstVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/12/24.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSCustomAnimationFirstVC.h"
#import "XSCustomAnimationSecondVC.h"
#import "XSCircleTransition.h"

/*
    自定义转场动画
    1.实现协议
    2.在协议中完成动画
 
 */



@interface XSCustomAnimationFirstVC ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation XSCustomAnimationFirstVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.firstBtn];
    [self.firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(kScaleWidth(50));
        make.right.mas_equalTo(-kScaleWidth(20));
        make.top.mas_equalTo(kScaleWidth(20));
    }];
    self.firstBtn.layer.masksToBounds = YES;
    self.firstBtn.layer.cornerRadius = kScaleWidth(25);
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
    cell.textLabel.text = @"；阿拉斯加分；啊；啊的福利卡上的法律框架啊还是独立空间发了开始";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


/*
    导航栏代理
    navigationController：导航栏
    operation:判断是push/pop
 
    返回：UIViewControllerAnimatedTransitioning 转场动画返回
 
 **/
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        
        //初始化自定义动画类
        XSCircleTransition *tr = [[XSCircleTransition alloc]init];
        tr.isPush = YES;
        return tr;
        
    }else{
        return nil;
    }
    return nil;
}


- (UIButton *)firstBtn{
    if (!_firstBtn) {
        _firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _firstBtn.backgroundColor = [UIColor redColor];
        [_firstBtn addTarget:self action:@selector(handleSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _firstBtn;
}

- (void)handleSelectAction:(UIButton *)sender{
    
    XSCustomAnimationSecondVC *vc = [[XSCustomAnimationSecondVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}














@end
