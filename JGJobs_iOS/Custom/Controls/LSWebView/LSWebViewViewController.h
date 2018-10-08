//
//  LSWebViewViewController.h
//  LSPlanet
//
//  Created by 许必杨 on 2018/5/22.
//  Copyright © 2018年 com.InZiqi. All rights reserved.
//

#import "BassClearNAVViewController.h"

@interface LSWebViewViewController : BassClearNAVViewController

@property (nonatomic ,copy) NSString *loadUrlString;

@property (nonatomic ,copy) NSString *customTitle;

@property (nonatomic ,copy) NSString *content;

@property (nonatomic ,assign) BOOL fullScreen;

@end
