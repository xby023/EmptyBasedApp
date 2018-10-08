//
//  XBYShotScreenControlView.h
//  LSPlanet
//
//  Created by 许必杨 on 2018/4/30.
//  Copyright © 2018年 com.InZiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShareBlock)(void);

@interface XBYShotScreenControlView : UIView

@property (nonatomic,copy) ShareBlock shareBlock;

- (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)image;

- (void)showXBYShotScreenControlView;

- (void)hidenXBYShotScreenControlView;

@end
