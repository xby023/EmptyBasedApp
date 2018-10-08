//
//  XBYMediaLibraryManger.h
//  JGTicket
//
//  Created by 许必杨 on 2018/3/20.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,XBYMediaLibraryMangerType){
    XBYMediaLibraryMangerTypePhotoAlbum  = 0,//图片相册
    XBYMediaLibraryMangerTypeVideoAlbum  = 1,//视频相册
    XBYMediaLibraryMangerTypeTakingPictures = 2,//拍照片
    XBYMediaLibraryMangerTypeShootVideo  = 3,//拍视频
    XBYMediaLibraryMangerTypeSystemPhotoAlbu = 4//拍视频
};

typedef void(^ReturnPhotosBlock)(NSArray <UIImage *>*photos);
typedef void(^ReturnVedioPathBlock)(NSURL *url,NSString *vedioPath);

@interface XBYMediaLibraryManger : NSObject

@property (nonatomic ,copy) ReturnPhotosBlock returnPhotosBlock;

@property (nonatomic ,copy) ReturnVedioPathBlock returnVedioPathBlock;

/**
 单利

 @return 返回对象
 */
+ (XBYMediaLibraryManger *)shareManager;

/**
 打开媒体

 @param fromViewController 传入来源控制器
 @param type type
 */
- (void)openMediaLibraryMangerFromViewController:(UIViewController *)fromViewController Type:(XBYMediaLibraryMangerType)type MaxSlectedImagesCount:(NSInteger)maxSlectedImagesCount CanEdit:(BOOL)canEdit;

@end
