//
//  UserInfoModel.m
//  BizPay-iOS
//
//  Created by xby023 on 2018/9/26.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"itemID":@"id"
             };
}

@end
