//
//  YYDealDetailGoodsServiceFeeView.h
//  Mshow_customer
//
//  Created by YYZ on 2018/1/2.
//  Copyright © 2018年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYGoodsModel;

@interface YYDealDetailGoodsServiceFeeView : UIView
@property (nonatomic, copy) void (^showDamageInfoBlock)(void);
@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, assign) BOOL isShowingDamageInfo;

@end
