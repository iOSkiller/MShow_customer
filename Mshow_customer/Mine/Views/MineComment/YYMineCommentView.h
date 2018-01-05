//
//  YYMineCommentView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/16.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYCommentModel;

@protocol YYMineCommentViewDelegate <NSObject>
- (void)executeShowComments:(YYCommentModel *)commentModel;
- (void)executeEditeComment:(YYCommentModel *)commentModel;

@end

@interface YYMineCommentView : UIView
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, weak) id <YYMineCommentViewDelegate> delegate;

@end
