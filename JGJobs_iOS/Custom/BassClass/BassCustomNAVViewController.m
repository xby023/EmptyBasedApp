//
//  BassCustomNAVViewController.m
//  LSPlanet
//
//  Created by 许必杨 on 2018/4/27.
//  Copyright © 2018年 com.InZiqi. All rights reserved.
//

#import "BassCustomNAVViewController.h"

@interface BassCustomNAVViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BassCustomNAVViewController

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
