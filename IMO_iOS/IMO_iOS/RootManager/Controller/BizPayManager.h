//
//  BizPayManager.h
//  BizPay-iOS
//
//  Created by 许必杨 on 2018/7/27.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
@interface BizPayManager : NSObject

+ (BizPayManager *)shareManager;

- (void)makeRootViewControllerWithWindow:(UIWindow *)window;

- (void)loginOut;

- (void)loginWithToken:(NSString *)token Push:(NSString *)push;

/**
 刷新个人数据
 
 @param success 返回刷新状态
 */
- (void)reloadUserInfo:(void(^)(BOOL isSuccess))success;

/**
 登录状态
 */
@property (nonatomic ,assign, getter=isLogin) BOOL login;

@property (nonatomic ,copy) NSString *token;

@property (nonatomic ,copy) NSString *push;

//推送token
@property (nonatomic ,copy) NSString *deviceToken;

@property (nonatomic ,strong) UserInfoModel *userInfo;

@end
