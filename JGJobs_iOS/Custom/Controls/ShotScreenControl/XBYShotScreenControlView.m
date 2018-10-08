//
//  XBYShotScreenControlView.m
//  LSPlanet
//
//  Created by 许必杨 on 2018/4/30.
//  Copyright © 2018年 com.InZiqi. All rights reserved.
//

#import "XBYShotScreenControlView.h"

@interface XBYShotScreenControlView()

/**
 分享图
 */
@property (nonatomic ,strong) UIImage *image;

/**
 分享view
 */
@property (nonatomic ,strong) UIView *shareView;


@end

@implementation XBYShotScreenControlView

- (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)image{
    
    if (self = [super initWithFrame:frame] ) {
        _image = image;
    }
    return self;
}

- (void)showXBYShotScreenControlView{
    self.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = [UIScreen mainScreen].bounds;
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn addTarget:self action:@selector(hidenXBYShotScreenControlView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    imageView.image = _image;
    [self addSubview:imageView];
    imageView.layer.borderWidth = 3;
    imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(ScreenWidth - 80 - 15, ScreenHeight - 64 - TabBar_Space - 35, 80, 35);
    [shareButton setTitle:@"分享截图" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shareButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:1];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareButton];
    shareButton.alpha = 0;
    
    [UIView animateWithDuration:0.4 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        imageView.frame = CGRectMake(ScreenWidth - 80 - 15, ScreenHeight - (80 * ScreenHeight / ScreenWidth) - 64 - TabBar_Space, 80,80 * ScreenHeight / ScreenWidth);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            shareButton.alpha = 1;
        }];
    }];
}

- (void)shareAction{
    if (_shareBlock) {
        _shareBlock();
    }
    [self hidenXBYShotScreenControlView];
}

- (void)hidenXBYShotScreenControlView{

    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
       
        
    }];
}
@end
