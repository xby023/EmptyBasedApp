//
//  BassClearNAVViewController.m
//  LSPlanet
//
//  Created by 许必杨 on 2018/4/27.
//  Copyright © 2018年 com.InZiqi. All rights reserved.
//

#import "BassClearNAVViewController.h"

@interface BassClearNAVViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BassClearNAVViewController


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
