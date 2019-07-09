//
//  XBYMediaLibraryManger.m
//  JGTicket
//
//  Created by 许必杨 on 2018/3/20.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import "XBYMediaLibraryManger.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface XBYMediaLibraryManger()<CBPickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic ,assign) XBYMediaLibraryMangerType type;

@property (nonatomic ,strong) UIViewController *fromViewController;

@property (nonatomic ,assign) NSInteger maxSlectedImagesCount;

@property (nonatomic ,assign,getter = isCanEdit) BOOL canEdit;

@end

static XBYMediaLibraryManger *manager = nil;

@implementation XBYMediaLibraryManger

+ (XBYMediaLibraryManger *)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XBYMediaLibraryManger alloc]init];
    });
    return manager;
}

/**
 打开媒体
 
 @param fromViewController 传入来源控制器
 @param type type
 @param maxSlectedImagesCount maxSlectedImagesCount
 @param canEdit canEdit
 */
- (void)openMediaLibraryMangerFromViewController:(UIViewController *)fromViewController Type:(XBYMediaLibraryMangerType)type MaxSlectedImagesCount:(NSInteger)maxSlectedImagesCount CanEdit:(BOOL)canEdit{
    self.type = type;
    self.fromViewController = fromViewController;
    self.maxSlectedImagesCount = maxSlectedImagesCount;
    self.canEdit = canEdit;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    switch (type) {
        case XBYMediaLibraryMangerTypePhotoAlbum:
            
            [self openPhotoAlbum];
            
            break;
        case XBYMediaLibraryMangerTypeVideoAlbum:
            
            [self openVideoAlbum];
            
            break;
        case XBYMediaLibraryMangerTypeTakingPictures:
            
            [self takingPictures];
            
            break;
        case XBYMediaLibraryMangerTypeShootVideo:
            
            [self shootVideo];
        case XBYMediaLibraryMangerTypeSystemPhotoAlbu:
            [self openSystemAlbum];
            
            break;
        default:
            break;
    }
}

- (void)openSystemAlbum{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
    }
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc]init];
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //mediaTypes默认只有图片
    imagePickerVC.mediaTypes = @[(NSString*)kUTTypeImage,(NSString*)kUTTypeMovie];
    imagePickerVC.allowsEditing = self.canEdit;
    imagePickerVC.delegate = self;
    [self.fromViewController presentViewController:imagePickerVC animated:YES completion:^{
        imagePickerVC.title = @"选择视频";
    }];
}

#pragma mark ====================================相册===================================

/**
 相册
 */
- (void)openPhotoAlbum{
    CBPhotoSelecterController *controller = [[CBPhotoSelecterController alloc] initWithDelegate:self];
    controller.columnNumber = 4;
    controller.maxSlectedImagesCount = self.maxSlectedImagesCount;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.fromViewController presentViewController:nav animated:YES completion:nil];
}


/**
 点击使用 代理
 
 @param pickerController pickerController
 @param sourceAsset 返回数据
 */
- (void)photoSelecterController:(CBPhotoSelecterController *)pickerController sourceAsset:(NSArray *)sourceAsset {
    //保存图片
     __block NSMutableArray *allPics = [NSMutableArray array];
    
    [sourceAsset enumerateObjectsUsingBlock:^(PHAsset *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //获取 PHImageManager
        PHImageManager *imageManager   = [PHImageManager defaultManager];
        
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc]init];
        //同步获得图片, 只会返回1张图片
        options.synchronous = 1;
        
        //是否要原图 根据Size来确定
        [imageManager requestImageForAsset:obj targetSize:CGSizeMake(obj.pixelWidth, obj.pixelHeight) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [allPics addObject:result];
        }];
    }];
    
    if (self.returnPhotosBlock) {
        self.returnPhotosBlock(allPics);
    }
}

//取消代理方法
- (void)photoSelecterDidCancelWithController:(CBPhotoSelecterController *)pickerController {
    
}

#pragma mark ====================================视频===================================

/**
 视频
 */
- (void)openVideoAlbum{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc]init];
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //mediaTypes默认只有图片
    imagePickerVC.mediaTypes = @[(NSString*)kUTTypeMovie];
    imagePickerVC.allowsEditing = self.canEdit;
    imagePickerVC.delegate = self;
    [self.fromViewController presentViewController:imagePickerVC animated:YES completion:^{
        imagePickerVC.title = @"选择视频";
    }];
}

#pragma mark ====================================拍照===================================

/**
 拍照
 */
- (void)takingPictures{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc]init];
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerVC.allowsEditing = self.canEdit;
    imagePickerVC.delegate = self;
    [self.fromViewController presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark ====================================拍视频===================================

/**
 拍视频
 */
- (void)shootVideo{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc]init];
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    //#import <MobileCoreServices/MobileCoreServices.h> 包含:(NSString*)kUTTypeImage,(NSString*)kUTTypeMovie
    imagePickerVC.mediaTypes = @[(NSString*)kUTTypeMovie];
    imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    imagePickerVC.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    imagePickerVC.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    imagePickerVC.allowsEditing = self.canEdit;
    imagePickerVC.delegate = self;
    [self.fromViewController presentViewController:imagePickerVC animated:YES completion:nil];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {//如果是拍照
        UIImage *image;
        //如果允许编辑则获得编辑后的照片，否则获取原始照片
        if (picker.allowsEditing) {
            image=[info objectForKey:UIImagePickerControllerEditedImage];//获取编辑后的照片
        }else{
            image=[info objectForKey:UIImagePickerControllerOriginalImage];//获取原始照片
        }
        
        if (image) {
            
            NSLog(@"image --- %@",image);
            
            if (self.returnPhotosBlock) {
                self.returnPhotosBlock(@[image]);
            }
        }
    }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){//如果是录制视频
        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];
        //返回视频路径
        NSString *vedioPath=[url path];
        NSLog(@"vedioPath --- %@",vedioPath);
        
        if (self.returnVedioPathBlock) {
            self.returnVedioPathBlock(url, vedioPath);
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [UIView animateWithDuration:1 delay:1 options:1|2 animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}



@end
