//
//  XBYProgressHUD.h
//  JGTicket
//
//  Created by 许必杨 on 2018/3/23.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XBYHUDType) {
    XBYHUDLoadingType,//加载中
    XBYHUDSuccessfulAnimatedType,//加载成功动画
    XBYHUDErrorAnimatedType,//加载错误动画
    XBYHUDpromptTextType,//提示文字
    XBYHUDLoadingByGifType,//加载中
};

@interface XBYProgressHUD : UIView

@property (nonatomic,strong) NSString *tipText;

@property(nonatomic,strong)  UILabel * showTextLabel;

@property (nonatomic,strong) UIView *toast;

@property (nonatomic,assign,getter=isWhite) BOOL white;

@property(nonatomic,assign)  XBYHUDType type;

- (void)show:(BOOL)animated view:(UIView *)view;

- (void)hide:(BOOL)animated view:(UIView *)view;

- (instancetype)initWithFrame:(CGRect)frame showText:(NSString *)showText HUDType:(XBYHUDType)type;
///加载Gif类型
+ (instancetype)showLoadingGifHUDIsWhiteBackgroundColor:(BOOL)isWhite;
///加载类型
+ (instancetype)showLoadingHUDWithText:(NSString *)showText;
//加载成功提示
+ (instancetype)showSuccessfulAnimatedText:(NSString *)ShowText;
//错误提示
+ (instancetype)showErrorAnimatedText:(NSString *)ShowText;
//文字提示
+ (instancetype)showAlertText:(NSString *)showText;
//隐藏
+ (NSUInteger)hideAllHUDAnimated:(BOOL)animated;



@end
