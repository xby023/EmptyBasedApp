//
//  UIScrollView+XBYRefreshControl.h
//  CustomRefreshController
//
//  Created by 许必杨 on 2018/2/24.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBYRefreshDirection.h"
#import "XBYRefreshHeader.h"
#import "XBYRefreshfooter.h"

@interface UIScrollView (XBYRefreshControl)<UIScrollViewDelegate>

@property (nonatomic ,strong) XBYRefreshHeader *refreshXBYHeader;

@property (nonatomic ,strong) XBYRefreshfooter *refreshXBYfooter;

- (void)beginXBYRefreshing;

- (void)endXBYRefreshing;

- (void)endXBYFooderRefreshingNoMoreData;

- (void)bindingRefreshHeaderWithRefreshBlock:(XBYHeaderRefreshBlock)refreshBlock;

- (void)bindingRefreshFooterWithRefreshBlock:(XBYFooterRefreshBlock)refreshBlock;

@end
