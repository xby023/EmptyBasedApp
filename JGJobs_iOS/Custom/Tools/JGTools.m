//
//  JGTools.m
//  JGJobs_iOS
//
//  Created by xby023 on 2018/10/8.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import "JGTools.h"

#import <AVFoundation/AVFoundation.h>
//md5加密
#import<CommonCrypto/CommonDigest.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define  LocalStr_None  @""

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation JGTools


/**
 放回字符串的尺寸
 
 @param text 文本
 @param font 字体
 @param lineSpacing 间距
 @param size 限制尺寸
 @return 返回尺寸
 */
+ (CGSize)boundingALLRectWithText:(NSString*)text Font:(UIFont*)font LineSpacing:(CGFloat)lineSpacing Size:(CGSize)size{
    
    if (!text || text == nil || text.length < 1) {
        return CGSizeZero;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:lineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [text length])];
    CGSize realSize = CGSizeZero;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    CGRect textRect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style} context:nil];
    realSize        = textRect.size;
#else
    realSize        = [txt sizeWithFont:font constrainedToSize:size];
#endif
    realSize.width  = ceilf(realSize.width);
    realSize.height = ceilf(realSize.height);
    return realSize;
}


/**
 渐现加载图片
 
 @param imageView 需要加载图片的imageView
 @param imageUrlString 图片地址
 @param placeHolderImageName 占位图地址
 */
+ (void)setWebImageForImageView:(UIImageView *)imageView ImageUrlString:(NSString *)imageUrlString  PlaceholderImageName:(NSString *)placeHolderImageName{
    
    if (placeHolderImageName.length < 1) {
        placeHolderImageName = @"lsczwt";
    }
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:placeHolderImageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            imageView.image = [UIImage imageNamed:placeHolderImageName];
        }else{
            if (cacheType == SDImageCacheTypeNone || cacheType == SDImageCacheTypeDisk) {
                imageView.image = image;
                imageView.alpha = 0;
                [UIView animateWithDuration:0.5 animations:^{
                    imageView.alpha = 1.f;
                }];
            } else {
                imageView.image = image;
                imageView.alpha = 1.f;
            }
        }
    }];
}


/**
 系统弹窗
 
 @param title 大标题
 @param detailTitle 详情
 @param actionTitle 按钮title
 @param alertControllerStyle 弹窗类型
 @param VC 推出控制器
 @param method block方法
 */
+ (void)alertOnlyActionWithTitle:(NSString *)title DetailTitle:(NSString *)detailTitle ActionTitle:(NSString *)actionTitle AlertControllerStyle:(UIAlertControllerStyle)alertControllerStyle PresentBy:(UIViewController *)VC method:(void(^)(void))method{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:detailTitle preferredStyle:alertControllerStyle];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (method) {
            method();
        }
    }];
    [alert addAction:sure];
    [VC  presentViewController:alert animated:YES completion:nil];
}


/**
 系统弹窗
 
 @param title 大标题
 @param detailTitle 详情
 @param alertControllerStyle 弹窗类型
 @param VC 推出控制器
 @param method block方法
 */
+ (void)alertOnlySureActionWithTitle:(NSString *)title DetailTitle:(NSString *)detailTitle AlertControllerStyle:(UIAlertControllerStyle)alertControllerStyle PresentBy:(UIViewController *)VC method:(void(^)(void))method{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:detailTitle preferredStyle:alertControllerStyle];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (method) {
            method();
        }
    }];
    [alert addAction:sure];
    [VC  presentViewController:alert animated:YES completion:nil];
}


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
+ (void)alertWithTitle:(NSString *)title DetailTitle:(NSString *)detailTitle AlertControllerStyle:(UIAlertControllerStyle)alertControllerStyle LeftActionTitile:(NSString *)leftTitle RightActionTitle:(NSString *)rightTitle HaveCancel:(BOOL)haveCancel PresentBy:(UIViewController *)VC LeftMethod:(void(^)(void))leftMethod RigthMethod:(void(^)(void))rightMethod{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:detailTitle preferredStyle:alertControllerStyle];
    
    UIAlertAction *action1   = [UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (leftMethod) {
            leftMethod();
        }
    }];
    [alert addAction:action1];
    
    UIAlertAction *action2   = [UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (rightMethod) {
            rightMethod();
        }
    }];
    [alert addAction:action2];
    
    if (haveCancel == YES) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        
    }
    
    [VC presentViewController:alert animated:YES completion:nil];
}


