//
//  YYSelectWashShopViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/2.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYShopModel;

typedef NS_ENUM(NSInteger, YYSelectWashShopViewCellType) {
    YYSelectWashShopViewCellTypeAddress,
    YYSelectWashShopViewCellTypeHistoryShop,
    YYSelectWashShopViewCellTypeNearbyShop,
    
};

@interface YYSelectWashShopViewCell : UITableViewCell
@property (nonatomic, assign) YYSelectWashShopViewCellType type;
@property (nonatomic, strong) YYShopModel *shopModel;

@end
