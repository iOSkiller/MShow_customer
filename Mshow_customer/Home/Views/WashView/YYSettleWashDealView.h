//
//  YYSettleWashDealView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYDealModel;
@class YYAddressModel;

@protocol YYSettleWashDealViewDelegate <NSObject>
- (void)executeSelectWashShop;
- (void)executeSelectShipAddress;
- (void)executeSelectTakeAddress;

@end

@interface YYSettleWashDealView : UIView
@property (nonatomic, strong) YYDealModel *dealModel;
@property (nonatomic, weak) id <YYSettleWashDealViewDelegate> delegate;
@property (nonatomic, copy) NSString *shop;
@property (nonatomic, strong) YYAddressModel *shipAddressModel;
@property (nonatomic, strong) YYAddressModel *takeAddressModel;
@end
