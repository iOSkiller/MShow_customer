//
//  YYPaySuccessViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYDealModel;

typedef NS_ENUM(NSInteger, YYPaySuccessViewCellType) {
    YYPaySuccessViewCellTypeAddress,
    YYPaySuccessViewCellTypePrice,
    YYPaySuccessViewCellTypeFuction,
};

@interface YYPaySuccessViewCell : UITableViewCell
@property (nonatomic, assign) YYPaySuccessViewCellType type;
@property (nonatomic, strong) YYDealModel *dealModel;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) void (^dealActionBlock)(void);
@property (nonatomic, copy) void (^backActionBlock)(void);

@end
