//
//  RootTabBarViewViewController.h
//  BizPay-iOS
//
//  Created by 许必杨 on 2018/7/27.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainPageViewController.h"
#import "MinePageViewController.h"

@interface RootTabBarViewViewController : UITabBarController

@property (nonatomic,strong) MainPageViewController *mainPageVC;

@property (nonatomic,strong) MinePageViewController *minePageVC;

@end
