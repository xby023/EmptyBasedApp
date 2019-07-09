//
//  UIView+Corners.m
//  IMO_iOS
//
//  Created by xby023 on 2019/7/9.
//  Copyright © 2019 com.jglist. All rights reserved.
//

#import "UIView+Corners.h"

@implementation UIView (Corners)

- (void)cornersWithRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = bezierPath.CGPath;
    self.layer.mask = shapeLayer;
};

@end
