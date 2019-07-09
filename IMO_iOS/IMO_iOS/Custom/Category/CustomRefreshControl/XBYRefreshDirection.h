//
//  XBYRefreshDirection.h
//  CustomRefreshController
//
//  Created by 许必杨 on 2018/2/24.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#ifndef XBYRefreshDirection_h
#define XBYRefreshDirection_h

typedef void(^XBYHeaderRefreshBlock)(void);

typedef void(^XBYFooterRefreshBlock)(void);

typedef NS_ENUM(NSUInteger,XBYRefreshState){
    XBYRefreshStateNormal,
    XBYRefreshStateCanRefresh,
    XBYRefreshStateRefreshing,
    XBYRefreshStateNoMoreData
};

#define customTopOffY 55

#define customBottomOffY 45


#endif /* XBYRefreshDirection_h */
