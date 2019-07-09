//
//  CountDownMaster.h
//  BizPay-iOS
//
//  Created by xby023 on 2018/9/26.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountDownMaster : NSObject

- (void)startCountDown;

- (void)stopCountDown;

@property (nonatomic,copy) void(^countDownBlock)(NSInteger count);

@end
