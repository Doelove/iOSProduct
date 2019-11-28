//
//  XSRunLoopTimerVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/11/28.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSRunLoopTimerVC.h"
#import "XSTimerCell.h"

@interface XSRunLoopTimerVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation XSRunLoopTimerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];

}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[XSTimerCell class] forCellReuseIdentifier:XSTimerCellID];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        return [self setTimeCellWithIndexPath:indexPath];
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        return kScaleWidth(100);
    }
    return 44;
}


- (XSTimerCell *)setTimeCellWithIndexPath:(NSIndexPath *)indexPath{
    XSTimerCell *cell = [self.tableView dequeueReusableCellWithIdentifier:XSTimerCellID forIndexPath:indexPath];
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