/**
 抖动动画
 
 @param layer layer
 */
+ (void)shakeAnimationForLayer:(CALayer *)layer{
    
    CAKeyframeAnimation *shakeAnim = [CAKeyframeAnimation animation];
    
    shakeAnim.keyPath = @"transform.translation.x";
    
    shakeAnim.duration = 0.1;
    
    CGFloat delta = 3;
    
    shakeAnim.values = @[@0 , @(-delta),@0, @(delta), @0];
    
    shakeAnim.repeatCount = 4;
    
    [layer addAnimation:shakeAnim forKey:nil];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

/**
 选择媒体
 
 @param fromViewController fromViewController
 @param types types
 @param maxSlectedImagesCount maxSlectedImagesCount
 @param canEdit canEdit
 @param returnPhotosBlock returnPhotosBlock
 @param returnVedioBlock returnVedioBlock
 */
+ (void)showMediaLibraryMangerFromViewController:(UIViewController *)fromViewController Types:(NSArray *)types MaxSlectedImagesCount:(NSInteger)maxSlectedImagesCount CanEdit:(BOOL)canEdit ReturnPhotosBlock:(void(^)(NSArray <UIImage *>*photos))returnPhotosBlock ReturnVedioBlock:(void(^)(NSURL *url,NSString *vedioPath))returnVedioBlock{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [types enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj integerValue] == XBYMediaLibraryMangerTypePhotoAlbum) {
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[XBYMediaLibraryManger shareManager] openMediaLibraryMangerFromViewController:fromViewController Type:XBYMediaLibraryMangerTypePhotoAlbum MaxSlectedImagesCount:maxSlectedImagesCount CanEdit:canEdit];
            }];
            [alert addAction:sure];
        }
        
        if ([obj integerValue]  == XBYMediaLibraryMangerTypeVideoAlbum) {
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[XBYMediaLibraryManger shareManager] openMediaLibraryMangerFromViewController:fromViewController Type:XBYMediaLibraryMangerTypeVideoAlbum MaxSlectedImagesCount:maxSlectedImagesCount CanEdit:canEdit];
            }];
            [alert addAction:sure];
        }
        
        if ([obj integerValue]  == XBYMediaLibraryMangerTypeTakingPictures) {
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[XBYMediaLibraryManger shareManager] openMediaLibraryMangerFromViewController:fromViewController Type:XBYMediaLibraryMangerTypeTakingPictures MaxSlectedImagesCount:maxSlectedImagesCount CanEdit:canEdit];
            }];
            [alert addAction:sure];
        }
        
        if ([obj integerValue]  == XBYMediaLibraryMangerTypeShootVideo) {
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"拍视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[XBYMediaLibraryManger shareManager] openMediaLibraryMangerFromViewController:fromViewController Type:XBYMediaLibraryMangerTypeShootVideo MaxSlectedImagesCount:maxSlectedImagesCount CanEdit:canEdit];
            }];
            [alert addAction:sure];
        }
        
        if ([obj integerValue]  == XBYMediaLibraryMangerTypeSystemPhotoAlbu) {
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[XBYMediaLibraryManger shareManager] openMediaLibraryMangerFromViewController:fromViewController Type:XBYMediaLibraryMangerTypeSystemPhotoAlbu MaxSlectedImagesCount:maxSlectedImagesCount CanEdit:canEdit];
            }];
            [alert addAction:sure];
        }
    }];
    
    [XBYMediaLibraryManger shareManager].returnPhotosBlock = ^(NSArray<UIImage *> *photos) {
        if (returnPhotosBlock) {
            returnPhotosBlock(photos);
        }
    };
    
    [XBYMediaLibraryManger shareManager].returnVedioPathBlock = ^(NSURL *url, NSString *vedioPath) {
        if (returnVedioBlock) {
            returnVedioBlock(url,vedioPath);
        }
    };
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [fromViewController presentViewController:alert animated:YES completion:nil];
}

