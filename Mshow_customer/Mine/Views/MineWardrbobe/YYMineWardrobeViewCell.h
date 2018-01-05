//
//  YYMineWardrobeViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/9.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYShopModel;
@class YYGoodsModel;
@class YYDealModel;

typedef NS_ENUM(NSInteger, YYMineWardrobeViewCellType) {
    YYMineWardrobeViewCellTypeTitle,
    YYMineWardrobeViewCellTypeTitleWithFuction,
    YYMineWardrobeViewCellTypeTitleWithState,
    YYMineWardrobeViewCellTypeGoodsFunction,
    YYMineWardrobeViewCellTypeDealFunction,
    YYMineWardrobeViewCellTypeTriedGoods,
    YYMineWardrobeViewCellTypeBoughtGoods,
    YYMineWardrobeViewCellTypeWaitForSubmit,
    YYMineWardrobeViewCellTypeReturnChangeGoodsDealFunction,
};

@interface YYMineWardrobeViewCell : UITableViewCell
@property (nonatomic, assign) YYMineWardrobeViewCellType type;
@property (nonatomic, assign) YYDealStatusType dealStatusType;
@property (nonatomic, strong) YYShopModel *shopModel;
@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, strong) YYDealModel *dealModel;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) void (^actionBlock)(YYMineFunctionType functionType, YYGoodsModel *goodsModel, YYDealModel *dealModel, YYShopModel *shopModel);

@end
