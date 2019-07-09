//
//  WebTools.m
//  LSPlanet
//
//  Created by 许必杨 on 2018/4/27.
//  Copyright © 2018年 com.InZiqi. All rights reserved.
//

#import "WebTools.h"
#import "LYRSA.h"
#import "DES3Util.h"
#import "NSData+AES128.h"

@implementation WebTools

/**
 get请求
 
 @param url 请求地址
 @param params 参数
 @param success 成功回调数据
 @param failure -1009:无网络
 */
+ (void)webTools_GetRequest:(NSString*)url Params:(id)params Success:(void(^)(id responseData))success Failure:(void(^)(NSError *error))failure{
    
    NSLog(@"\nJGTicket --- 请求地址:%@", url);
    NSLog(@"\nJGTicket --- 请求参数:%@", params);
    NSDate *startDate = [NSDate date];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //判断是否登录
    //[manager.requestSerializer setValue:[BizPayManager shareManager].token forHTTPHeaderField:@"api-token"];
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"\nJGTicket --111-- 请求耗时:%f ------- URL:%@", [[NSDate date] timeIntervalSinceDate:startDate],url);
        
        //1.获取sk
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = response.allHeaderFields;
        NSString *aesKey = [allHeaders objectForKey:@"sk"];
        NSLog(@"sk --- %@" ,aesKey);
        
        //2.判读sk是否存在 来是否解码
        if (aesKey && (aesKey.length > 0) && [responseObject isKindOfClass:[NSData class]]){
            //有sk
            
            //3.获取公钥
            NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public" ofType:@"key"];
            NSData *publickeydata = [NSData dataWithContentsOfFile:publicKeyPath];
            NSString *ke = [[NSString alloc]initWithData:publickeydata encoding:NSUTF8StringEncoding];
            
            //4.获取对称加密公钥
            NSString *aesKsy2 = [LYRSA decryptString:aesKey publicKey:ke];
            
            //5.解密数据
            NSString *jieguo = [DES3Util AES128Decrypt:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] key:aesKsy2 iv:aesKsy2];
            
            if (jieguo == nil) {
                NSLog(@"\n 返回数据 json解析失败");
                return;
            }
            
            //6.转化为json数据
            NSString *jieguo2 = [jieguo stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
            NSData *jsonData = [jieguo2 dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            //7.判断是否json转化成功
            if(err){
                success(nil);
                NSLog(@"\nJ 返回数据 - json解析失败：%@",err);
            }else{
                success(dic);
                NSLog(@"\nJ 返回数据 - json解析成功：%@",dic);
            }
        }else{
            //无sk
            //3.转为json
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            
            //4.返回数据
            if(err){
                success(nil);
                NSLog(@"\nJ 返回数据 - json解析失败：%@",err);
            }else{
                success(dic);
            }
        
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"\nJGTicket --- 请求耗时:%f ------- URL:%@", [[NSDate date] timeIntervalSinceDate:startDate],url);
        NSLog(@"\nJGTicket --- 错误信息:%@", error.localizedDescription);
        NSLog(@"\nJGTicket --- 错误信息:%@", error);
    }];
}

/**
 post请求
 
 @param url 请求地址
 @param params 参数
 @param success 成功回调数据
 @param failure -1009:无网络
 */
