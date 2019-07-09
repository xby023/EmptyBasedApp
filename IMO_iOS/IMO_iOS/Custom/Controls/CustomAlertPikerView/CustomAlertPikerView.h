//
//  CustomAlertPikerView.h
//  JGTicket
//
//  Created by 许必杨 on 2018/4/3.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShowCustomAlertPikerViewBlock)(void);

typedef void(^HidenCustomAlertPikerViewBlock)(void);

typedef void(^CustomAlertPikerViewSelectBlock)(NSInteger index);

@interface CustomAlertPikerView : UIView

@property (nonatomic ,strong) UITextField *showByTextFiled;

@property (nonatomic ,copy) ShowCustomAlertPikerViewBlock showCustomAlertPikerViewBlock;

@property (nonatomic ,copy) HidenCustomAlertPikerViewBlock hidenCustomAlertPikerViewBlock;

@property (nonatomic ,copy) CustomAlertPikerViewSelectBlock selectBlock;

@property (nonatomic ,strong) NSArray <NSString *>*dataArray;

@property (nonatomic ,copy) NSString *title;

- (void)showCustomAlertPikerView;

- (void)hidenCustomAlertPikerView;


@end
