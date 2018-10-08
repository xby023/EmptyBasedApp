//
//  XBYHandwrittenSignatureView.h
//  手写签名
//
//  Created by 许必杨 on 2018/2/28.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBYHandwrittenSignatureView : UIView

@property (nonatomic ,assign,getter=isWrite) BOOL write;

/**
 回退一步
 */
- (void)backToOneStep;


/**
 重新写
 */
- (void)rewriteSignature;


/**
 保存未片
 */
- (void)saveImage;

//获取图片
- (UIImage *)getImage;

@end
