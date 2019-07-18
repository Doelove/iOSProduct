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



@end

@implementation XSSliderGalleryVC

- (instancetype)initWithFrame:(CGRect)frame size:(CGSize)size dataSource:(NSArray *)dataSource{
    self = [super initWithFrame:frame];
    if (self) {
//        CGSize size = size;
        self.scrollerViewWidth = size.width;
        self.scrollerViewHeight = size.height;
        
        self.dataSource = dataSource;
        self.currentPageTintColor = [UIColor orangeColor];
        [self addSubview:self.scrollerView];
        self.placeholderImage = [UIImage imageNamed:@""];
        [self configureImageView];
        [self configurePageController];
        [self configAutoScrollTimer];
    }
    return self;
}

- (void)setCurrentPageTintColor:(UIColor *)currentPageTintColor{
    _currentPageTintColor = currentPageTintColor;
}

- (UIScrollView *)scrollerView{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.scrollerViewWidth, self.scrollerViewHeight)];
        _scrollerView.delegate = self;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.contentSize = CGSizeMake(self.scrollerViewWidth * 3, 0);
        _scrollerView.contentOffset = CGPointMake(self.scrollerViewWidth, 0);
        _scrollerView.pagingEnabled = YES;
        _scrollerView.bounces = NO;
    }
    return _scrollerView;
}

- (void)configureImageView{
    self.leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScaleWidth(10), kScaleWidth(10), self.scrollerViewWidth-kScaleWidth(20), self.scrollerViewHeight-kScaleWidth(20))];
    self.middleImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollerViewWidth+kScaleWidth(10), kScaleWidth(10), self.scrollerViewWidth-kScaleWidth(20), self.scrollerViewHeight-kScaleWidth(20))];
    self.rightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollerViewWidth*2+kScaleWidth(10), kScaleWidth(10), self.scrollerViewWidth-kScaleWidth(20), self.scrollerViewHeight-kScaleWidth(20))];
    
    if (self.dataSource.count != 0) {
        [self resetImageViewSource];
    }
    [self.scrollerView addSubview:self.leftImgView];
    [self.scrollerView addSubview:self.middleImgView];
    [self.scrollerView addSubview:self.rightImgView];
    [self configImageLayer:self.leftImgView];
    [self configImageLayer:self.middleImgView];
    [self configImageLayer:self.rightImgView];
}

- (void)configImageLayer:(UIImageView *)imageV{
    imageV.layer.cornerRadius = kScaleWidth(5);
    imageV.layer.masksToBounds = YES;
    
    
    
    
}

- (void)configAutoScrollTimer{
    _autoScrollTime = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(handleScroll) userInfo:nil repeats:YES];
}

- (void)handleScroll{
    CGPoint offset = CGPointMake(2*self.scrollerViewWidth, 0);
    [self.scrollerView setContentOffset:offset animated:YES];
}

- (void)configurePageController{
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth/2-kScaleWidth(60), self.scrollerViewHeight-kScaleWidth(30), kScaleWidth(120), kScaleWidth(20))];
    self.pageControl.numberOfPages = self.dataSource.count;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.currentPageIndicatorTintColor = self.currentPageTintColor != nil ? self.currentPageTintColor : [UIColor blackColor];
    [self addSubview:self.pageControl];
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

// 手动拖拽开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 将计时器失效 防止手动拖动时 计时器也在自动滚动
    [self.autoScrollTime invalidate];
}

// 手动拖拽结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // 重启计时器
    [self configAutoScrollTimer];
}

- (void)resetImageViewSource{
    if (self.currentIndex == 0) {
        [self.leftImgView yy_setImageWithURL:self.dataSource.lastObject placeholder:self.placeholderImage];
        [self.middleImgView yy_setImageWithURL:self.dataSource.firstObject placeholder:self.placeholderImage];
        int rightImageIndex = self.dataSource.count > 1 ? 1 : 0;
        [self.rightImgView yy_setImageWithURL:self.dataSource[rightImageIndex] placeholder:self.placeholderImage];
    }else if (self.currentIndex == self.dataSource.count - 1){
        [self.leftImgView yy_setImageWithURL:self.dataSource[self.currentIndex-1] placeholder:self.placeholderImage];
        [self.middleImgView yy_setImageWithURL:self.dataSource.lastObject placeholder:self.placeholderImage];
        [self.rightImgView yy_setImageWithURL:self.dataSource.firstObject placeholder:self.placeholderImage];
    }else{
        [self.leftImgView yy_setImageWithURL:self.dataSource[self.currentIndex-1] placeholder:self.placeholderImage];
        [self.middleImgView yy_setImageWithURL:self.dataSource[self.currentIndex] placeholder:self.placeholderImage];
        [self.rightImgView yy_setImageWithURL:self.dataSource[self.currentIndex+1] placeholder:self.placeholderImage];
    }
}

@end
