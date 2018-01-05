//
//  YYDealChildView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/10.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYDealModel;

@protocol YYDealCildViewDelegate <NSObject>
/**取消订单*/
- (void)executeCancelDeal:(YYDealModel *)dealModel;
/**支付订单*/
- (void)executePayDeal:(YYDealModel *)dealModel;
/**催单*/
- (void)executeRemindDeal:(YYDealModel *)dealModel;
/**确认收货*/
- (void)executeConfirmReceipt:(YYDealModel *)dealModel;
/**购买衣服*/
- (void)executeBuyGoods:(YYDealModel *)dealModel;
/**自还*/
- (void)executeReturnBySelf:(YYDealModel *)dealModel;
/**下单归还*/
- (void)executeReturnGoods:(YYDealModel *)dealModel;
/**删除订单*/
- (void)executeDeletDeal:(YYDealModel *)dealModel;
/**待评价*/
- (void)executeCommentDeal:(YYDealModel *)dealModel;
/**物流详情*/
- (void)executeShowDealDelivery:(YYDealModel *)dealModel;
/**订单详情*/
- (void)executeShowDealDetail:(YYDealModel *)dealModel;
/**确认订单*/
- (void)executeSubmitDeal:(YYDealModel *)dealModel;
/**申诉订单*/
- (void)executeAppealDeal:(YYDealModel *)dealModel;

@end

@interface YYDealChildView : UIView
@property (nonatomic, weak) id <YYDealCildViewDelegate> delegate;
@property (nonatomic, assign) YYDealStatusType type;
@property (nonatomic, copy) NSArray *dataArray;
- (void)deleteDeal:(YYDealModel *)dealModel;
- (void)updateDealStatus:(YYDealModel *)dealModel;

@end
