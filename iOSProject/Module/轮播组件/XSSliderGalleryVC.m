//
//  XSSliderGalleryVC.m
//  iOSProject
//
//  Created by 软素 on 2019/6/18.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSSliderGalleryVC.h"




@interface XSSliderGalleryVC ()<UIScrollViewDelegate>

@property(nonatomic,assign)int currentIndex;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)UIImageView *leftImgView;
@property(nonatomic,strong)UIImageView *middleImgView;
@property(nonatomic,strong)UIImageView *rightImgView;
@property(nonatomic,strong)UIScrollView *scrollerView;
@property(nonatomic,assign)CGFloat scrollerViewWidth;
@property(nonatomic,assign)CGFloat scrollerViewHeight;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)NSTimer *autoScrollTime;
@property(nonatomic,strong)UIImage *placeholderImage;
@property(nonatomic,strong)UIColor *currentPageTintColor;


@end

@implementation XSSliderGalleryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize size = self.delegate.galleryScrollerViewSize;
    self.scrollerViewWidth = size.width;
    self.scrollerViewHeight = size.height;
    
    self.dataSource = self.delegate.galleryDataSource;
    
    [self.view addSubview:self.scrollerView];
    self.placeholderImage = [UIImage imageNamed:@""];
    [self configureImageView];
    [self configurePageController];
    [self configAutoScrollTimer];
    
}


- (UIScrollView *)scrollerView{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.scrollerViewWidth, self.scrollerViewHeight)];
        _scrollerView.delegate = self;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.contentSize = CGSizeMake(self.scrollerViewWidth * 3, self.scrollerViewHeight);
        _scrollerView.contentOffset = CGPointMake(self.scrollerViewWidth, 0);
        _scrollerView.pagingEnabled = YES;
        _scrollerView.bounces = NO;
    }
    return _scrollerView;
}

- (void)configureImageView{
    self.leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.scrollerViewWidth, self.scrollerViewHeight)];
    self.middleImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollerViewWidth, 0, self.scrollerViewWidth, self.scrollerViewHeight)];
    self.rightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollerViewWidth*2, 0, self.scrollerViewWidth, self.scrollerViewHeight)];
    
    if (self.dataSource.count != 0) {
        
    }
    [self.scrollerView addSubview:self.leftImgView];
    [self.scrollerView addSubview:self.middleImgView];
    [self.scrollerView addSubview:self.rightImgView];
}

- (void)configAutoScrollTimer{
    _autoScrollTime = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(handleScroll) userInfo:nil repeats:YES];
}

- (void)handleScroll{
    CGPoint offset = CGPointMake(2*self.scrollerViewWidth, 0);
    [self.scrollerView setContentOffset:offset animated:YES];
}

- (void)configurePageController{
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth/2-60, self.scrollerViewHeight-20, 120, 20)];
    self.pageControl.numberOfPages = self.dataSource.count;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.currentPageIndicatorTintColor = self.currentPageTintColor != nil ? self.currentPageTintColor : [UIColor blackColor];
    [self.view addSubview:self.pageControl];
}

#pragma mark -- scroll 代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    if (self.dataSource.count != 0) {
        if (offsetX >= self.scrollerViewWidth * 2) {
            scrollView.contentOffset = CGPointMake(self.scrollerViewWidth, 0);
            self.currentIndex = self.currentIndex + 1;
            if (self.currentIndex == self.dataSource.count) {
                self.currentIndex = 0;
            }
        }
        if (offsetX <= 0) {
            scrollView.contentOffset = CGPointMake(self.scrollerViewWidth, 0);
            self.currentIndex = self.currentIndex - 1;
            if (self.currentIndex == -1) {
                self.currentIndex = (int)self.dataSource.count - 1;
            }
        }
        
        [self resetImageViewSource];
        self.pageControl.currentPage = self.currentIndex;
        
    }
}

- (void)resetImageViewSource{
    if (self.currentIndex == 0) {
//        self.leftImgView.imagefr
    }
}

@end
