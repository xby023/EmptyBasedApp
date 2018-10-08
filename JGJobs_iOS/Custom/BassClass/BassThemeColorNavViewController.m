//
//  BassThemeColorNavViewController.m
//  BizPay-iOS
//
//  Created by 许必杨 on 2018/8/17.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import "BassThemeColorNavViewController.h"

@interface BassThemeColorNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BassThemeColorNavViewController


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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithString:@"#6651C1"].CGColor, (__bridge id)[UIColor colorWithString:@"#283B99"].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0,0,ScreenWidth, 180 + NAVIBAR_Space);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(actionForPop)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
    // Do any additional setup after loading the view.
}

- (void)actionForPop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
