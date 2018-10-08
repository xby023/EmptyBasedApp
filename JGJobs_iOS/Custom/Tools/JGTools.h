//
//  JGTools.h
//  JGJobs_iOS
//
//  Created by xby023 on 2018/10/8.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGTools : NSObject

/**
 放回字符串的尺寸
 
 @param text 文本
 @param font 字体
 @param lineSpacing 间距
 @param size 限制尺寸
 @return 返回尺寸
 */
+ (CGSize)boundingALLRectWithText:(NSString*)text Font:(UIFont*)font LineSpacing:(CGFloat)lineSpacing Size:(CGSize)size;

/**
 渐现加载图片
 
 @param imageView 需要加载图片的imageView
 @param imageUrlString 图片地址
 @param placeHolderImageName 占位图地址
 */
+ (void)setWebImageForImageView:(UIImageView *)imageView ImageUrlString:(NSString *)imageUrlString  PlaceholderImageName:(NSString *)placeHolderImageName;

/**
 系统弹窗
 
 @param title 大标题
 @param detailTitle 详情
 @param actionTitle 按钮title
 @param alertControllerStyle 弹窗类型
 @param VC 推出控制器
 @param method block方法
 */
+ (void)alertOnlyActionWithTitle:(NSString *)title DetailTitle:(NSString *)detailTitle ActionTitle:(NSString *)actionTitle AlertControllerStyle:(UIAlertControllerStyle)alertControllerStyle PresentBy:(UIViewController *)VC method:(void(^)(void))method;

/**
 系统弹窗
 
 @param title 大标题
 @param detailTitle 详情
 @param alertControllerStyle 弹窗类型
 @param VC 推出控制器
 @param method block方法
 */
+ (void)alertOnlySureActionWithTitle:(NSString *)title DetailTitle:(NSString *)detailTitle AlertControllerStyle:(UIAlertControllerStyle)alertControllerStyle PresentBy:(UIViewController *)VC method:(void(^)(void))method;

/**
 系统弹窗
 
 @param title 大标题
 @param detailTitle 详情
 @param alertControllerStyle 样式
 @param leftTitle 左标题
 @param rightTitle  右标题
 @param haveCancel 是否有取消（）
 @param VC 推出控制器
 @param leftMethod 左边点击block
 @param rightMethod 右边点击block
 */
+ (void)alertWithTitle:(NSString *)title DetailTitle:(NSString *)detailTitle AlertControllerStyle:(UIAlertControllerStyle)alertControllerStyle LeftActionTitile:(NSString *)leftTitle RightActionTitle:(NSString *)rightTitle HaveCancel:(BOOL)haveCancel PresentBy:(UIViewController *)VC LeftMethod:(void(^)(void))leftMethod RigthMethod:(void(^)(void))rightMethod;

/**
 抖动动画
 
 @param layer layer
 */
+ (void)shakeAnimationForLayer:(CALayer *)layer;


/**
 选择媒体
 
 @param fromViewController fromViewController
 @param types types
 @param maxSlectedImagesCount maxSlectedImagesCount
 @param canEdit canEdit
 @param returnPhotosBlock returnPhotosBlock
 @param returnVedioBlock returnVedioBlock
 */
+ (void)showMediaLibraryMangerFromViewController:(UIViewController *)fromViewController Types:(NSArray *)types MaxSlectedImagesCount:(NSInteger)maxSlectedImagesCount CanEdit:(BOOL)canEdit ReturnPhotosBlock:(void(^)(NSArray <UIImage *>*photos))returnPhotosBlock ReturnVedioBlock:(void(^)(NSURL *url,NSString *vedioPath))returnVedioBlock;

/**
 md5加密算法
 
 @param input 内容
 @return 返回值
 */
+ (NSString *)md5:(NSString *)input;

/**
 base64 加密
 
 @param text 文本
 @return 返回值
 */
+ (NSString *)base64StringFromText:(NSString *)text;

/**
 获取版本
 
 @return 返回版本
 */
+ (NSString *)getMatchVersionIsLatest;


/**
 获取当前时间戳
 
 @return 返回值
 */
+(NSString *)getNowTimeTimestamp;

/**
 返回DeviceUUIDString
 
 @return 返回DeviceUUIDString
 */
+ (NSString *)DeviceUUIDString;

/**
 返回富文本
 */
+ (NSMutableAttributedString *)attributedStringWithString1:(NSString *)string1
                                                     Font1:(UIFont *)font1
                                                    Color1:(UIColor *)color1
                                                   String2:(NSString *)string2
                                                     Font2:(UIFont *)font2
                                                    Color2:(UIColor *)color2;

