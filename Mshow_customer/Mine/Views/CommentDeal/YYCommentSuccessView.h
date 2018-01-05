//
//  YYCommentSuccessView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/21.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;

@protocol YYCommentSuccessViewDelegate <NSObject>
- (void)executeShowMyComment;
- (void)executeShowGoods:(YYGoodsModel *)goodsModel;

@end

@interface YYCommentSuccessView : UIView
@property (nonatomic, copy) NSArray *likeArray;
@property (nonatomic, weak) id <YYCommentSuccessViewDelegate> delegate;

@end
