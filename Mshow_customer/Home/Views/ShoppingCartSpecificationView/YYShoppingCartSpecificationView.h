//
//  YYShoppingCartSpecificationView.h
//  DDFood
//
//  Created by YZ Y on 16/11/28.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#define goodsSpecHeight RELATIVE_WIDTH(922)

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYShoppingCartAnimationType) {
    YYShoppingCartAnimationTypeRight,
    YYShoppingCartAnimationTypeBottom,
    
};

typedef NS_ENUM(NSInteger, YYShoppingCartSpecificationViewType) {
    YYShoppingCartSpecificationViewTypeNormal,
    YYShoppingCartSpecificationViewTypePromotion,
};

@class YYGoodsModel;

@protocol YYShoppingCartSpecificationViewDelegate <NSObject>

- (void)addGoodsToCart:(NSInteger)totalCount goodsModel:(YYGoodsModel *)goodsModel;
- (void)gotoMakeDeal:(YYGoodsModel *)goodsModel isImmediatedBuy:(BOOL)isImmediatedBuy;

@optional
- (void)didSelectSpec:(YYGoodsModel *)goodsModel;
- (void)isHide;

@end

@interface YYShoppingCartSpecificationView : UIView
@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) BOOL isImmediatedBuy;
@property (nonatomic, assign) YYShoppingCartAnimationType animationType;
@property (nonatomic, assign) YYShoppingCartSpecificationViewType style;
@property (nonatomic, copy) NSString *selectedSpec;
@property (nonatomic, weak) id <YYShoppingCartSpecificationViewDelegate> delegate;

- (void)show;

@end
