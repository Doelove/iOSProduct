//
//  XSAnimationFirstVC.m
//  iOSProject
//
//  Created by 豆豆 on 2019/12/23.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSAnimationFirstVC.h"
#import "XSAnimationSecondVC.h"
#import "UINavigationController+CATransition.h"


@interface XSAnimationFirstVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataList;

@end

@implementation XSAnimationFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataList = @[@"淡化",@"覆盖",@"push",@"揭开",@"3D立方",@"吮吸",@"翻转",@"波纹",@"翻页",@"反翻页",@"开镜头",@"关镜头"];
    [self.view addSubview:self.tableView];
    

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
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XSCATransitionType type;
//    XSCATransitionSubType *subType;
    switch (indexPath.row) {
        case 0:
            type = XSCATransitionTypeFade;
            break;
        case 1:
            type = XSCATransitionTypeMoveIn;
            break;
        case 2:
            type = XSCATransitionTypePush;
            break;
        case 3:
            type = XSCATransitionTypeReveal;
            break;
        case 4:
            type = XSCATransitionTypeCube;
            break;
        case 5:
            type = XSCATransitionTypeSuckEffect;
            break;
        case 6:
            type = XSCATransitionTypeOglFlip;
            break;
        case 7:
            type = XSCATransitionTypeRippleEffect;
            break;
        case 8:
            type = XSCATransitionTypePageCurl;
            break;
        case 9:
            type = XSCATransitionTypePageUnCurl;
            break;
        case 10:
            type = XSCATransitionTypeCameraIrisHollowOpen;
            break;
        case 11:
            type = XSCATransitionTypeCameraIrisHollowClose;
            break;
        default:
            type = XSCATransitionTypePush;
            break;
    }
    
    XSAnimationSecondVC *vc = [[XSAnimationSecondVC alloc]init];
    [self.navigationController pushViewController:vc withCATransitionType:type subType:XSCATransitionSubTypeFromRight animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}



@end
