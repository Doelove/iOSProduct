//
//  JYPendApprovalManagerView.h
//  JYCRM_iPhone
//
//  Created by 软素 on 2019/7/3.
//  Copyright © 2019 软素. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYPendApprovalManagerView;
@protocol JYPendApprovalManagerViewDelegate <NSObject>

@optional
- (void)managerView:(JYPendApprovalManagerView *)managerView isPass:(BOOL)isPass; 


@end

@interface JYPendApprovalManagerView : UIView

@property(nonatomic,weak)id <JYPendApprovalManagerViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
