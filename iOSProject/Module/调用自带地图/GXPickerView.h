//
//  GXPickerView.h
//  GXCRM_iPhone
//
//  Created by 豆豆 on 2020/1/7.
//  Copyright © 2020 豆豆. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GXPickerView;
@protocol GXPickerViewDelegate <NSObject>

@optional
- (void)handleSelectCode:(NSString *)code value:(NSString *)value;
- (void)handleClearPickerData;

@end

@interface GXPickerView : UIView

@property(nonatomic,strong)NSArray *dataList;
@property(nonatomic,weak)id <GXPickerViewDelegate> delegate;

- (void)remakePicker;


@end

NS_ASSUME_NONNULL_END
