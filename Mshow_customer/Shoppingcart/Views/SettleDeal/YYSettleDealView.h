//
//  YYSettleDealView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYDealModel;
@class YYShopModel;
@class YYAddressModel;

@protocol YYSettleDealViewDelegate <NSObject>
- (void)executeSelectDuration:(YYShopModel *)shopModel indexPath:(NSIndexPath *)indexPath;
- (void)executeSelectDateForRecieve;
- (void)executeSelectAddress;

@end

@interface YYSettleDealView : UIView
@property (nonatomic, copy) NSArray *goodsArray;
@property (nonatomic, weak) id <YYSettleDealViewDelegate> delegate;
@property (nonatomic, copy) NSString *dateForRecieve;
@property (nonatomic, strong) YYAddressModel *addressModel;

- (void)updateDuration:(NSString *)duration shop:(YYShopModel *)shopModel indexPath:(NSIndexPath *)indexPath;

@end
