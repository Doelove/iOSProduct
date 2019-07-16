//
//  XSRequestManager.h
//  iOSProject
//
//  Created by 小四 on 2019/5/10.
//  Copyright © 2019 小四. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface XSRequestManager : NSObject


+ (void)get:(NSString *)url params:(nonnull NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(XSBaseModel *response))success failure:(void (^)(NSError *error))failure;

+ (void)postLoginUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(XSBaseModel *response))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params filename:(NSData *)file success:(void (^)(XSBaseModel * response))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
