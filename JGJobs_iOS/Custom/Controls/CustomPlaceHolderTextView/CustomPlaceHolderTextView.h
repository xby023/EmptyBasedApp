//
//  CustomPlaceHolderTextView.h
//  JGTicket
//
//  Created by 许必杨 on 2018/3/5.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextFieldHightBlock)(CGSize size);

@interface CustomPlaceHolderTextView : UITextField<UITextFieldDelegate>

@property (nonatomic ,copy) TextFieldHightBlock  textFieldHightBlock;

/**
 *  自定义初始化方法
 *
 *  @param frame       frame
 *  @param placeholder 提示语
 *  @param clear       是否显示清空按钮 YES为显示
 *  @param view        是否设置leftView不设置传nil
 *  @param font        设置字号
 *
 *  @return id
 */
-(id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder clear:(BOOL)clear leftView:(id)view fontSize:(CGFloat)font;


@end
