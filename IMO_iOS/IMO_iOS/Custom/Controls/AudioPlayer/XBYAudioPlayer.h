//
//  XBYAudioPlayer.h
//  LSPlanet
//
//  Created by 许必杨 on 2018/4/28.
//  Copyright © 2018年 com.InZiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBYAudioPlayer : NSObject


/**
 播放音乐

 @param fileName 文件名字
 @param type 文件类型
 */
+ (void)playAudioFileName:(NSString *)fileName ofType:(NSString *)type;

@end