+ (void)webTools_PostRequest:(NSString*)url Params:(id)params Success:(void(^)(id responseData))success Failure:(void(^)(NSError *error))failure{
    
    NSLog(@"\nJGTicket --- 请求地址:%@", url);
    NSLog(@"\nJGTicket --- 请求参数:%@", params);
    
    NSDate *startDate = [NSDate date];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.requestSerializer setValue:[BizPayManager shareManager].token forHTTPHeaderField:@"api-token"];
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSLog(@"\nJGTicket --111-- 请求耗时:%f ------- URL:%@", [[NSDate date] timeIntervalSinceDate:startDate],url);
        
        //1.获取sk
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = response.allHeaderFields;
        NSString *aesKey = [allHeaders objectForKey:@"sk"];
        NSLog(@"sk --- %@" ,aesKey);
        
        //2.判读sk是否存在 来是否解码
        if (aesKey && (aesKey.length > 0) && [responseObject isKindOfClass:[NSData class]]){
            //有sk
        
            //3.获取公钥
            NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public" ofType:@"key"];
            NSData *publickeydata = [NSData dataWithContentsOfFile:publicKeyPath];
            NSString *ke = [[NSString alloc]initWithData:publickeydata encoding:NSUTF8StringEncoding];
            
            //4.获取对称加密公钥
            
            NSString *aesKsy2 = [LYRSA decryptString:aesKey publicKey:ke];
            
            //5.解密数据
            NSString *jieguo = [DES3Util AES128Decrypt:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] key:aesKsy2 iv:aesKsy2];
            
            if (jieguo == nil) {
                NSLog(@"\n 返回数据 json解析失败");
                return;
            }
            
            //6.转化为json数据
            NSString *jieguo2 = [jieguo stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
            NSData *jsonData = [jieguo2 dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            //7.判断是否json转化成功
            if(err){
                success(nil);
                NSLog(@"\nJ 返回数据 - json解析失败：%@",err);
            }else{
                success(dic);
                NSLog(@"\nJ 返回数据 - json解析成功：%@",dic);
            }
        }else{
            //无sk
            //3.转为json
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            //4.返回数据
            if(err){
                success(nil);
                NSLog(@"\nJ 返回数据 - json解析失败：%@",err);
            }else{
                success(dic);
                NSLog(@"\nJGTicket --- 返回数据:%@",dic);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"\nJGTicket --- 请求耗时:%f ------- URL:%@", [[NSDate date] timeIntervalSinceDate:startDate],url);
        NSLog(@"\nJGTicket --- 错误信息:%@", error.localizedDescription);
    }];
}

/**
 上传图片
 
 @param url 请求地址
 @param params 参数
 @param image 上传图片
 @param imageKey 文件Key
 @param success 成功回调数据
 @param failure -1009:无网络
 */
+ (void)webTools_UploadHeaderImage:(NSString *)url Params:(id)params Image:(UIImage *)image ImageKey:(NSString *)imageKey Success:(void(^)(id responseData))success Failure:(void(^)(NSError *error))failure{
    NSLog(@"\nJGTicket --- 请求地址:%@", url);
    NSLog(@"\nJGTicket --- 请求参数:%@", params);
    
    NSDate *startDate = [NSDate date];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.requestSerializer setValue:[BizPayManager shareManager].token forHTTPHeaderField:@"api-token"];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *headerImageData = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:headerImageData name:imageKey fileName:[NSString stringWithFormat:@"%@.png", params[@"imgFile"]] mimeType:@"image/jpg/png/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\nJGTicket --111-- 请求耗时:%f ------- URL:%@", [[NSDate date] timeIntervalSinceDate:startDate],url);
        
        //1.获取sk
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = response.allHeaderFields;
        NSString *aesKey = [allHeaders objectForKey:@"sk"];
        NSLog(@"sk --- %@" ,aesKey);
        
        //2.判读sk是否存在 来是否解码
        if (aesKey && (aesKey.length > 0) && [responseObject isKindOfClass:[NSData class]]){
            //有sk
            
            
            //3.获取公钥
            NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public" ofType:@"key"];
            NSData *publickeydata = [NSData dataWithContentsOfFile:publicKeyPath];
            NSString *ke = [[NSString alloc]initWithData:publickeydata encoding:NSUTF8StringEncoding];
            
            //4.获取对称加密公钥
            NSString *aesKsy2 = [LYRSA decryptString:aesKey publicKey:ke];
            
            //5.解密数据
            NSString *jieguo = [DES3Util AES128Decrypt:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] key:aesKsy2 iv:aesKsy2];
            
            if (jieguo == nil) {
                NSLog(@"\n 返回数据 json解析失败");
                return;
            }
            
            //6.转化为json数据
            NSString *jieguo2 = [jieguo stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
            NSData *jsonData = [jieguo2 dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            //7.判断是否json转化成功
            if(err){
                success(nil);
                NSLog(@"\nJ 返回数据 - json解析失败：%@",err);
            }else{
                success(dic);
                NSLog(@"\nJ 返回数据 - json解析成功：%@",dic);
            }
        }else{
            //无sk
            //3.转为json
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            //4.返回数据
            if(err){
                success(nil);
                NSLog(@"\nJ 返回数据 - json解析失败：%@",err);
            }else{
                success(dic);
                NSLog(@"\nJGTicket --- 返回数据:%@",dic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"\nJGTicket --- 请求耗时:%f ------- URL:%@", [[NSDate date] timeIntervalSinceDate:startDate],url);
        NSLog(@"\nJGTicket --- 错误信息:%@", error.localizedDescription);
    }];
}

