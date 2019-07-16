//
//  XSBaseModel.h
//  iOSProject
//
//  Created by 小四 on 2019/5/24.
//  Copyright © 2019 小四. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSBaseModel : NSObject

@property(nonatomic,copy)NSString *status;
@property(nonatomic,assign)BOOL success;
@property(nonatomic,strong)id data;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,strong)id object;

@end

NS_ASSUME_NONNULL_END
