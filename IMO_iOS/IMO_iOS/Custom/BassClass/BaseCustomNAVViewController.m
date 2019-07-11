//
//  BaseCustomNAVViewController.m
//  IMO_iOS
//
//  Created by xby023 on 2019/7/9.
//  Copyright © 2019 com.jglist. All rights reserved.
//

#import "BaseCustomNAVViewController.h"

@interface BaseCustomNAVViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseCustomNAVViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont pingFangMediumFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //解决隐藏tabbar上移问题
    [self.tabBarController.tabBar setTranslucent:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithString:@"#404B6C"].CGColor, (__bridge id)[UIColor colorWithString:@"#404B6C"].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0,0,ScreenWidth, 64 + NAVIBAR_Space);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.colors = @[(__bridge id)[UIColor colorWithString:@"#2E3754"].CGColor, (__bridge id)[UIColor colorWithString:@"#182034"].CGColor];
    gradientLayer1.locations = @[@0.0, @1.0];
    gradientLayer1.startPoint = CGPointMake(0,0);
    gradientLayer1.endPoint = CGPointMake(0,1.0);
    gradientLayer1.frame = CGRectMake(0,0,ScreenWidth,ScreenHeight);
    [self.view.layer insertSublayer:gradientLayer1 atIndex:0];
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(actionForPop)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
    // Do any additional setup after loading the view.
}

- (void)actionForPop{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
