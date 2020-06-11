//
//  XSMainCell.h
//  iOSProject
//
//  Created by 豆豆 on 2019/6/28.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSBaseTableCell.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const XSMainCellID = @"XSMainCell";

@interface XSMainCell : XSBaseTableCell

@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)SelectBlock block;

@end

NS_ASSUME_NONNULL_END
