//
//  YYMineCollectedGoodsTableView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/15.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYGoodsModel;

@protocol YYMineCollectedGoodsTableViewDelegate <NSObject>

- (void)tableViewShowGoodsDetail:(YYGoodsModel *)goodsModel;
- (void)tableViewShowShopDetail:(NSString *)shopID;
- (void)tableViewDeleteGoods:(NSArray *)goodsArray;
- (void)tableViewShouldRemoveGoods:(YYGoodsModel *)goodsModel indexPath:(NSIndexPath *)indexPath;
@end

@interface YYMineCollectedGoodsTableView : UIView
@property (nonatomic, weak) id <YYMineCollectedGoodsTableViewDelegate> delegate;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, assign) BOOL isEditing;
- (void)deleteSelectedGoods;
- (void)deleteGoods:(YYGoodsModel *)goodsModel indexPath:(NSIndexPath *)indexPath;

@end
