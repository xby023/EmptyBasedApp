//
//  ChooseAlertView.h
//  JGTicket
//
//  Created by 许必杨 on 2018/3/8.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ShowChooseAlertViewBlock)(void);

typedef void(^HidenChooseAlertViewBlock)(void);

//如果存在二级列表
typedef void(^ChooseAlertViewSelectBlock)(NSInteger firstIndex,NSInteger secondIndex);

@interface ChooseAlertView : UIView

- (instancetype)initWithShowByTextFiled:(UITextField *)showByTextFiled;

@property (nonatomic ,strong) UITextField *showByTextFiled;

@property (nonatomic ,copy) ShowChooseAlertViewBlock showChooseAlertViewBlock;

@property (nonatomic ,copy) HidenChooseAlertViewBlock hidenChooseAlertViewBlock;

@property (nonatomic ,copy) ChooseAlertViewSelectBlock selectBlock;

@property (nonatomic ,strong) NSArray <NSString *>*dataArray;

- (void)showChooseAlertView;

- (void)hidenChooseAlertView;

@end