/**
 上传图片
 
 @param url 请求地址
 @param params 参数
 @param image 上传图片
 @param imageKey 文件Key
 @param success 成功回调数据
 @param failure -1009:无网络
 */
+ (void)webTools_UploadHeaderImageAfterModify:(NSString *)url Params:(id)params Image:(UIImage *)image ImageKey:(NSString *)imageKey Success:(void(^)(id responseData))success Failure:(void(^)(NSError *error))failure{
    NSLog(@"\nJGTicket --- 请求地址:%@", url);
    NSLog(@"\nJGTicket --- 请求参数:%@", params);
    
    NSDate *startDate = [NSDate date];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.requestSerializer setValue:[BizPayManager shareManager].token forHTTPHeaderField:@"api-token"];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (image) {
            NSData *headerImageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:headerImageData name:imageKey fileName:[NSString stringWithFormat:@"%@.png", params[@"imgFile"]] mimeType:@"image/jpg/png/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"\nJGTicket --111-- 请求耗时:%f ------- URL:%@", [[NSDate date] timeIntervalSinceDate:startDate],url);
        
        //1.获取sk
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = response.allHeaderFields;
        NSString *aesKey = [allHeaders objectForKey:@"sk"];
        NSLog(@"sk --- %@" ,aesKey);
        
        //2.判读sk是否存在 来是否解码
        if (aesKey && (aesKey.length > 0) && [responseObject isKindOfClass:[NSData class]]){
            //3.获取公钥
            NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public" ofType:@"key"];
            NSData *publickeydata = [NSData dataWithContentsOfFile:publicKeyPath];
            NSString *ke = [[NSString alloc]initWithData:publickeydata encoding:NSUTF8StringEncoding];
            //4.获取对称加密公钥
            NSString *aesKsy2 = [LYRSA decryptString:aesKey publicKey:ke];
            //5.解密数据
            NSString *jieguo = [DES3Util AES128Decrypt:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] key:aesKsy2 iv:aesKsy2];
            if (jieguo == nil) {
                NSLog(@"\n 返回数据 json解析失败");
                return;
            }
            //6.转化为json数据
            NSString *jieguo2 = [jieguo stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
            NSData *jsonData = [jieguo2 dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            //7.判断是否json转化成功
            if(err){
                success(nil);
                NSLog(@"\nJ 返回数据 - json解析失败：%@",err);
            }else{
                success(dic);
                NSLog(@"\nJ 返回数据 - json解析成功：%@",dic);
            }
            
        }else{
            //无sk
            //3.转为json
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            
            //4.返回数据
            if(err){
                success(nil);
                NSLog(@"\nJ 返回数据 - json解析失败：%@",err);
            }else{
                success(dic);
                NSLog(@"\nJGTicket --- 返回数据:%@",dic);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"\nJGTicket --- 请求耗时:%f ------- URL:%@", [[NSDate date] timeIntervalSinceDate:startDate],url);
        NSLog(@"\nJGTicket --- 错误信息:%@", error.localizedDescription);
    }];
}

/**
 上传多张图片
 
 @param url 请求地址
 @param params 参数
 @param images 上传图片数组
 @param success 成功回调数据
 @param failure -1009:无网络
 */
