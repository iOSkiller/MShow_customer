//
//  YYMineGoodsCollectionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;

@protocol YYMineGoodsCollectionViewDelegate <NSObject>
- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel;
- (void)executeDeleteGoods:(YYGoodsModel *)goodsModel;
- (void)executeDeleteGoodsArray:(NSArray *)goodsArray;

@end

@interface YYMineGoodsCollectionView : UIView
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, weak) id <YYMineGoodsCollectionViewDelegate> delegate;
- (void)deleteSelectGoods;

@end
