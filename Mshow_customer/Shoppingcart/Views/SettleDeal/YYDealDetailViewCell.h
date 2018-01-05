//
//  YYDealDetailViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYGoodsModel;
@class YYAddressModel;

typedef NS_ENUM(NSInteger, YYDealDetailViewCellType) {
    YYDealDetailViewCellTypeShop,
    YYDealDetailViewCellTypeGoods,
    YYDealDetailViewCellTypeGoodsWithFee,
    YYDealDetailViewCellTypeAddress,
    YYDealDetailViewCellTypeDealInfo,
    YYDealDetailViewCellTypeDealStatus,
    YYDealDetailViewCellTypeDeliverInfo,
    YYDealDetailViewCellTypeSelectCoupon,
    YYDealDetailViewCellTypeSelectDuration,
    YYDealDetailViewCellTypeSelectRecieveDate,
    YYDealDetailViewCellTypeBonusPoints,
    YYDealDetailViewCellTypeReturnFee,
    YYDealDetailViewCellTypeServiceFee,
    YYDealDetailViewCellTypeCallShop,
};

@interface YYDealDetailViewCell : UITableViewCell
@property (nonatomic, assign) YYDealDetailViewCellType type;
@property (nonatomic, assign) BOOL isShowingDamageInfo;
@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, strong) YYAddressModel *addressModel;
@property (nonatomic, copy) NSString *bonusPoints;
@property (nonatomic, copy) void (^showGoodsDamageDetailBlock)(YYGoodsModel *goodsModel);
@property (nonatomic, copy) void (^useBonusPointsBlock)(NSString *bonusPoints);

- (void)setDealStatus:(YYDealStatusType)dealStatus date:(NSString *)date dealCode:(NSString *)dealCode;

@end
