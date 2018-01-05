//
//  YYImagePickerViewController.h
//  DDFood
//
//  Created by YZ Y on 16/10/8.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYBaseViewController.h"

@interface YYImagePickerViewController : YYBaseViewController
@property (nonatomic, assign) NSInteger imagesCount;
@property (nonatomic, copy) void (^finishSelectImageBlock)(NSArray *imageArray, NSArray *assetArray);
@property (nonatomic, assign) NSUInteger maxImagesCount;

@end
