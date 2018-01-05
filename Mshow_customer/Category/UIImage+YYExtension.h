//
//  UIImage+YYExtension.h
//  DDFood
//
//  Created by YZ Y on 16/8/1.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YYExtension)
+ (UIImage *)imageCompressWithSimple:(UIImage*)image scale:(float)scale;
/**
 *将图片缩放到指定的CGSize大小
 * UIImage image 原始的图片
 * CGSize size 要缩放到的大小
 */
+ (UIImage *)imageCompressWithSimple:(UIImage*)image scaledToSize:(CGSize)size;
/**
 *根据给定的size的宽高比自动缩放原图片、自动判断截取位置,进行图片截取
 * UIImage image 原始的图片
 * CGSize size 截取图片的size
 */
+ (UIImage *)clipImage:(UIImage *)image toRect:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
