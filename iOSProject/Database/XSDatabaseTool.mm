//
//  XSDatabaseTool.m
//  iOSProject
//
//  Created by 小四 on 2019/5/13.
//  Copyright © 2019 小四. All rights reserved.
//

#import "XSDatabaseTool.h"
#import <WCDB/WCDB.h>

static XSDatabaseTool *_tools = nil;


@implementation XSDatabaseTool

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tools = [[super allocWithZone:NULL]init];
    });
    return _tools;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self shared];
}

-(id)copyWithZone:(NSZone *)zone{
    return _tools;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    return _tools;
}

// 数据库路径
+ (NSString *)createFilePath{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath firstObject];
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"jydata.db"];
    NSLog(@"%@",dbFilePath);
    return dbFilePath;
}



@end
