//
//  BizPayManager.m
//  BizPay-iOS
//
//  Created by 许必杨 on 2018/7/27.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import "BizPayManager.h"
#import "RootTabBarViewViewController.h"
#import "MainPageViewController.h"
static BizPayManager *manager = nil;

@implementation BizPayManager

+ (BizPayManager *)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BizPayManager alloc]init];
    });
    return manager;
}

//配置
- (void)configuration{
    //配置弹窗
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:14]];
    
    //防止偏移
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    [UITextView appearance].textContainerInset = UIEdgeInsetsMake(0, 0, 14, 0);
    //显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    
}

/**
 初始化界面
 
 @param window 判断加载登录界面还是主界面
 */
- (void)makeRootViewControllerWithWindow:(UIWindow *)window{
    /*继承UINavigationController 添加控制器 title不显示， 应该设置为Root控制器*/
    
    //获取登录状态
    self.login = [[NSUserDefaults standardUserDefaults] boolForKey:LoginIndentifer];
    
    //判断是否获取基础数据
    if (self.login) {
        self.token = [[NSUserDefaults standardUserDefaults] objectForKey:TokenIndentifer];
        self.push = [[NSUserDefaults standardUserDefaults] objectForKey:PushIndentifer];
        self.deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:DeviceTokenIndentifer];
        
        if (self.deviceToken && self.push) {
            if (self.deviceToken.length > 0 && self.push.length > 0) {
            }
        }
        [self reloadUserInfo:nil];
    }
    
    //加载根部控制器
    RootTabBarViewViewController *mainNAV = [[RootTabBarViewViewController alloc]init];
    window.rootViewController = mainNAV;
    [window makeKeyAndVisible];
    //配置文件
    [self configuration];
}


/**
 登出
 */
- (void)loginOut{
    self.login = NO;
    self.token = nil;
    self.push = nil;
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:PushIndentifer];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:TokenIndentifer];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:LoginIndentifer];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 登录
 */
- (void)loginWithToken:(NSString *)token Push:(NSString *)push{
    
    if (token.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"缺少token"];
        return;
    }
    
    self.login = YES;
    self.token = token;
    self.push = push;
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:TokenIndentifer];
    [[NSUserDefaults standardUserDefaults] setObject:push forKey:PushIndentifer];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:LoginIndentifer];

    [self reloadUserInfo:nil];
}

- (UserInfoModel *)userInfo{
    if (!_userInfo) {
        _userInfo = [[UserInfoModel alloc]init];
        _userInfo.itemID = @"";
        _userInfo.nickname = @"";
        _userInfo.avatar = @"";
        _userInfo.country_code = @"";
        _userInfo.tel = @"";
        _userInfo.email = @"";
        _userInfo.last_login_time = @"";
        _userInfo.status = @"";
        _userInfo.created_at = @"";
        _userInfo.updated_at = @"";
        _userInfo.itemID = @"0";
        _userInfo.itemID = @"0";
    }
    return _userInfo;
}


#pragma mark ==================================== 获取数据 ===================================

/**
 刷新个人数据
 
 @param success 返回刷新状态
 */
- (void)reloadUserInfo:(void(^)(BOOL isSuccess))success{
    [WebTools webTools_GetRequest:UserPort Params:@{} Success:^(id responseData) {
        NSInteger code = [responseData[@"code"] integerValue];
        if (code == 200) {
//            self.userInfo = [UserInfoModel mj_objectWithKeyValues:responseData[@"data"]];
            if (success) {
                success(YES);
            }
        }else{
            if (success) {
                success(NO);
            }
        }
    } Failure:^(NSError *error) {
        if (success) {
            success(NO);
        }
    }];
}


@end
