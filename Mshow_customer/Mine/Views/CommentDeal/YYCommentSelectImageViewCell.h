//
//  YYCommentSelectImageViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYCommentSelectImageViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL isCamera;
@property (nonatomic, copy) void (^deleteActionBlock)(UIImage *image, NSIndexPath *indexPath);

@end