/**
 返回富文本
 */
+ (NSMutableAttributedString *)attributedStringWithString1:(NSString *)string1
                                                     Font1:(UIFont *)font1
                                                    Color1:(UIColor *)color1
                                                   String2:(NSString *)string2
                                                     Font2:(UIFont *)font2
                                                    Color2:(UIColor *)color2
                                                   String3:(NSString *)string3
                                                     Font3:(UIFont *)font3
                                                    Color3:(UIColor *)color3;

//获取View所在的Viewcontroller方法
+ (UIViewController *)viewControllerByView:(UIView *)view;

/**
 返回日期
 
 @param timeString timeString descriptiontimeString
 @return return value descriptiontimeString
 */
+ (NSString *)dataWithTimeIntervalString:(NSString *)timeString;

/**
 返回时间
 
 @param timeString timeString
 @return timeString
 */
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;

//将某个时间转化成 时间戳
+ (long)timeSwitchTimestamp:(NSString *)formatTime;

//将某个时间转化成 时间戳
+ (long)timeSecondSwitchTimestamp:(NSString *)formatTime;

/**
 浮动动画
 
 @param layer layer
 */
+ (void)anmationForLayer:(CALayer *)layer;

/**
 获取截屏图片
 
 @return 截屏图片
 */
+ (UIImage *)shotScreenImage;

/**
 复制文本
 
 @param string 复制文本
 */
+ (void)pasteStringWithString:(NSString *)string;

/**
 保存图片
 
 @param image 图片
 */
+ (void)saveImage:(UIImage *)image;

/**
 正则匹配用户密码9-20位必须包含字母和数字
 
 @param password password
 @return 状态
 */
+ (BOOL)checkPayPassword:(NSString *) password;

/**
 正则匹配用户密码9-20位必须包含字母和数字
 
 @param password password
 @return 状态
 */
+ (BOOL)checkLoginPassword:(NSString *) password;

/**
 base64编码
 
 @param string  string
 @return string
 */
+ (NSString *)base64Encode:(NSString *)string;

/**
 base64解码
 
 @param base64String string
 @return string
 */
+ (NSString *)base64Dencode:(NSString *)base64String;

/**
 *  设置行间距和字间距
 *
 *  @param lineSpace 行间距
 *  @param kern      字间距
 *
 *  @return 富文本
 */
+ (NSMutableAttributedString *)setAttributedStringWithLineSpace:(NSString *) text lineSpace:(CGFloat)lineSpace kern:(CGFloat)kern;

/**
 判断字符串全为空格
 
 @param str 字符串
 @return 返回是否为全空格
 */
+ (BOOL)isEmpty:(NSString *)str;

/*
 view 是要设置渐变字体的控件   bgVIew是view的父视图  colors是渐变的组成颜色  startPoint是渐变开始点 endPoint结束点
 */
+(void)TextGradientview:(UIView *)view bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 设置button渐变背景
 
 @param btn btn
 @param title 标题
 @param cornerRadius 圆角
 */
+ (void)gradientForButton:(UIButton *)btn Title:(NSString *)title CornerRadius:(CGFloat)cornerRadius;


/**
 设置button渐变背景
 
 @param btn btn
 @param title 标题
 @param cornerRadius 圆角
 */
+ (void)gradient2ForButton:(UIButton *)btn Title:(NSString *)title CornerRadius:(CGFloat)cornerRadius;

/**
 发送注册验证码
 
 @param tel 手机号
 @param country_id 地区id
 @param success 返回状态
 */
+ (void)sendEegCodeByTel:(NSString *)tel Country_id:(NSString *)country_id Success:(void(^)(BOOL isSuccess))success;

/**
 发送注册验证码
 
 @param tel 手机号
 @param country_id 地区id
 @param success 返回状态
 */
+ (void)sendEMSCodeByTel:(NSString *)tel Country_id:(NSString *)country_id Success:(void(^)(BOOL isSuccess))success;

/**
 上传图片
 
 @param image 图片
 @param returnImageUrlBlock 返回图片地址
 */
+ (void)uploadImage:(UIImage *)image ReturnImageUrlBlock:(void(^)(NSString * imageUrl))returnImageUrlBlock;

/**
 创建二维码
 
 @param info 信息
 @return 返回图片
 */
+ (UIImage *)createQRWithInfo:(NSString *)info;

/**
 字典转json
 
 @param dic 字典
 @return 返回json字符串
 */
+ (NSString *)jsonDataWithDictionary:(NSDictionary *)dic;

/**
 json转字典
 
 @param jsonString json
 @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
