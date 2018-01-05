//
//  YYTakePhotoHandle.m
//  DDFood
//
//  Created by YZ Y on 16/7/9.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#define AppRootView  ([[[[[UIApplication sharedApplication] delegate] window] rootViewController] view])

#define AppRootViewController  ([[[[UIApplication sharedApplication] delegate] window] rootViewController])

#import "YYTakePhotoHandle.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation YYTakePhotoHandle

{
    NSUInteger sourceType;
}

static YYTakePhotoHandle *_sharedTakePhotoHandle = nil;
+ (YYTakePhotoHandle *)sharedTakePhotoHandle
{
    if (!_sharedTakePhotoHandle) {
        [NSThread sleepForTimeInterval:0.2];
        _sharedTakePhotoHandle = [[YYTakePhotoHandle alloc]init];
    }
    return _sharedTakePhotoHandle;
}

+ (void)getPicture:(sendPictureBlock)block
{
   [YYTakePhotoHandle getPictureEditable:YES block:block];
}

+ (void)getPictureEditable:(BOOL)editable block:(sendPictureBlock)block
{
    YYTakePhotoHandle *tP = [YYTakePhotoHandle sharedTakePhotoHandle];
    tP.isEditable = editable;
    tP.sPictureBlock = block;
    
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:tP cancelButtonTitle:@"取消"  destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册中选择", nil];
        //        sheet.destructiveButtonIndex=2;
    }
    else
    {
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:tP cancelButtonTitle:@"取消"  destructiveButtonTitle:nil  otherButtonTitles:@"从手机相册中选择", nil];
        
    }
    
    sheet.tag = 2550;
    
    [sheet showInView:AppRootView];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 2550) {
        //        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        
        
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            //          NSLog(@"--------照相------%ld--------------",buttonIndex);
            switch (buttonIndex) {
                case 0: //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1: //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
                    break;
            }
        }
        else {
            if (buttonIndex == 1) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
        }
        
        imagePickerController.sourceType = sourceType;
        imagePickerController.allowsEditing = _isEditable;
        //AppRootViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [AppRootViewController presentViewController:imagePickerController animated:YES completion:nil];
        
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    YYTakePhotoHandle *photoHandle = [YYTakePhotoHandle sharedTakePhotoHandle];
    
    UIImage *image;
    if (_isEditable) {
        //裁剪图片
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        //相机原图
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    UIImageOrientation imageOrientation = image.imageOrientation;
    if(imageOrientation != UIImageOrientationUp)
    {
        // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
        // 以下为调整图片角度的部分
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 调整图片角度完毕
    }
    
    NSData * mageDate = UIImageJPEGRepresentation(image, 0.00001);
    
    UIImage *newImage = [[UIImage alloc] initWithData:mageDate];
    if (_sPictureBlock != nil) {
        [photoHandle sPictureBlock](newImage);
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)circleImage:(UIImage *)image withParam:(CGFloat)inset {
    
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //边框线
    CGContextSetLineWidth(context,0);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

- (UIImage *)imageToTransparent:(UIImage*) image

{
    
    // 分配内存
    
    const int imageWidth = image.size.width;
    
    const int imageHeight = image.size.height;
    
    size_t bytesPerRow = imageWidth * 4;
    
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    
    
    // 创建context
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    
    
    // 遍历像素
    
    int pixelNum = imageWidth * imageHeight;
    
    uint32_t* pCurPtr = rgbImageBuf;
    
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
        
    {
        
        //        //去除白色...将0xFFFFFF00换成其它颜色也可以替换其他颜色。
        
        //        if ((*pCurPtr & 0xFFFFFF00) >= 0xffffff00) {
        
        //
        
        //            uint8_t* ptr = (uint8_t*)pCurPtr;
        
        //            ptr[0] = 0;
        
        //        }
        
        //接近白色
        
        //将像素点转成子节数组来表示---第一个表示透明度即ARGB这种表示方式。ptr[0]:透明度,ptr[1]:R,ptr[2]:G,ptr[3]:B
        
        //分别取出RGB值后。进行判断需不需要设成透明。
        
        uint8_t *ptr = (uint8_t*)pCurPtr;
        
        if (ptr[1] > 240 && ptr[2] > 240 && ptr[3] > 240) {
            
            //当RGB值都大于240则比较接近白色的都将透明度设为0.-----即接近白色的都设置为透明。某些白色背景具有杂质就会去不干净，用这个方法可以去干净
            
            ptr[0] = 0;
            
        }
        
    }
    
    // 将内存转成image
    
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);
    
    
    
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight,8, 32, bytesPerRow, colorSpace,
                                        
                                        kCGImageAlphaLast |kCGBitmapByteOrder32Little, dataProvider,
                                        
                                        NULL, true,kCGRenderingIntentDefault);
    
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    
    CGImageRelease(imageRef);
    
    CGContextRelease(context);
    
    CGColorSpaceRelease(colorSpace);
    
    return resultUIImage;
    
}

+ (BOOL)checkAuthStatus
{
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    //相机许可
    //读取设备授权状态
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        //NSString *errorStr = @"应用相机权限受限,请在设置中启用";
        return NO;
    }
    //相册许可
    /*
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
        return NO;
    }
    */
    return YES;
}

#pragma mark - 摄像头和相册相关的公共类
// 判断设备是否有摄像头
- (BOOL)isCameraAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

// 前面的摄像头是否可用
- (BOOL)isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

// 后面的摄像头是否可用
- (BOOL)isRearCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}


@end
