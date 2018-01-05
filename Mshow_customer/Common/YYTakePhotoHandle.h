//
//  YYTakePhotoHandle.h
//  DDFood
//
//  Created by YZ Y on 16/7/9.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <Foundation/Foundation.h>

//使用block 返回值
typedef void (^sendPictureBlock)(UIImage *image);

@interface YYTakePhotoHandle : NSObject <UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,copy)sendPictureBlock sPictureBlock;
@property (nonatomic,assign)BOOL isEditable;

+ (YYTakePhotoHandle *)sharedTakePhotoHandle;

+ (void)getPicture:(sendPictureBlock)block;

+ (void)getPictureEditable:(BOOL)editable block:(sendPictureBlock)block;
//相机权限
+ (BOOL)checkAuthStatus;
//相机可用性
- (BOOL)isCameraAvailable;
- (BOOL)isFrontCameraAvailable;
- (BOOL)isRearCameraAvailable;
@end
