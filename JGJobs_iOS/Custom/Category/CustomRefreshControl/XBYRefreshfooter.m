//
//  XBYRefreshfooter.m
//  CustomRefreshController
//
//  Created by 许必杨 on 2018/2/24.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import "XBYRefreshfooter.h"

@interface XBYRefreshfooter ()

@property (nonatomic ,strong) UIActivityIndicatorView *activityView;

@property (nonatomic ,strong) UILabel *stateLab;

@property (nonatomic ,assign) XBYRefreshState refreshState;

@end

@implementation XBYRefreshfooter


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
    self.activityView        = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.frame  = CGRectMake(ScreenWidth/2 - 15, (customBottomOffY - 30)/2, 30, 30);
    self.activityView.hidesWhenStopped = NO;
    self.activityView.tintColor = [UIColor lightGrayColor];
    self.activityView.alpha = 0;
    [self addSubview:self.activityView];
    
    self.stateLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, customBottomOffY)];
    self.stateLab.font = [UIFont pingFangRegularFontOfSize:12];
    self.stateLab.textColor = [UIColor colorWithString:@"#BBBBBB"];
    self.stateLab.text = @"没有更多的交易记录了~";
    self.stateLab.hidden = YES;
    [self addSubview:self.stateLab];
    
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
        
        self.frame = CGRectMake(0,self.targetScrollView.contentSize.height, ScreenWidth, customBottomOffY);
//        NSLog(@"tracking -- %d      dragging -- %d  decelerating -- %d ",self.targetScrollView.tracking,self.targetScrollView.dragging,self.targetScrollView.decelerating);
        
        
        if (self.refreshState == XBYRefreshStateNoMoreData) {
            return;
        }
        
        /*
         若不添加判断会出现警告：could not execute support code to read Objective-C class data in the process
         */
        CGFloat contentY = 0;
        if ((self.targetScrollView.contentSize.height - self.targetScrollView.frame.size.height) >= 0) {
            contentY = (self.targetScrollView.contentSize.height - self.targetScrollView.frame.size.height);
        }else{
            contentY = 0;
        }
        
        if (self.targetScrollView.tracking == 0 && self.targetScrollView.dragging == 0 && self.targetScrollView.decelerating == 1) {
            if (offY > (contentY + customBottomOffY + 10)) {
                self.activityView.alpha = 1;
                if (self.refreshState != XBYRefreshStateRefreshing) {
                    self.refreshState = XBYRefreshStateRefreshing;
                    [self animationByRefreshState:self.refreshState];
                }
            }else if (offY <= (contentY + customBottomOffY + 10) && offY > contentY){
                if (self.refreshState != XBYRefreshStateRefreshing) {
                   self.activityView.alpha = (offY - contentY) / (customBottomOffY + 10);
                }
            }else{
                if (self.refreshState != XBYRefreshStateRefreshing) {
                    self.activityView.alpha = 0;
                }
            }
            
        }else{
            if (offY > (contentY + customBottomOffY + 10)) {
                self.refreshState = XBYRefreshStateCanRefresh;
                self.activityView.alpha = 1;
            }else if (offY <= (contentY + customBottomOffY + 10) && offY > contentY){
                self.refreshState = XBYRefreshStateNormal;
                self.activityView.alpha = (offY - contentY) / (customBottomOffY + 10);
            }else{
                self.activityView.alpha = 0;
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
            [self.activityView stopAnimating];
            self.activityView.hidden = NO;
            self.stateLab.hidden = YES;
            break;
        case XBYRefreshStateCanRefresh:
            [self.activityView stopAnimating];
            self.activityView.hidden = NO;
            self.stateLab.hidden = YES;
            break;
        case XBYRefreshStateRefreshing:
            [self starAnimation];
            break;
        case XBYRefreshStateNoMoreData:
            [self noMoreData];
            break;
        default:
            [self.activityView stopAnimating];
            self.activityView.hidden = NO;
            self.stateLab.hidden = YES;
            break;
    }
}

- (void)noMoreData{
    [self.activityView stopAnimating];
    self.stateLab.text = @"没有更多的记录了~";
    self.activityView.alpha = 0;
    self.stateLab.textAlignment = NSTextAlignmentCenter;
    self.stateLab.hidden = NO;
    self.activityView.hidden = YES;
}

- (void)starAnimation{
    
    self.stateLab.hidden = YES;;
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    if (self.refreshFooterBlock) {
        self.refreshFooterBlock();
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.targetScrollView setContentInset:UIEdgeInsetsMake(0, 0,customBottomOffY, 0)];
    }];
}

@end
