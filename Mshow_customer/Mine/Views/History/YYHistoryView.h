//
//  YYHistoryView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYGoodsModel;

@protocol YYHistoryViewDelegate <NSObject>
- (void)executeLikeGoods:(YYGoodsModel *)goodsModel isLike:(BOOL)isLike;
- (void)executeSelectGoods:(NSArray *)selectGoodsArray;
- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel;

@end

@interface YYHistoryView : UIView
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, weak) id <YYHistoryViewDelegate> delegate;
@property (nonatomic, assign) BOOL isEditing;
- (void)deleteSelectedGoods;

@end
