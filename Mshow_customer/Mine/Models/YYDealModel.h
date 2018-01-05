//
//  YYDealModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/9.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYShopModel;

@interface YYDealModel : NSObject
@property (nonatomic, strong) YYShopModel *shopModel;
@property (nonatomic, copy) NSArray *shopsArray;
@property (nonatomic, copy) NSArray *goodsArray;
@property (nonatomic, copy) NSString *dealID;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *delivery_fee;
/**订单支付ID*/
@property (nonatomic, copy) NSString *orderPayId;
/**订单ID*/
@property (nonatomic, copy) NSString *orderId;
/**订单商铺ID*/
@property (nonatomic, copy) NSString *orderShopId;
/**订单支付编号 用于查询和支付宝支付*/
@property (nonatomic, copy) NSString *payOrderNumber;
/**订单支付总价*/
@property (nonatomic, copy) NSString *payOrderMoney;
/**交易号*/
@property (nonatomic, copy) NSString *transactionNo;
/**优惠金额*/
@property (nonatomic, copy) NSString *discountAmount;
/**实际支付*/
@property (nonatomic, copy) NSString *actualDelivery;
/**收货人*/
@property (nonatomic, copy) NSString *shiippingName;
/**收货人手机*/
@property (nonatomic, copy) NSString *shippingMobile;
/**收货地址*/
@property (nonatomic, copy) NSString *shippingAddress;
/**收货时间*/
@property (nonatomic, copy) NSString *deliveryTime;
/**使用积分（订单扣除的积分）*/
@property (nonatomic, copy) NSString *useIntegral;
/**购买备注*/
@property (nonatomic, copy) NSString *buyRemark;
/**支付方式,0支付宝，1微信，2银联*/
@property (nonatomic, copy) NSString *payment;
/**支付状态,0未支付、1已支付、2取消*/
@property (nonatomic, copy) NSString *payStatus;
/**记录状态*/
@property (nonatomic, copy) NSString *recordState;

@property (nonatomic, assign) YYDealStatusType statusType;

@property (nonatomic, copy) NSString *returnChangeStatus;


+ (NSArray *)testBuyDataArrary;
+ (NSArray *)testTryDataArray;

+ (instancetype)testDeal;
+ (instancetype)testWashDeal;

@end
