//
//  XSUserInfo.m
//  iOSProject
//
//  Created by 小四 on 2019/5/24.
//  Copyright © 2019 小四. All rights reserved.
//

#import "XSUserInfo.h"

static NSString *const kUserId          = @"kUserId";
static NSString *const kUserName        = @"kUserName";
static NSString *const kCNName          = @"kCNName";
static NSString *const kOuId            = @"kOuId";
static NSString *const kOuName          = @"kOuName";
static NSString *const kMobile          = @"kMobile";
static NSString *const kEmail           = @"kEmail";
static NSString *const kDisabled        = @"kDisabled";
static NSString *const kToken           = @"kToken";
static NSString *const kStaffId         = @"kStaffId";
static NSString *const kStaffName       = @"kStaffName";
static NSString *const kTerritoryName   = @"kTerritoryName";
static NSString *const kTerritoryId     = @"kTerritoryId";
static NSString *const kRoles           = @"kRoles";
static NSString *const kOperators       = @"kOperators";
static NSString *const kLoginStatus     = @"kLoginStatus";


@implementation XSUserInfo

/*
 userid
 */
+ (void)setUserId:(NSString *)userId{
    [[NSUserDefaults standardUserDefaults] setValue:userId forKey:kUserId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getUserId{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kUserId];
}

/*
 username
 */
+ (void)setUserName:(NSString *)userName{
    [[NSUserDefaults standardUserDefaults] setValue:userName forKey:kUserName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getUserName{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kUserName];
}

/*
 CNName
 */
+ (void)setCNName:(NSString *)CNName{
    [[NSUserDefaults standardUserDefaults] setValue:CNName forKey:kCNName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getCNName{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kCNName];
}


/*
 OuId
 */
+ (void)setOuId:(NSString *)OuId{
    [[NSUserDefaults standardUserDefaults] setValue:OuId forKey:kOuId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getOuId{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kOuId];
}

/*
 ouName
 */
+ (void)setOuName:(NSString *)ouName{
    [[NSUserDefaults standardUserDefaults] setValue:ouName forKey:kOuName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getOuName{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kOuName];
}

//  -----------------------------------------------
/*
 Mobile
 */
+ (void)setMobile:(NSString *)mobile{
    [[NSUserDefaults standardUserDefaults] setValue:mobile forKey:kMobile];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getMobile{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kMobile];
}

/*
 Email
 */
+ (void)setEmail:(NSString *)email{
    [[NSUserDefaults standardUserDefaults] setValue:email forKey:kEmail];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getEmail{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kEmail];
}

/*
 Disabled
 */
+ (void)setDisabled:(BOOL)disabled{
    [[NSUserDefaults standardUserDefaults] setBool:disabled forKey:kDisabled];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getDisabled{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kDisabled];
}

/*
 accesstoken
 */
+ (void)setToken:(NSString *)token{
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:kToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getToken{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kToken];
}

/*
 staffID
 */
+ (void)setStaffID:(NSString *)staffID{
    [[NSUserDefaults standardUserDefaults] setValue:staffID forKey:kStaffId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getStaffID{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kStaffId];
}

/*
 staffName
 */
+ (void)setStaffName:(NSString *)staffName{
    [[NSUserDefaults standardUserDefaults] setValue:staffName forKey:kStaffName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getStaffName{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kStaffName];
}


/*
 territoryName
 */
+ (void)setTerritoryName:(NSString *)territoryName{
    [[NSUserDefaults standardUserDefaults] setValue:territoryName forKey:kTerritoryName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getTerritoryName{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kTerritoryName];
}

/*
 territoryId
 */
+ (void)setTerritoryId:(NSString *)territoryId{
    [[NSUserDefaults standardUserDefaults] setValue:territoryId forKey:kTerritoryId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getTerritoryId{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kTerritoryId];
}

/*
 roles
 */
+ (void)setRoles:(NSString *)roles{
    [[NSUserDefaults standardUserDefaults] setValue:roles forKey:kRoles];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getRoles{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kRoles];
}

/*
 operators
 */
+ (void)setOperators:(NSString *)operators{
    [[NSUserDefaults standardUserDefaults] setValue:operators forKey:kOperators];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getOperators{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kOperators];
}

/*
 loginStatus
 */
+ (void)setLoginStatus:(BOOL)loginStatus{
    [[NSUserDefaults standardUserDefaults] setBool:loginStatus forKey:kLoginStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getLoginStatus{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kLoginStatus];
}

/*clear*/
+ (void)clearUserData{
    [XSUserInfo setUserId:@""];
    [XSUserInfo setUserName:@""];
    [XSUserInfo setCNName:@""];
    [XSUserInfo setOuId:@""];
    [XSUserInfo setOuName:@""];
    [XSUserInfo setMobile:@""];
    [XSUserInfo setEmail:@""];
    [XSUserInfo setDisabled:NO];
    [XSUserInfo setToken:@""];
    [XSUserInfo setStaffID:@""];
    [XSUserInfo setStaffName:@""];
    [XSUserInfo setTerritoryName:@""];
    [XSUserInfo setTerritoryId:@""];
    [XSUserInfo setRoles:@""];
    [XSUserInfo setOperators:@""];
    [XSUserInfo setLoginStatus:NO];
}

@end
