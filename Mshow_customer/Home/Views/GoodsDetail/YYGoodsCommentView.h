//
//  YYGoodsCommentView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/7.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYCommentModel;

@interface YYGoodsCommentView : UIView
@property (nonatomic, copy) void (^upvoteBlock)(BOOL isUpvoted);
@property (nonatomic, strong) YYCommentModel *commentModel;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) BOOL canUpvote;

@end
