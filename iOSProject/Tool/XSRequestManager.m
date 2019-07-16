//
//  XSRequestManager.m
//  iOSProject
//
//  Created by 小四 on 2019/5/10.
//  Copyright © 2019 小四. All rights reserved.
//

#import "XSRequestManager.h"

static XSRequestManager *_manager = nil;

@implementation XSRequestManager

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[super allocWithZone:NULL]init];
    });
    return _manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self shared];
}

- (id)copyWithZone:(NSZone *)zone{
    return _manager;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return _manager;
}

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/xml", nil];
    [manager.requestSerializer setTimeoutInterval:20];
    
    if(IOS_VERSION >=9.0){
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "] invertedSet]];
    }else{
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            XSBaseModel *model = [XSBaseModel yy_modelWithJSON:responseObject];
            if (!model.success) {
                [SVProgressHUD showInfoWithStatus:model.message];
            }
            success(model);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSLog(@"error - %@",error);
            failure(error);
        }
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(XSBaseModel *response))success failure:(void (^)(NSError *error))failure{

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/xml", nil];
    [manager.requestSerializer setTimeoutInterval:20];
    
    if(IOS_VERSION >=9.0){
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "] invertedSet]];
    }else{
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            XSBaseModel *model = [XSBaseModel yy_modelWithJSON:responseObject];
            if (!model.success) {
                [SVProgressHUD showInfoWithStatus:model.message];
            }
            success(model);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSLog(@"error - %@",error);
            failure(error);
        }
    }];
}

+ (void)postLoginUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(XSBaseModel *response))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/xml", nil];
    [manager.requestSerializer setTimeoutInterval:20];
    
    if(IOS_VERSION >=9.0){
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "] invertedSet]];
    }else{
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            XSBaseModel *model = [XSBaseModel yy_modelWithJSON:responseObject];
            if (!model.success) {
                [SVProgressHUD showInfoWithStatus:model.message];
            }
            success(model);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSLog(@"error - %@",error);
            failure(error);
        }
    }];
}

//上传文件
+ (void)post:(NSString *)url params:(NSDictionary *)params filename:(NSData *)file success:(void (^)(XSBaseModel * response))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/xml",@"image/png",@"image/jpeg", @"application/octet-stream", nil];
    [manager.requestSerializer setTimeoutInterval:20];
    
    if(IOS_VERSION >=9.0){
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "] invertedSet]];
    }else{
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        [formData appendPartWithFileData:file name:@"file" fileName:@"upload.png" mimeType:@"image/png"];//给定数据流的数据名，文件名，文件类型（以图片为例）
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            XSBaseModel *model = [XSBaseModel yy_modelWithJSON:responseObject];
            if (!model.success) {
                [SVProgressHUD showInfoWithStatus:model.message];
            }
            success(model);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end


