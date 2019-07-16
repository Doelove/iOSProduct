//
//  XSImageSubView.m
//  iOSProject
//
//  Created by 豆豆 on 2019/6/27.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSImageSubView.h"

@interface XSImageSubView ()<UIScrollViewDelegate>


@property(nonatomic,assign)NSInteger touchFingerNumber;


@end

@implementation XSImageSubView

- (instancetype)initWithFrame:(CGRect)frame withUrl:(NSString *)imageUrl
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:imageUrl];
    }
    return self;
}

- (void)initView:(NSString *)imageUrl{
    [self addSubview:self.subScrollView];
    [self.subScrollView addSubview:self.subImageView];
    
    
    //加入 点击事件 单击 与 双击
//    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
//    [self addGestureRecognizer:singleTap];
    UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
    doubleTap.numberOfTapsRequired = 2;
//    [singleTap requireGestureRecognizerToFail:doubleTap];
    [self addGestureRecognizer:doubleTap];
    
    self.subImageView.image = [UIImage imageNamed:imageUrl];
    [self updateSubScrollViewSubImageView];
    
}

- (void)updateSubScrollViewSubImageView{
    [self.subScrollView setZoomScale:1 animated:NO];

    
    CGFloat imageW = self.subImageView.image.size.width;
    CGFloat imageH = self.subImageView.image.size.height;
    CGFloat height = kScreenWidth * imageH/imageW;
    if (imageH/imageW > kScreenHeight/kScreenWidth) {
        self.subImageView.frame = CGRectMake(0, 0, kScreenWidth, height);
    }else{
        self.subImageView.frame = CGRectMake(0, kScreenHeight/2 - height/2, kScreenWidth, height);
    }

    self.subScrollView.contentSize = CGSizeMake(kScreenWidth, height);
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.subImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat offsetX = (scrollView.frame.size.width > scrollView.contentSize.width) ? (scrollView.frame.size.width - scrollView.contentSize.width) * 0.5:0.0;
    CGFloat offsetY = (scrollView.frame.size.height > scrollView.contentSize.height) ? (scrollView.frame.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.subImageView.center = CGPointMake(scrollView.contentSize.width*0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    UIPanGestureRecognizer *subScrollViewPan = [scrollView panGestureRecognizer];
    _touchFingerNumber = subScrollViewPan.numberOfTouches;
    _subScrollView.clipsToBounds = NO;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (contentOffsetY < 0 && _touchFingerNumber == 1) {
//        [self changeSizeCenterY:contentOffsetY];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if ((contentOffsetY<0 && _touchFingerNumber==1) && (velocity.y<0 && fabs(velocity.y)>fabs(velocity.x))) {
        
    }else{
        [self changeSizeCenterY:0.0];
        CGFloat offsetX = (scrollView.frame.size.width > scrollView.contentSize.width) ? (scrollView.frame.size.width - scrollView.contentSize.width)*0.5 : 0.0;
        CGFloat offsetY = (scrollView.frame.size.height > scrollView.contentSize.height) ? (scrollView.frame.size.height - scrollView.contentSize.height)*0.5 : 0.0;
        self.subImageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height*0.5+offsetY);
    }
    _touchFingerNumber = 0;
    self.subScrollView.clipsToBounds = YES;
}


- (void)changeSizeCenterY:(CGFloat)contentOffsetY{
    CGFloat multiple = (kScreenHeight + contentOffsetY*1.75)/kScreenHeight;
    multiple = multiple>0.4 ? multiple:0.4;
    self.subScrollView.transform = CGAffineTransformMakeScale(multiple, multiple);
    self.subScrollView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2-contentOffsetY*0.5);
}


//双击 局部放大 或者 变成正常大小
- (void)doubleTapAction:(UITapGestureRecognizer *)doubleTap {
    if (self.subScrollView.zoomScale > 1.0) {
        //已经放大过了 就变成正常大小
        [self.subScrollView setZoomScale:1.0 animated:YES];
    } else {
        //如果是正常大小 就 局部放大
        CGPoint touchPoint = [doubleTap locationInView:self.subImageView];
        CGFloat maxZoomScale = self.subScrollView.maximumZoomScale;
        CGFloat width = self.frame.size.width / maxZoomScale;
        CGFloat height = self.frame.size.height / maxZoomScale;
        [self.subScrollView zoomToRect:CGRectMake(touchPoint.x - width/2, touchPoint.y = height/2, width, height) animated:YES];
    }
}

#pragma mark -lazy
- (UIScrollView *)subScrollView {
    if (_subScrollView == nil) {
        _subScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _subScrollView.delegate = self;
        _subScrollView.bouncesZoom = YES;
        _subScrollView.maximumZoomScale = 2.5;//最大放大倍数
        _subScrollView.minimumZoomScale = 1.0;//最小缩小倍数
        _subScrollView.multipleTouchEnabled = YES;
        _subScrollView.scrollsToTop = NO;
        _subScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
        _subScrollView.userInteractionEnabled = YES;
        _subScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _subScrollView.delaysContentTouches = NO;//默认yes  设置NO则无论手指移动的多么快，始终都会将触摸事件传递给内部控件；
        _subScrollView.canCancelContentTouches = NO; // 默认是yes
        _subScrollView.alwaysBounceVertical = YES;//设置上下回弹
        _subScrollView.showsVerticalScrollIndicator = NO;
        _subScrollView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            //表示只在ios11以上的版本执行
            _subScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _subScrollView;
}

- (UIImageView *)subImageView {
    if (_subImageView == nil) {
        _subImageView = [[UIImageView alloc] init];
        _subImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _subImageView;
}

@end
