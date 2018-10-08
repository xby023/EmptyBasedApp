//
//  UserInfoModel.h
//  BizPay-iOS
//
//  Created by xby023 on 2018/9/26.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic ,copy) NSString *itemID;

@property (nonatomic ,copy) NSString *nickname;

@property (nonatomic ,copy) NSString *avatar;

@property (nonatomic ,copy) NSString *country_code;

@property (nonatomic ,copy) NSString *tel;

@property (nonatomic ,copy) NSString *email;

@property (nonatomic ,copy) NSString *last_login_time;

@property (nonatomic ,copy) NSString *status;

//创建时间
@property (nonatomic ,copy) NSString *created_at;

@property (nonatomic ,copy) NSString *updated_at;

//是否设置登录密码：1是；0否
@property (nonatomic ,copy) NSString *set_password;

//是否设置支付密码：1是；0否
@property (nonatomic ,copy) NSString *set_paycode;

@end
