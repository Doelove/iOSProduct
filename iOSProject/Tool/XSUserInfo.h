//
//  XSUserInfo.h
//  iOSProject
//
//  Created by 小四 on 2019/5/24.
//  Copyright © 2019 小四. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSUserInfo : NSObject

// userId
+ (void)setUserId:(NSString *)userId;
+ (NSString *)getUserId;

/*
 username
 */
+ (void)setUserName:(NSString *)userName;
+ (NSString *)getUserName;


/*
 CNName
 */
+ (void)setCNName:(NSString *)CNName;
+ (NSString *)getCNName;


/*
 OuId
 */
+ (void)setOuId:(NSString *)OuId;
+ (NSString *)getOuId;

/*
 ouName
 */
+ (void)setOuName:(NSString *)ouName;
+ (NSString *)getOuName;

/*
 Mobile
 */
+ (void)setMobile:(NSString *)mobile;
+ (NSString *)getMobile;
/*
 Email
 */
+ (void)setEmail:(NSString *)email;
+ (NSString *)getEmail;
/*
 Disabled
 */
+ (void)setDisabled:(BOOL)disabled;
+ (BOOL)getDisabled;
/*
 accesstoken
 */
+ (void)setToken:(NSString *)token;
+ (NSString *)getToken;
/*
 staffID
 */
+ (void)setStaffID:(NSString *)staffID;
+ (NSString *)getStaffID;
/*
 staffName
 */
+ (void)setStaffName:(NSString *)staffName;
+ (NSString *)getStaffName;
/*
 territoryName
 */
+ (void)setTerritoryName:(NSString *)territoryName;
+ (NSString *)getTerritoryName;

/*
 territoryId
 */
+ (void)setTerritoryId:(NSString *)territoryId;
+ (NSString *)getTerritoryId;
/*
 roles
 */
+ (void)setRoles:(NSString *)roles;
+ (NSString *)getRoles;

/*
 operators
 */
+ (void)setOperators:(NSString *)operators;
+ (NSString *)getOperators;
/*
 loginStatus
 */
+ (void)setLoginStatus:(BOOL)loginStatus;
+ (BOOL)getLoginStatus;



/*clear*/
+ (void)clearUserData;

@end

NS_ASSUME_NONNULL_END
