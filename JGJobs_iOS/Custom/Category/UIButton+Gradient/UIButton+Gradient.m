//
//  UIButton+Gradient.m
//  LSPlanet
//
//  Created by 许必杨 on 2018/5/6.
//  Copyright © 2018年 com.InZiqi. All rights reserved.
//

#import "UIButton+Gradient.h"

@implementation UIButton (Gradient)

- (void)gradientForButton{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithString:@"#9883F1"].CGColor, (__bridge id)[UIColor colorWithString:@"#FC77B1"].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

@end
