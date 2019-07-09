//
//  CustomAlertPikerView.m
//  JGTicket
//
//  Created by 许必杨 on 2018/4/3.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import "CustomAlertPikerView.h"
#define HeightForSelf 244
@interface CustomAlertPikerView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UILabel *titleLabel;

@end


@implementation CustomAlertPikerView

- (void)showCustomAlertPikerView{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = [UIScreen mainScreen].bounds;
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn addTarget:self action:@selector(hidenCustomAlertPikerView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - HeightForSelf, ScreenWidth, HeightForSelf)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    [self.backView addSubview:self.tableView];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(0, 0, 60, 44);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(hidenCustomAlertPikerView) forControlEvents:UIControlEventTouchUpInside];
    cancel.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.backView addSubview:cancel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, ScreenWidth, 0.5)];
    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7];
    [self.backView addSubview:line];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(44, 0, ScreenWidth - 88, 44)];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.text = @"";
    [self.backView addSubview:self.titleLabel];
    
//    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
//    sure.frame = CGRectMake(ScreenWidth - 60, 0, 60, 44);
//    [sure setTitle:@"确定" forState:UIControlStateNormal];
//    [sure setTitleColor:[UIColor colorWithString:ThemeColor] forState:UIControlStateNormal];
//    [sure addTarget:self action:@selector(actionForSure) forControlEvents:UIControlEventTouchUpInside];
//    sure.titleLabel.font = [UIFont systemFontOfSize:16];
//    [self.backView addSubview:sure];
    
    
    self.backView.transform = CGAffineTransformMakeTranslation(0, HeightForSelf);
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    if (_showCustomAlertPikerViewBlock) {
        _showCustomAlertPikerViewBlock();
    }
    
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = _title;
}

//- (void)actionForSure{
//
//    if (_selectBlock) {
//        _selectBlock(@"");
//    }
//    [self hidenCustomAlertPikerView];
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}


- (void)hidenCustomAlertPikerView{
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.transform = CGAffineTransformMakeTranslation(0, HeightForSelf);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    if (_hidenCustomAlertPikerViewBlock) {
        _hidenCustomAlertPikerViewBlock();
    }
}

#pragma mark ====================================delegate===================================

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor blackColor];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, ScreenWidth, 0.5)];
    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [cell addSubview:line];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectBlock) {
        _selectBlock(indexPath.row);
    }
    [self hidenCustomAlertPikerView];
}

#pragma mark ====================================getter===================================

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,44, ScreenWidth, HeightForSelf - 44)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource  = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
    
}

@end
