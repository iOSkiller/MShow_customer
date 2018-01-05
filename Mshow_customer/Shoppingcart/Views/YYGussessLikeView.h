//
//  YYGusessLikeView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/2.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;

@interface YYGussessLikeView : UIView
@property (nonatomic, copy) NSArray *likeGoodsArray;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, copy) void (^getContentHeight)(CGFloat height);
@property (nonatomic, copy) void (^showGoodsBlock)(YYGoodsModel *goodsModel);

@end
