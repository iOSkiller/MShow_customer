//
//  YYCommentSelectImageView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYCommentSelectImageView : UIView
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, copy) void (^pickImageBlock)(NSInteger imagesCount);
@property (nonatomic, copy) void (^showImageBlock)(UIImage *image, NSUInteger index);
@property (nonatomic, copy) void (^didChangeImage)(NSArray *imageArray);
@property (nonatomic, assign) NSUInteger maxImagesCount;

@end