+ (void)webTools_UploadHeaderImage:(NSString *)url Params:(id)params Images:(NSArray *)images Success:(void(^)(id responseData))success Failure:(void(^)(NSError *error))failure{
    
    NSLog(@"\nJGTicket --- 请求地址:%@", url);
    NSLog(@"\nJGTicket --- 请求参数:%@", params);
    
    NSDate *startDate = [NSDate date];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if ([BizPayManager shareManager].isLogin) {
        [manager.requestSerializer setValue:[BizPayManager shareManager].token forHTTPHeaderField:@"api-token"];
    }
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (images.count > 0) {
            
            int i = 0;
            //根据当前系统时间生成图片名称
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:date];
            
            for (UIImage *image in images) {
                i++;
                NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateString,i];
                NSData *imageData = [NSData data];
                imageData = UIImageJPEGRepresentation(image, 0.3f);
                [formData appendPartWithFileData:imageData name:fileName fileName:fileName mimeType:@"image/jpg/png/jpeg"];
                NSLog(@"fileName----%@",fileName);
            }
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\nJGTicket --111-- 请求耗时:%f ------- URL:%@", [[NSDate date] timeIntervalSinceDate:startDate],url);
        
        //1.获取sk
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = response.allHeaderFields;
        NSString *aesKey = [allHeaders objectForKey:@"sk"];
        NSLog(@"sk --- %@" ,aesKey);
        
        //2.判读sk是否存在 来是否解码
        if (aesKey && (aesKey.length > 0) && [responseObject isKindOfClass:[NSData class]]){
            //有sk
            
            //3.获取公钥
            NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public" ofType:@"key"];
            NSData *publickeydata = [NSData dataWithContentsOfFile:publicKeyPath];
            NSString *ke = [[NSString alloc]initWithData:publickeydata encoding:NSUTF8StringEncoding];
            
            //4.获取对称加密公钥
            NSString *aesKsy2 = [LYRSA decryptString:aesKey publicKey:ke];
        
            //5.解密数据
            NSString *jieguo = [DES3Util AES128Decrypt:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] key:aesKsy2 iv:aesKsy2];
            
            if (jieguo == nil) {
                NSLog(@"\n 返回数据 json解析失败");
                return;
            }
            
            //6.转化为json数据
            NSString *jieguo2 = [jieguo stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
            NSData *jsonData = [jieguo2 dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            //7.判断是否json转化成功
            if(err){
                success(nil);
                NSLog(@"\nJ 返回数据 - json解析失败：%@",err);
            }else{
                success(dic);
                NSLog(@"\nJ 返回数据 - json解析成功：%@",dic);
            }
            
        }else{
            //无sk
            //3.转为json
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            
            //4.返回数据
            if(err){
                success(nil);
                NSLog(@"\nJ 返回数据 - json解析失败：%@",err);
            }else{
                success(dic);
                NSLog(@"\nJGTicket --- 返回数据:%@",dic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"\nJGTicket --- 请求耗时:%f ------- URL:%@", [[NSDate date] timeIntervalSinceDate:startDate],url);
        NSLog(@"\nJGTicket --- 错误信息:%@", error.localizedDescription);
    }];
}


/**
 网络状态监测
 
 @param currentStatus 网络状态回调
 */
+ (void)determineTheNetworkStatus:(void(^)(AFNetworkReachabilityStatus currentStatus))currentStatus{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                // 未知网络
                currentStatus(AFNetworkReachabilityStatusUnknown);
                NSLog(@"\nJGTicket --- 未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                // 没有网络(断网)
                currentStatus(AFNetworkReachabilityStatusNotReachable);
                NSLog(@"\nJGTicket --- 没有网络(断网)");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                // 手机自带网络
                currentStatus(AFNetworkReachabilityStatusReachableViaWWAN);
                NSLog(@"\nJGTicket --- 手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                // WIFI
                currentStatus(AFNetworkReachabilityStatusReachableViaWiFi);
                NSLog(@"\nJGTicket --- WIFI");
                break;
        }
    }];
    // 3.开始监控
    [manager startMonitoring];
}



@end
