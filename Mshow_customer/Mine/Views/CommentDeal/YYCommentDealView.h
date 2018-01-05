//
//  YYCommentDealView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYCommentModel;

@protocol YYCommentDealViewDelegate <NSObject>
- (void)executePickImage:(NSUInteger)imagesCount;
- (void)executeShowImage:(UIImage *)image index:(NSUInteger)index;
- (void)executeSubmietComment:(YYCommentModel *)commentModel;
- (void)executeChangeImage:(NSArray *)imageArray;

@end

@interface YYCommentDealView : UIView
@property (nonatomic, weak) id <YYCommentDealViewDelegate> delegate;
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, strong) YYCommentModel *commentModel;

@end
