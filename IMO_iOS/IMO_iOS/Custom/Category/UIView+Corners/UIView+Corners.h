//
//  UIView+Corners.h
//  IMO_iOS
//
//  Created by xby023 on 2019/7/9.
//  Copyright © 2019 com.jglist. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Corners)

- (void)cornersWithRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

@end

NS_ASSUME_NONNULL_END
