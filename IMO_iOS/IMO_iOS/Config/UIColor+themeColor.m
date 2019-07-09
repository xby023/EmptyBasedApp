//
//  UIColor+themeColor.m
//  JGJobs_iOS
//
//  Created by xby023 on 2019/7/8.
//  Copyright © 2019 xby023. All rights reserved.
//

#import "UIColor+themeColor.h"

@implementation UIColor (themeColor)

+ (UIColor *)BColor{
    return [UIColor colorWithString:@"#123456"];
}

+ (UIColor *)randColor{
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

@end
