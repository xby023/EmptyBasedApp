//
//  XBYRefreshHeader.m
//  CustomRefreshController
//
//  Created by 许必杨 on 2018/2/24.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import "XBYRefreshHeader.h"
#import <UIImage+GIF.h>
#import "XBYRefreshAnimationView.h"
@interface XBYRefreshHeader()

//@property (nonatomic ,strong) UIActivityIndicatorView *activityView;
//
//@property (nonatomic ,strong) UILabel *stateLab;

@property (nonatomic ,assign) XBYRefreshState refreshState;

@property (nonatomic ,strong) XBYRefreshAnimationView *animationView;

@end

@implementation XBYRefreshHeader


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomUI];
    }
    return self;
}


- (void)initCustomUI{
    self.refreshState = XBYRefreshStateNormal;
    self.backgroundColor = [UIColor clearColor];

    self.animationView = [[XBYRefreshAnimationView alloc]initWithFrame:CGRectMake((ScreenWidth - 55)/2,customTopOffY - 55,55,55)];
    self.animationView.alpha = 0;
    [self addSubview:self.animationView];
    
//    self.backgroundColor     = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
//    self.activityView        = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    self.activityView.frame  = CGRectMake(ScreenWidth/2 - 70, (customTopOffY - 30)/2, 30, 30);
//    self.activityView.hidesWhenStopped = NO;
//    self.activityView.tintColor = [UIColor lightGrayColor];
//    [self addSubview:self.activityView];
//
//    self.stateLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2 - 40, (customTopOffY - 30)/2, 120, 30)];
//    self.stateLab.font = [UIFont AvenirLightWithFontSize:16];
//    self.stateLab.text = @"下拉刷新";
//    [self addSubview:self.stateLab];
    
}

- (void)setTargetScrollView:(UIScrollView *)targetScrollView{
    _targetScrollView = targetScrollView;
    [self.targetScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(nullable void *)context{
    if([keyPath isEqualToString:@"contentOffset"]){
        NSValue * point = (NSValue *)[change objectForKey:@"new"];
        CGPoint p = [point CGPointValue];
        CGFloat offY = p.y;
        
//        NSLog(@"tracking -- %d      dragging -- %d  decelerating -- %d ",self.targetScrollView.tracking,self.targetScrollView.dragging,self.targetScrollView.decelerating);
        if (self.targetScrollView.tracking == 0 && self.targetScrollView.dragging == 0 && self.targetScrollView.decelerating == 1) {
            if (offY < -(customTopOffY)) {
                self.animationView.alpha = 1;
                if (self.refreshState != XBYRefreshStateRefreshing) {
                    self.refreshState = XBYRefreshStateRefreshing;
                    [self animationByRefreshState:self.refreshState];
                }
            }else if (offY >= -(customTopOffY + 10) && offY < 0){
                self.animationView.alpha = offY / -(customTopOffY + 10);
            }else{
                self.animationView.alpha = 0;
            }
        }else{
            if (offY < -(customTopOffY + 10)) {
                self.refreshState = XBYRefreshStateCanRefresh;
                self.animationView.alpha = 1;
            }else if (offY >= -(customTopOffY + 10) && offY < 0){
                self.refreshState = XBYRefreshStateNormal;
                self.animationView.alpha = offY / -(customTopOffY + 10);
            }else{
                self.animationView.alpha = 0;
                self.refreshState = XBYRefreshStateNormal;
            }
            if (self.refreshState != XBYRefreshStateRefreshing) {
                [self animationByRefreshState:self.refreshState];
            }
        }
        
    }
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)animationByRefreshState:(XBYRefreshState)refreshState{
    _refreshState = refreshState;
    switch (_refreshState) {
        case XBYRefreshStateNormal:
//            [self.activityView stopAnimating];
//            self.stateLab.text = @"下拉刷新";
            [self.animationView stopAnimation];
            break;
        case XBYRefreshStateCanRefresh:
//            [self.activityView stopAnimating];
//            self.stateLab.text = @"松开手刷新";
            [self.animationView stopAnimation];
            break;
        case XBYRefreshStateRefreshing:
            [self starAnimation];
            break;
        case XBYRefreshStateNoMoreData:
//            [self.activityView stopAnimating];
            [self.animationView stopAnimation];
            break;
        default:
//            [self.activityView stopAnimating];
//            self.stateLab.text = @"下拉刷新";
            [self.animationView stopAnimation];
            break;
    }
}

- (void)starAnimation{
//    [self.activityView startAnimating];
//    self.stateLab.text = @"正在刷新...";
    
    if (self.refreshHeaderBlock) {
        self.refreshHeaderBlock();
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.targetScrollView setContentInset:UIEdgeInsetsMake(customTopOffY, 0, 0, 0)];
    } completion:^(BOOL finished) {
       [self.animationView starAnimation];
    }];
}


@end
