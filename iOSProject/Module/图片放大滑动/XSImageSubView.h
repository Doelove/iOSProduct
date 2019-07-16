//
//  XSImageSubView.h
//  iOSProject
//
//  Created by 豆豆 on 2019/6/27.
//  Copyright © 2019 软素. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSImageSubView : UIView

- (instancetype)initWithFrame:(CGRect)frame withUrl:(NSString *)imageUrl;
@property(nonatomic,strong)UIScrollView *subScrollView;
@property(nonatomic,strong)UIImageView *subImageView;

@end

NS_ASSUME_NONNULL_END
