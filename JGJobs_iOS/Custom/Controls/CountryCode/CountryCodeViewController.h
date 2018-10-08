//
//  CountryCodeViewController.h
//  BizPay-iOS
//
//  Created by xby023 on 2018/9/26.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import "BassCustomNAVViewController.h"
#import "CountryCodeModel.h"
@interface CountryCodeViewController : BassCustomNAVViewController

@property (nonatomic ,copy) void(^selectBlock)(CountryCodeModel *model);

@end
