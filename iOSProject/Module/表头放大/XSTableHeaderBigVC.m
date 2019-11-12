//
//  XSTableHeaderBigVC.m
//  iOSProject
//
//  Created by 软素 on 2019/6/11.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSTableHeaderBigVC.h"

@interface XSTableHeaderBigVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView *headImageView;

@end

@implementation XSTableHeaderBigVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackBtn];
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
    [self setLayoutHeaderView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-navgationHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [XSTool colorWithHexString:tableViewColor];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}

- (void)setLayoutHeaderView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScaleWidth(200))];
    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScaleWidth(200))];
    self.headImageView.image = [UIImage imageNamed:@"mineBanner"];
    [headView addSubview:self.headImageView];
    self.tableView.tableHeaderView = headView;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < 0) {
        CGFloat totalOffset = kScaleWidth(200) + ABS(offsetY);
//        比例放大
//        CGFloat f = totalOffset / 200;
//        self.headImageView.frame.size.height = totalOffset;
//        self.headImageView.frame =  CGRectMake(- (kScreenWidth * f - kScreenWidth) / 2, offsetY, kScreenWidth * f, totalOffset);
        // 高度
        self.headImageView.height = totalOffset;
        self.headImageView.y = offsetY;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ce"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ce"];
    }
    cell.textLabel.text = @"表头放大";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

@end
