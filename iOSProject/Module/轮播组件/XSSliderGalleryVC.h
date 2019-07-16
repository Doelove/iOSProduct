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

@interface XSSliderGalleryVC : XSBaseVC

@property(nonatomic,weak)id<SliderGalleryDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
