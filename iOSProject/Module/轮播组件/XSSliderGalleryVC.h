//
//  XSSliderGalleryVC.h
//  iOSProject
//
//  Created by 软素 on 2019/6/18.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SliderGalleryDelegate <NSObject>

@optional
- (NSArray *)galleryDataSource;
- (CGSize)galleryScrollerViewSize;

@end

@interface XSSliderGalleryVC : UIView

//@property(nonatomic,weak)id<SliderGalleryDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame size:(CGSize)size dataSource:(NSArray *)dataSource;
@property(nonatomic,strong)UIColor *currentPageTintColor;

@end

NS_ASSUME_NONNULL_END
