//
//  XSImagePinchPan.m
//  iOSProject
//
//  Created by 豆豆 on 2019/6/27.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSImagePinchPan.h"
#import "XSImageSubView.h"

@interface XSImagePinchPan ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UIScrollView *bigScrollView;
@property(nonatomic,strong)NSArray *dataList;
@property(nonatomic,assign)CGFloat pichChangeValue;

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *imageList;


@end

@implementation XSImagePinchPan

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setBackBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataList = @[@"1.jpeg",@"2.jpeg"];
    self.imageList = [NSMutableArray array];
    for (NSInteger i = 0; i < self.dataList.count; i++) {
        XSImageSubView *imageItem = [[XSImageSubView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight) withUrl:self.dataList[i]];
        [self.imageList addObject:imageItem];
        [self.bigScrollView addSubview:imageItem];
    }
    
    
    [self.view addSubview:self.bigScrollView];
    [self.bigScrollView setContentSize:CGSizeMake(kScreenWidth*self.dataList.count, 0)];
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGFloat targetX = targetContentOffset->x;
    NSInteger num = targetX/kScreenWidth;
        XSImageSubView *imageItem = self.imageList[num];
        [imageItem.subScrollView setZoomScale:1 animated:NO];
}














// -----------------------------------------------------

- (void)handleFirst{
    [self.view addSubview:self.bigScrollView];
    self.bigScrollView.contentSize = CGSizeMake(kScreenWidth*2, kScreenHeight);
    for (int i = 0; i<self.dataList.count; i++) {
        UIScrollView *smallScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
        smallScrollView.tag = 10010+i;
        smallScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:smallScrollView.bounds];
        imgV.userInteractionEnabled = YES;
        imgV.image = [UIImage imageNamed:self.dataList[i]];
        [smallScrollView addSubview:imgV];
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction:)];
        [imgV addGestureRecognizer:pinch];
        [self.bigScrollView addSubview:smallScrollView];
    }
}

- (void)pinchAction:(UIPinchGestureRecognizer *)sender{
    UIImageView *imgV = (UIImageView *)sender.view;
    UIScrollView *currentScrollView = [self.bigScrollView viewWithTag:10010];
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.pichChangeValue = 1;
        return;
    }
    if (sender.state == UIGestureRecognizerStateEnded&&sender.scale<1) {
        [UIView animateWithDuration:0.5 animations:^{
            imgV.transform = CGAffineTransformMakeScale(1, 1);
        }];
        return;
    }
    CGFloat change = 1 - (self.pichChangeValue - sender.scale);
//    imgV.transform = CGAffineTransformScale(imgV.transform, change, change);
//    currentScrollView.contentSize = CGSizeMake(change*kScreenWidth, change*kScreenHeight);
//    currentScrollView.width = change*kScreenWidth;
//    currentScrollView.height = change*kScreenHeight;
    currentScrollView.transform = CGAffineTransformScale(currentScrollView.transform, change, change);
    currentScrollView.contentSize = CGSizeMake(change*kScreenWidth, change*kScreenHeight);
    self.bigScrollView.contentSize = CGSizeMake((change+2)*kScreenWidth, 0);
//    imgV.contentSize =CGSizeMake(change*kScreenWidth, change*kScreenHeight);
    self.pichChangeValue = sender.scale;
}

- (UIScrollView *)bigScrollView{
    if (!_bigScrollView) {
        _bigScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _bigScrollView.delegate = self;
        _bigScrollView.pagingEnabled = YES;
    }
    return _bigScrollView;
}


@end
