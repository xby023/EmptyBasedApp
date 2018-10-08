//
//  XBYRefreshHeader.h
//  CustomRefreshController
//
//  Created by 许必杨 on 2018/2/24.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBYRefreshDirection.h"

@interface XBYRefreshHeader : UIView

- (void)animationByRefreshState:(XBYRefreshState)refreshState;

@property (nonatomic ,strong) UIScrollView *targetScrollView;

@property (nonatomic ,copy) XBYHeaderRefreshBlock refreshHeaderBlock;

@end
