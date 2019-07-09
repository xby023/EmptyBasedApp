//
//  MainPageViewController.m
//  JGJobs_iOS
//
//  Created by xby023 on 2018/10/8.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import "MainPageViewController.h"
#import "UIColor+themeColor.h"
#import "NSString+URL.h"

#import "DetailViewController.h"
@interface MainPageViewController ()

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor BColor];
    self.title = @"钱包";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
