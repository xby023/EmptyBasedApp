//
//  ROOTNavigationController.m
//  BizPay-iOS
//
//  Created by xby023 on 2018/9/28.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import "ROOTNavigationController.h"

@interface ROOTNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation ROOTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //    BOOL enable = [viewController getInteractivePopGestureRecognizerEnable];
    [viewController.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (viewController == obj) {
            NSLog(@"count --- %ld childVC --- %ld",idx,viewController.navigationController.childViewControllers.count);
        }
    }];
    
    if (viewController.navigationController.childViewControllers.firstObject == viewController) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }else{
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    
    
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
