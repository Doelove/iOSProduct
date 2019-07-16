//
//  XSBaseTableCell.m
//  iOSProject
//
//  Created by 小四 on 2019/5/16.
//  Copyright © 2019 小四. All rights reserved.
//

#import "XSBaseTableCell.h"

@implementation XSBaseTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createView];
    }
    return self;
}

- (void)createView{
    
}

@end
