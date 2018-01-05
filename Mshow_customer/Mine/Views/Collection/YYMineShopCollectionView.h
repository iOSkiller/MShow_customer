//
//  YYMineShopCollectionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;
@class YYShopModel;

@protocol YYMineShopCollectionViewDelegate <NSObject>
- (void)executeShowGoods:(YYGoodsModel *)goodsModel;
- (void)executeGotoShop:(YYShopModel *)shopModel;
- (void)executeDeleteShops:(NSArray *)shopsArray;

@end

@interface YYMineShopCollectionView : UIView
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, assign) BOOL isEditing;

@property (nonatomic, weak) id <YYMineShopCollectionViewDelegate> delegate;
- (void)deleteSelectedShops;

@end
