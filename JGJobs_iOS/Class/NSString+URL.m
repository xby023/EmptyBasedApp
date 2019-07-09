//
//  NSString+URL.m
//  JGJobs_iOS
//
//  Created by xby023 on 2019/7/8.
//  Copyright © 2019 xby023. All rights reserved.
//

#import "NSString+URL.h"

#define ReleaseHost @"http://www.baidu.com/"

#define DebugHost @"http://192.168.127.1:8080/"

#define DebugState @"0"

@implementation NSString (URL)

+ (NSString *)getHost{
    if ([DebugState integerValue] == 1) {
        return DebugHost;
    }else{
        return ReleaseHost;
    }
}

+ (NSString *)apiForHeader{
    return [NSString stringWithFormat:@"%@%@",[NSString getHost],@"header"];
}

@end
