//
//  SizesAndColorsAndOther.h
//  LSPlanet
//
//  Created by 许必杨 on 2018/4/27.
//  Copyright © 2018年 com.InZiqi. All rights reserved.
//

#ifndef SizesAndColorsAndOther_h
#define SizesAndColorsAndOther_h

#define LoginIndentifer @"LoginIndentifer"

#define TokenIndentifer @"TokenIndentifer"

#define PushIndentifer @"PushIndentifer"

#define DeviceTokenIndentifer @"DeviceTokenIndentifer"



//法币 默认人民币 = NO  美元 = YES
#define LegalTenderIndentifer @"LegalTenderIndentifer"

#pragma mark ====================================color===================================

#define RandColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#define BBlackBackgrooundColor @"#535A6A"








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


#endif /* SizesAndColorsAndOther_h */
