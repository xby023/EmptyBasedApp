//
//  CountryCodeViewController.m
//  BizPay-iOS
//
//  Created by xby023 on 2018/9/26.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import "CountryCodeViewController.h"
#import "CountryCodeListCell.h"
@interface CountryCodeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) NSArray *dataArray;

@end

@implementation CountryCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource{
    
    self.dataArray = @[];
    
    [SVProgressHUD showWithStatus:@"请稍等..."];
    [WebTools webTools_GetRequest:@"" Params:@{} Success:^(id responseData) {
        NSInteger code = [responseData[@"code"] integerValue];
        if (code == 200) {
            self.dataArray = [CountryCodeModel mj_objectArrayWithKeyValuesArray:responseData[@"data"]];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showInfoWithStatus:responseData[@"msg"]];
        }
    } Failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
    
}

- (void)initializeUserInterface{
    
    self.title = @"地区代码";
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(44,NavHeight - 44, ScreenWidth - 88, 44)];
    titleLabel.font = [UIFont pingFangMediumFontOfSize:18];
    titleLabel.text = @"地区代码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, NavHeight - 44, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"goBack"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(actionForBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    [self.view addSubview:self.tableView];
    
}

- (void)actionForBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark ==================================== tableView ===================================

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CountryCodeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountryCodeListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CountryCodeModel *model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.name_cn;
    cell.subTitleLabel.text = [NSString stringWithFormat:@"+%@",model.area_code];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectBlock) {
        CountryCodeModel *model = self.dataArray[indexPath.row];
        self.selectBlock(model);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark ====================================getter===================================

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavHeight,ScreenWidth,ScreenHeight - NavHeight)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource  = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CountryCodeListCell class]) bundle:nil] forCellReuseIdentifier:@"CountryCodeListCell"];
    }
    return _tableView;
    
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
