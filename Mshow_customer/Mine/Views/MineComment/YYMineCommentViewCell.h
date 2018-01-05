//
//  YYMineCommentViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/16.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYCommentModel;
@class YYGoodsModel;

@interface YYMineCommentViewCell : UITableViewCell
@property (nonatomic, strong) YYCommentModel *commentModel;
@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, copy) void (^editeActionBlock)(YYCommentModel *commentModel);
@property (nonatomic, copy) void (^showCommentBlock)(YYCommentModel *commentModel);

@end
