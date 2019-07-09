//
//  IMODefine.h
//  IMO_iOS
//
//  Created by xby023 on 2019/7/9.
//  Copyright © 2019 com.jglist. All rights reserved.
//

#ifndef IMODefine_h
#define IMODefine_h

#define LoginIndentifer @"LoginIndentifer"

#define TokenIndentifer @"TokenIndentifer"

#define PushIndentifer @"PushIndentifer"

#define DeviceTokenIndentifer @"DeviceTokenIndentifer"


#pragma mark ====================================size===================================

#define ScreenHeight  [[UIScreen mainScreen] bounds].size.height

#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width

#define NavHeight     ([[UIApplication sharedApplication] statusBarFrame].size.height + 44)

#define NAVIBAR_Space (NavHeight - 64.f)

#define TabbarHeight  ([[UIApplication sharedApplication] statusBarFrame].size.height == 44 ? 83.f : 49.f)
#define TabBar_Space  (TabbarHeight - 49.f)

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && ScreenHeight == 568.0)

/**
 *  比例适配
 */
#define ADOPT_WIDTH ([UIScreen mainScreen].bounds.size.width / 375)

#define ADOPT_HEIGHT ([UIScreen mainScreen].bounds.size.height / 667)

#define WS(weakSelf)  __weak __typeof(&*self) weakSelf = self;

#endif /* IMODefine_h */
