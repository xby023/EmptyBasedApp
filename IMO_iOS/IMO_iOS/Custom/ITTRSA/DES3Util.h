//
//  DES3Util.h
//  AES加解密
//
//  Created by ZhangLiang on 15/10/28.
//  Copyright © 2015年 wja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3Util : NSObject

+ (NSString *)AES128Encrypt:(NSString *)plainText;
+ (NSString *)AES256Encrypt:(NSString *)plainText;

+ (NSString *)AES128Decrypt:(NSString *)encryptText;
+ (NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key iv:(NSString *)iv;

+(NSString *)AES128Decrypt:(NSString *)encryptText withKey:(NSString *)key;
@end
