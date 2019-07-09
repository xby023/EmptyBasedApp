//
//  UIScrollView+XBYRefreshControl.m
//  CustomRefreshController
//
//  Created by 许必杨 on 2018/2/24.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import "UIScrollView+XBYRefreshControl.h"
#import <objc/runtime.h>

static char XBYRefreshHeaderKey;

static char XBYRefreshFooterKey;

@implementation UIScrollView (XBYRefreshControl)

- (void)bindingRefreshHeaderWithRefreshBlock:(XBYHeaderRefreshBlock)refreshBlock{
    [self setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.refreshXBYHeader = [[XBYRefreshHeader alloc]initWithFrame:CGRectMake(0, -customTopOffY, ScreenWidth, customTopOffY)];
    self.refreshXBYHeader.refreshHeaderBlock = ^{
        if (refreshBlock) {
            refreshBlock();
        }
    };
    self.refreshXBYHeader.targetScrollView = self;
    [self addSubview:self.refreshXBYHeader];
}

- (void)beginXBYRefreshing{
    [self.refreshXBYHeader animationByRefreshState:XBYRefreshStateRefreshing];
}

- (void)bindingRefreshFooterWithRefreshBlock:(XBYFooterRefreshBlock)refreshBlock{
    [self setContentInset:UIEdgeInsetsMake(0, 0, - TabBar_Space, 0)];
    self.refreshXBYfooter = [[XBYRefreshfooter alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, customBottomOffY)];
    self.refreshXBYfooter.refreshFooterBlock = ^{
        if (refreshBlock) {
           refreshBlock();
        }
    };
    self.refreshXBYfooter.targetScrollView = self;
    [self addSubview:self.refreshXBYfooter];
}

- (void)endXBYRefreshing{
    if (self.refreshXBYHeader) {
        [self.refreshXBYHeader animationByRefreshState:XBYRefreshStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            [self setContentInset:UIEdgeInsetsZero];
        }];
    }
    
    if (self.refreshXBYfooter) {
        [self.refreshXBYfooter animationByRefreshState:XBYRefreshStateNormal];
//        [UIView animateWithDuration:0.2 animations:^{
            [self setContentInset:UIEdgeInsetsMake(0, 0, - TabBar_Space, 0)];
//        }];
    }
    
    
}

- (void)endXBYFooderRefreshingNoMoreData{

    if (self.refreshXBYfooter) {
        [self.refreshXBYfooter animationByRefreshState:XBYRefreshStateNoMoreData];
    }
//    [UIView animateWithDuration:0.2 animations:^{
        [self setContentInset:UIEdgeInsetsMake(0, 0,customBottomOffY, 0)];
//    }];
}

//自定义实现的get set 方法来实现分类增加属性功能
- (void)setRefreshXBYHeader:(XBYRefreshHeader *)refreshXBYHeader{
    objc_setAssociatedObject(self, &XBYRefreshHeaderKey, refreshXBYHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setRefreshXBYfooter:(XBYRefreshfooter *)refreshXBYfooter{
    objc_setAssociatedObject(self, &XBYRefreshFooterKey, refreshXBYfooter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XBYRefreshHeader *)refreshXBYHeader{
    return objc_getAssociatedObject(self, &XBYRefreshHeaderKey);
}

- (XBYRefreshfooter *)refreshXBYfooter{
    return objc_getAssociatedObject(self, &XBYRefreshFooterKey);
}

- (void)dealloc{
    
}

@end
