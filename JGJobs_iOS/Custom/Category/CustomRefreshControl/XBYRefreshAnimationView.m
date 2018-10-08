//
//  XBYRefreshAnimationView.m
//  LSPlanet
//
//  Created by 许必杨 on 2018/5/17.
//  Copyright © 2018年 com.InZiqi. All rights reserved.
//

#import "XBYRefreshAnimationView.h"

@interface XBYRefreshAnimationView ()

@property (nonatomic ,strong) UIImageView *loadingImageView;

@end

@implementation XBYRefreshAnimationView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
      
        self.loadingImageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - 26)/2,(frame.size.height - 26)/2,26, 26)];
        self.loadingImageView.image = [UIImage imageNamed:@"loadingImageR"];
        [self addSubview:self.loadingImageView];
        
    }
    return self;
}


- (void)stopAnimation{
    [self.loadingImageView.layer removeAllAnimations];
}

- (void)starAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
   animation.fromValue = [NSNumber numberWithFloat:0.f];
   animation.toValue   = [NSNumber numberWithFloat: M_PI *2];
   animation.duration  = 1;
   animation.autoreverses = NO;
   animation.fillMode  = kCAFillModeForwards;
   animation.repeatCount = MAXFLOAT;
   [self.loadingImageView.layer addAnimation:animation forKey:nil];
}

@end
