//
//  CountryCodeListCell.m
//  BizPay-iOS
//
//  Created by xby023 on 2018/9/26.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import "CountryCodeListCell.h"

@implementation CountryCodeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor clearColor];
    
    self.titleLabel.font = [UIFont pingFangRegularFontOfSize:16];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.subTitleLabel.font = [UIFont pingFangRegularFontOfSize:14];
    self.subTitleLabel.textColor = [UIColor whiteColor];
    
    self.line.backgroundColor = [UIColor colorWithString:@"#55648F"];
    self.line.layer.shadowColor = [UIColor colorWithString:@"#1C233C"].CGColor;
    self.line.layer.shadowOffset = CGSizeMake(0, -0.5);
    self.line.layer.shadowRadius = 0;
    self.line.layer.shadowOpacity = 1;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