//获取当前时间
+(NSString *)getNowTimeTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}



/**
 md5加密算法
 
 @param input 内容
 @return 返回值
 */
+ (NSString *)md5:(NSString *)input{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}



/**
 base64 加密
 
 @param text 文本
 @return 返回值
 */
+ (NSString *)base64StringFromText:(NSString *)text{
    
    if (text && ![text isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY  改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin  改动了此处
        //data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return LocalStr_None;
    }
}

+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}


/**
 获取版本
 
 @return 返回版本
 */
+ (NSString *)getMatchVersionIsLatest{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow(CFBridgingRetain(infoDictionary));
    
    // app版本
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}


/**
 返回DeviceUUIDString
 
 @return 返回DeviceUUIDString
 */
+ (NSString *)DeviceUUIDString{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}


/**
 返回富文本
 */
+ (NSMutableAttributedString *)attributedStringWithString1:(NSString *)string1
                                                     Font1:(UIFont *)font1
                                                    Color1:(UIColor *)color1
                                                   String2:(NSString *)string2
                                                     Font2:(UIFont *)font2
                                                    Color2:(UIColor *)color2{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:string1 attributes:@{NSForegroundColorAttributeName:color1,NSFontAttributeName:font1}];
    [string appendAttributedString:[[NSMutableAttributedString alloc]initWithString:string2 attributes:@{NSForegroundColorAttributeName:color2,NSFontAttributeName:font2}]];
    return string;
}


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
                                                    Color3:(UIColor *)color3{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:string1 attributes:@{NSForegroundColorAttributeName:color1,NSFontAttributeName:font1}];
    [string appendAttributedString:[[NSMutableAttributedString alloc]initWithString:string2 attributes:@{NSForegroundColorAttributeName:color2,NSFontAttributeName:font2}]];
    [string appendAttributedString:[[NSMutableAttributedString alloc]initWithString:string3 attributes:@{NSForegroundColorAttributeName:color3,NSFontAttributeName:font3}]];
    return string;
}


//获取View所在的Viewcontroller方法
+ (UIViewController *)viewControllerByView:(UIView *)view{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}



//将某个时间转化成 时间戳
+ (long)timeSwitchTimestamp:(NSString *)formatTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //指定时间显示样式: HH表示24小时制 hh表示12小时制
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *lastTime = formatTime;
    NSDate *lastDate = [formatter dateFromString:lastTime];
    //以 1970/01/01 GMT为基准，得到lastDate的时间戳
    long firstStamp = [lastDate timeIntervalSince1970];
    return firstStamp;
}


//将某个时间转化成 时间戳
+ (long)timeSecondSwitchTimestamp:(NSString *)formatTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //指定时间显示样式: HH表示24小时制 hh表示12小时制
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *lastTime = formatTime;
    NSDate *lastDate = [formatter dateFromString:lastTime];
    //以 1970/01/01 GMT为基准，得到lastDate的时间戳
    long firstStamp = [lastDate timeIntervalSince1970];
    return firstStamp;
}

