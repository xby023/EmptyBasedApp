//
//  WebTools.h
//  LSPlanet
//
//  Created by 许必杨 on 2018/4/27.
//  Copyright © 2018年 com.InZiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebTools : NSObject


/**
 get请求
 
 @param url 请求地址
 @param params 参数
 @param success 成功回调数据
 @param failure -1009:无网络
 */
+ (void)webTools_GetRequest:(NSString*)url Params:(id)params Success:(void(^)(id responseData))success Failure:(void(^)(NSError *error))failure;


/**
 post请求
 
 @param url 请求地址
 @param params 参数
 @param success 成功回调数据
 @param failure -1009:无网络
 */
+ (void)webTools_PostRequest:(NSString*)url Params:(id)params Success:(void(^)(id responseData))success Failure:(void(^)(NSError *error))failure;


/**
 上传图片
 
 @param url 请求地址
 @param params 参数
 @param image 上传图片
 @param imageKey 文件Key
 @param success 成功回调数据
 @param failure -1009:无网络
 */
+ (void)webTools_UploadHeaderImage:(NSString *)url Params:(id)params Image:(UIImage *)image ImageKey:(NSString *)imageKey Success:(void(^)(id responseData))success Failure:(void(^)(NSError *error))failure;


/**
 上传图片
 
 @param url 请求地址
 @param params 参数
 @param image 上传图片
 @param imageKey 文件Key
 @param success 成功回调数据
 @param failure -1009:无网络
 */
+ (void)webTools_UploadHeaderImageAfterModify:(NSString *)url Params:(id)params Image:(UIImage *)image ImageKey:(NSString *)imageKey Success:(void(^)(id responseData))success Failure:(void(^)(NSError *error))failure;


/**
 上传多张图片
 
 @param url 请求地址
 @param params 参数
 @param images 上传图片数组
 @param success 成功回调数据
 @param failure -1009:无网络
 */
+ (void)webTools_UploadHeaderImage:(NSString *)url Params:(id)params Images:(NSArray *)images Success:(void(^)(id responseData))success Failure:(void(^)(NSError *error))failure;


/**
 网络状态监测
 
 @param currentStatus 网络状态回调
 */
+ (void)determineTheNetworkStatus:(void(^)(AFNetworkReachabilityStatus currentStatus))currentStatus;



@end
