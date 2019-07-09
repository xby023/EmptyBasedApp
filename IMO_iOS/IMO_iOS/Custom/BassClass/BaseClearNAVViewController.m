//
//  BaseClearNAVViewController.m
//  IMO_iOS
//
//  Created by xby023 on 2019/7/9.
//  Copyright © 2019 com.jglist. All rights reserved.
//

#import "BaseClearNAVViewController.h"

@interface BaseClearNAVViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseClearNAVViewController


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
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(actionForPop)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
    // Do any additional setup after loading the view.
}

- (void)actionForPop{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
