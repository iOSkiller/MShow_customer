//
//  YYSelectGenderView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;

@protocol YYSelectGenderViewDelegate <NSObject>

- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel;

- (void)collectionViewLoadMoreData;

@optional
- (void)collectionViewDidScrollToIndex:(NSUInteger)index;
- (void)executeLikeGoods:(YYGoodsModel *)goodsModel isLike:(BOOL)isLike;

@end

@interface YYSelectGenderView : UIView
@property (nonatomic, weak) id <YYSelectGenderViewDelegate> delegate;
@property (nonatomic, copy) NSArray *dataArray;
- (void)scrollToIndex:(NSUInteger)index;
- (void)endRefresh;

@end
