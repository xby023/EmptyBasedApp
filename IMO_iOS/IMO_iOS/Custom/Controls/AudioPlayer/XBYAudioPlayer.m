//
//  XBYAudioPlayer.m
//  LSPlanet
//
//  Created by 许必杨 on 2018/4/28.
//  Copyright © 2018年 com.InZiqi. All rights reserved.
//

#import "XBYAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
@interface XBYAudioPlayer() <AVAudioPlayerDelegate>
{
    AVAudioPlayer *_audioPlayer;
    AVPlayer *_avPlayer;
}

@end

@implementation XBYAudioPlayer

+ (void)playAudioFileName:(NSString *)fileName ofType:(NSString *)type{
    
    //查找本地音乐文件路径
    NSString *audioFile=[[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
    //1.获得系统声音ID
    SystemSoundID soundID=0;
    /**
     * inFileUrl: 音频文件url
     * outSystemSoundID:声 id(此函数会将音效文件加入到系统音频服务中并返回一个长整形ID) */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    //如果需要在播放完之后执行某些操作,可以调用如下方法注册一个播放完成回调函数 AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    //2.播放音频
    AudioServicesPlaySystemSound(soundID);//播放音效
    // AudioServicesPlayAlertSound(soundID);//播放音效并震动

}

@end
