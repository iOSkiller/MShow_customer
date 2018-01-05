//
//  YYShopGoodsKindViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/29.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYShopGoodsKindModel;

@interface YYShopGoodsKindViewCell : UITableViewCell
@property (nonatomic, copy) void (^didSelectKindBlock)(YYShopGoodsKindModel *kindModel);
@property (nonatomic, copy) void (^showAllKindsBlock)(YYShopGoodsKindModel *typeModel);
@property (nonatomic, strong) YYShopGoodsKindModel *kindModel;

@end
