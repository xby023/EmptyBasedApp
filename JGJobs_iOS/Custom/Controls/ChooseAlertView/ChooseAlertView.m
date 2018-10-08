//
//  ChooseAlertView.m
//  JGTicket
//
//  Created by 许必杨 on 2018/3/8.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import "ChooseAlertView.h"

@interface ChooseAlertView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) UIImageView *backImageView;

@end


@implementation ChooseAlertView

- (instancetype)initWithShowByTextFiled:(UITextField *)showByTextFiled{
    if (self = [super init]) {
        self.showByTextFiled = showByTextFiled;
    }
    return self;
}

- (void)showChooseAlertView{
    self.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = [UIScreen mainScreen].bounds;
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn addTarget:self action:@selector(hidenChooseAlertView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    //获取基于window的位置
    CGRect rect = [self.showByTextFiled convertRect:self.showByTextFiled.bounds toView:[UIApplication sharedApplication].keyWindow];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(rect.origin.x, rect.origin.y + rect.size.height + 10 - 55, rect.size.width, 100)];
    backImageView.backgroundColor = [UIColor whiteColor];
    backImageView.layer.cornerRadius = 4;
    backImageView.layer.shadowColor = [UIColor blueColor].CGColor;
    backImageView.layer.shadowOffset = CGSizeMake(0,5);
    backImageView.layer.shadowOpacity = 0.5;
    backImageView.layer.shadowRadius = 5;
    backImageView.userInteractionEnabled = YES;
    [self addSubview:backImageView];
    self.backImageView = backImageView;

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, rect.size.width, 90)];
    self.tableView .backgroundColor = [UIColor clearColor];
    self.tableView .delegate = self;
    self.tableView .dataSource  = self;
    self.tableView .separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView  registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [backImageView addSubview:self.tableView];
    
    self.backImageView.layer.anchorPoint = CGPointMake(0.5, 0);
    self.backImageView.transform = CGAffineTransformMakeScale(1, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        self.backImageView.transform = CGAffineTransformIdentity;
    }];
    
    if (_showChooseAlertViewBlock) {
        _showChooseAlertViewBlock();
    }
}

- (void)hidenChooseAlertView{
    if (_hidenChooseAlertViewBlock) {
        _hidenChooseAlertViewBlock();
    }
    [UIView animateWithDuration:0.3 animations:^{
        //Scale(1, 0.01)不能直接设为0 动画会消失
        self.backImageView.transform = CGAffineTransformMakeScale(1, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark ====================================delegate===================================

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self hidenChooseAlertView];
    if (self.selectBlock) {
        //暂时写入0如果存在二级
        self.selectBlock(indexPath.row,0);
    }
    
}
@end
