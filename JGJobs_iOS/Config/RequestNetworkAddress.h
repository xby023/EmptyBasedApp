//
//  RequestNetworkAddress.h
//  BizPay-iOS
//
//  Created by xby023 on 2018/9/26.
//  Copyright © 2018年 xby023. All rights reserved.
//

#ifndef RequestNetworkAddress_h
#define RequestNetworkAddress_h

#pragma mark ====================================数据host===================================

//测试服
#define InterfaceHeader @"http://54.222.224.13:8998/api/v1/"

//正式务
//#define InterfaceHeader @"https://api.ls-star.com/v1/"

#pragma mark ====================================数据接口===================================

#define UserPort [NSString stringWithFormat:@"%@user",InterfaceHeader]


#endif /* RequestNetworkAddress_h */