/**
 返回时间
 
 @param timeString timeString
 @return timeString
 */
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString{
    //因为时差问题要加8小时 == 28800 sec
    //    NSTimeInterval time = [JGTools timeSwitchTimestamp:timeString];
    NSTimeInterval time = [timeString doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"hh:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

/**
 返回日期
 
 @param timeString timeString descriptiontimeString
 @return return value descriptiontimeString
 */
+ (NSString *)dataWithTimeIntervalString:(NSString *)timeString{
    //因为时差问题要加8小时 == 28800 sec
    //    NSTimeInterval time = [JGTools timeSwitchTimestamp:timeString];
    NSTimeInterval time = [timeString doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}


/**
 浮动动画
 
 @param layer layer
 */
+ (void)anmationForLayer:(CALayer *)layer{
    
    CAKeyframeAnimation *shakeAnim = [CAKeyframeAnimation animation];
    shakeAnim.keyPath = @"transform.translation.y";
    shakeAnim.duration = 6;
    CGFloat delta = 4;
    
    NSInteger index = arc4random() % 3;
    
    //随机延时
    if (index == 0) {
        shakeAnim.beginTime = CACurrentMediaTime() + 0;
    }else if (index == 1){
        shakeAnim.beginTime = CACurrentMediaTime() + 1;
    }else{
        shakeAnim.beginTime = CACurrentMediaTime() + 2;
    }
    
    shakeAnim.values = @[@0 , @(-delta),@0, @(delta), @0];
    shakeAnim.repeatCount = MAXFLOAT;
    //    shakeAnim.removedOnCompletion = NO;
    //    shakeAnim.fillMode = kCAFillModeForwards;
    [layer addAnimation:shakeAnim forKey:nil];
    
}

/**
 获取截屏图片
 
 @return 截屏图片
 */
+ (UIImage *)shotScreenImage{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImagePNGRepresentation(image);
    return [UIImage imageWithData:imageData];
}


/**
 设置button渐变背景
 
 @param btn btn
 @param title 标题
 @param cornerRadius 圆角
 */
+ (void)gradientForButton:(UIButton *)btn Title:(NSString *)title CornerRadius:(CGFloat)cornerRadius {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithString:@"#5A49D7"].CGColor, (__bridge id)[UIColor colorWithString:@"#2C47CE"].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0,0,btn.frame.size.width,btn.frame.size.height);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = cornerRadius;
    btn.titleLabel.font = [UIFont pingFangRegularFontOfSize:16];
    btn.layer.masksToBounds = YES;
    [btn.layer insertSublayer:gradientLayer atIndex:0];
}

/**
 设置button渐变背景
 
 @param btn btn
 @param title 标题
 @param cornerRadius 圆角
 */
+ (void)gradient2ForButton:(UIButton *)btn Title:(NSString *)title CornerRadius:(CGFloat)cornerRadius{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithString:@"#3F75EF"].CGColor, (__bridge id)[UIColor colorWithString:@"#5168F4"].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0,0,btn.frame.size.width,btn.frame.size.height);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont pingFangRegularFontOfSize:16];
    //    btn.layer.masksToBounds = YES;
    [btn.layer insertSublayer:gradientLayer atIndex:0];
    
    gradientLayer.cornerRadius = cornerRadius;
    gradientLayer.shadowColor = [UIColor colorWithString:@"#3F75EF"].CGColor;
    gradientLayer.shadowOffset = CGSizeMake(0, 4);
    gradientLayer.shadowRadius = 8;
    gradientLayer.shadowOpacity = 0.5;
}

/**
 复制文本
 
 @param string 复制文本
 */
+ (void)pasteStringWithString:(NSString *)string{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = string;
    [SVProgressHUD showSuccessWithStatus:@"复制成功"];
}

/**
 正则匹配用户密码9-20位必须包含字母和数字
 
 @param password password
 @return 状态
 */
+ (BOOL)checkPayPassword:(NSString *) password
{
    //    ^(?:(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[^A-Za-z0-9])).{9,100}$
    //    @"^(?:(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])).{9,100}$"
    //    @"^(?:(?=.*[a-zA-Z])(?=.*[0-9])).{9,20}$"
    NSString *pattern = @"^(?:(?=.*[a-zA-Z])(?=.*[0-9])).{9,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

/**
 正则匹配用户密码9-20位必须包含字母和数字
 
 @param password password
 @return 状态
 */
+ (BOOL)checkLoginPassword:(NSString *) password
{
    NSString *pattern = @"^(?:(?=.*[a-zA-Z])(?=.*[0-9])).{9,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}


/**
 base64编码
 
 @param string  string
 @return string
 */
+ (NSString *)base64Encode:(NSString *)string{
    //先将string转换成data
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    
    return baseString;
}


/**
 base64解码
 
 @param base64String string
 @return string
 */
+ (NSString *)base64Dencode:(NSString *)base64String{
    //NSData *base64data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}


/**
 *  设置行间距和字间距
 *
 *  @param lineSpace 行间距
 *  @param kern      字间距
 *
 *  @return 富文本
 */
+ (NSMutableAttributedString *)setAttributedStringWithLineSpace:(NSString *) text lineSpace:(CGFloat)lineSpace kern:(CGFloat)kern {
    NSMutableParagraphStyle * paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    paragraphStyle.lineSpacing= lineSpace;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineSpacing = lineSpace; //设置行间距
    //    paragraphStyle.firstLineHeadIndent = 30.0;//设置第一行缩进
    NSDictionary*attriDict =@{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(kern)};
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attriDict];
    
    return attributedString;
}


/**
 判断字符串全为空格
 
 @param str 字符串
 @return 返回是否为全空格
 */
+ (BOOL)isEmpty:(NSString *)str{
    if(!str) {
        return true;
    }else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if([trimedString length] == 0) {
            return true;
            
        }else {
            return false;
        }
    }
}

/*
 view 是要设置渐变字体的控件   bgVIew是view的父视图  colors是渐变的组成颜色  startPoint是渐变开始点 endPoint结束点
 */
+(void)TextGradientview:(UIView *)view bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    
    CAGradientLayer* gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = view.frame;
    gradientLayer1.colors = colors;
    gradientLayer1.startPoint =startPoint;
    gradientLayer1.endPoint = endPoint;
    [bgVIew.layer addSublayer:gradientLayer1];
    gradientLayer1.mask = view.layer;
    view.frame = gradientLayer1.bounds;
}


