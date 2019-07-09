//
//  RootTabBarViewViewController.m
//  BizPay-iOS
//
//  Created by 许必杨 on 2018/7/27.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import "RootTabBarViewViewController.h"
#import "ROOTNavigationController.h"
@interface RootTabBarViewViewController ()

@end

@implementation RootTabBarViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTabBarItemTitleColor];
    [self addChildVCs];
}


/**
 *  使用Appearance设置UITabBarItem的风格，这样整个APP中的UITabBarItem都是这个风格
 */

- (void)setUpTabBarItemTitleColor
{
    UITabBarItem *item   = [UITabBarItem appearance];
    
    NSDictionary *dic    = @{
                             NSForegroundColorAttributeName: [UIColor blueColor]
                             };
    [item setTitleTextAttributes:dic forState:UIControlStateSelected];

    NSDictionary *dicNor = @{
                             NSForegroundColorAttributeName: [UIColor lightGrayColor]
                             };
    [item setTitleTextAttributes:dicNor forState:UIControlStateNormal];
    
    //设置tabbar背景颜色
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth,TabbarHeight)];
//    backView.backgroundColor = [UIColor redColor];
//    [self.tabBar insertSubview:backView atIndex:0];
    
    //防止偏移
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}

- (void)addChildVCs{
    [self setUpChildView:self.mainPageVC WithTitle:@"钱包" imageName:@"tab1" selectedImageName:@"tab2"];
    [self setUpChildView:self.minePageVC WithTitle:@"我的" imageName:@"tab1" selectedImageName:@"tab2"];
}


/**
 *  设置底部工具栏的button和对应的viewController的title
 *
 *  @param childView         需要设置的view
 *  @param title             title
 *  @param imageName         图片名字
 *  @param selectedImageName 选中时的图片名字
 */
- (void)setUpChildView:(UIViewController *)childView WithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //使用自定义的NavigationController作为每个TabBarItem对应的View，并设置传进来的childView为自定义导航控制器的根视图
    ROOTNavigationController *naviVC     = [[ROOTNavigationController alloc] initWithRootViewController:childView];
    //为什么下面这句会让底部tabBar文字title消失？
    childView.tabBarItem.title         = title;
    //    naviVC.navigationBar.hidden = YES;
    childView.tabBarItem.image         = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //这里的originalImag是为了防止button选中时的图片被系统渲染成蓝色
    childView.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:naviVC];
    
}


- (MainPageViewController *)mainPageVC{
    if (!_mainPageVC) {
        _mainPageVC = [[MainPageViewController alloc]init];
    }
    return _mainPageVC;
}

- (MinePageViewController *)minePageVC{
    if (!_minePageVC) {
        _minePageVC = [[MinePageViewController alloc]init];
    }
    return _minePageVC;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
