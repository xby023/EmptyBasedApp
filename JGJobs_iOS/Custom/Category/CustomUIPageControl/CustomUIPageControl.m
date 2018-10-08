//
//  CustomUIPageControl.m
//  JGTicket
//
//  Created by 许必杨 on 2018/3/7.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import "CustomUIPageControl.h"

@implementation CustomUIPageControl

//重写setCurrentPage方法，可设置圆点大小
- (void) setCurrentPage:(NSInteger)page {
    [super setCurrentPage:page];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 20;
        size.width = 20;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
    }
}

@end