/**
 发送注册验证码
 
 @param tel 手机号
 @param country_id 地区id
 @param success 返回状态
 */
+ (void)sendEegCodeByTel:(NSString *)tel Country_id:(NSString *)country_id Success:(void(^)(BOOL isSuccess))success{
    [WebTools webTools_PostRequest:@"" Params:@{@"tel":tel,@"country_id":country_id} Success:^(id responseData) {
        NSInteger code = [responseData[@"code"] integerValue];
        if (code == 200) {
            if (success) {
                success(YES);
            }
        }else{
            if (success) {
                success(NO);
            }
        }
    } Failure:^(NSError *error) {
        if (success) {
            success(NO);
        }
    }];
}

/**
 发送注册验证码
 
 @param tel 手机号
 @param country_id 地区id
 @param success 返回状态
 */
+ (void)sendEMSCodeByTel:(NSString *)tel Country_id:(NSString *)country_id Success:(void(^)(BOOL isSuccess))success{
    [WebTools webTools_PostRequest:@"" Params:@{@"tel":tel,@"country_id":country_id} Success:^(id responseData) {
        NSInteger code = [responseData[@"code"] integerValue];
        if (code == 200) {
            if (success) {
                success(YES);
            }
        }else{
            if (success) {
                success(NO);
            }
        }
    } Failure:^(NSError *error) {
        if (success) {
            success(NO);
        }
    }];
}

/**
 上传图片
 
 @param image 图片
 @param returnImageUrlBlock 返回图片地址
 */
+ (void)uploadImage:(UIImage *)image ReturnImageUrlBlock:(void(^)(NSString * imageUrl))returnImageUrlBlock{
    [WebTools webTools_UploadHeaderImageAfterModify:@"" Params:@{} Image:image ImageKey:@"file" Success:^(id responseData) {
        if ([responseData[@"code"] integerValue] == 200) {
            if (returnImageUrlBlock) {
                returnImageUrlBlock(responseData[@"data"][@"src"]);
            }
        }else{
            [SVProgressHUD showInfoWithStatus:responseData[@"msg"]];
        }
    } Failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"图片上传失败"];
    }];
}

/**
 保存图片
 
 @param image 图片
 */
+ (void)saveImage:(UIImage *)image{
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

+ (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}



/**
 创建二维码
 
 @param info 信息
 @return 返回图片
 */
+ (UIImage *)createQRWithInfo:(NSString *)info{
    
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //过滤器恢复默认
    [filter setDefaults];
    //给过滤器添加数据
    NSString *string = info;
    //将NSString格式转化成NSData格式
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKeyPath:@"inputMessage"];
    //获取二维码过滤器生成的二维码
    CIImage *image = [filter outputImage];
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(300/CGRectGetWidth(extent), 300/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


/**
 字典转json
 
 @param dic 字典
 @return 返回json字符串
 */
+ (NSString *)jsonDataWithDictionary:(NSDictionary *)dic{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
    
}


/**
 json转字典
 
 @param jsonString json
 @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



@end
