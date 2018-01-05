//
//  YYSettleWashDealViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;
@class YYAddressModel;

typedef NS_ENUM(NSInteger, YYSettleWashDealViewCellType) {
    YYSettleWashDealViewCellTypeDefault,
    YYSettleWashDealViewCellTypeSameAddressButton,
    YYSettleWashDealViewCellTypeTakeClothAdrress,
    YYSettleWashDealViewCellTypeShippingAdrress,
    YYSettleWashDealViewCellTypeGoods,
    YYSettleWashDealViewCellTypeFee,        //费用
    YYSettleWashDealViewCellTypeCoupon,     //优惠券
    YYSettleWashDealViewCellTypeBonusPoints,//积分
    
};

@interface YYSettleWashDealViewCell : UITableViewCell
@property (nonatomic, assign) YYSettleWashDealViewCellType type;
@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, strong) YYAddressModel *addressModel;
@property (nonatomic, copy) NSString *bonusPoints;
@property (nonatomic, copy) void (^selectSameAddrssBlock)(BOOL isSelected);

@end
