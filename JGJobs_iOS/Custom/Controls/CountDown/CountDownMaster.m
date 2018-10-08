//
//  CountDownMaster.m
//  BizPay-iOS
//
//  Created by xby023 on 2018/9/26.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import "CountDownMaster.h"

@interface CountDownMaster()

@property (nonatomic ,strong) NSTimer *timer;

@property (nonatomic ,assign) NSInteger count;

@end

@implementation CountDownMaster

- (void)startCountDown{
    
    if (self.timer) {
        self.count = 60;
        [self.timer fire];
    }else{
        self.count = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(actionForTimer) userInfo:nil repeats:YES];
        [self.timer fire];
    }
    
}

- (void)stopCountDown{
    self.count = 60;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)actionForTimer{

    if (self.countDownBlock) {
        self.countDownBlock(self.count);
    }
    
    if (self.count == 0) {
        self.count = 60;
        [self.timer invalidate];
        self.timer = nil;
    }else{
        self.count = self.count - 1;
    }
}

@end
