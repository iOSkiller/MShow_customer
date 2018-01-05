//
//  YYHistoryTableViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/15.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYGoodsModel;

typedef NS_ENUM(NSInteger, YYHistoryTableViewCellType) {
    YYHistoryTableViewCellTypeFunction,
    YYHistoryTableViewCellTypeGoods,
};

@interface YYHistoryTableViewCell : UITableViewCell
@property (nonatomic, assign) YYHistoryTableViewCellType type;
@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, assign) BOOL isAllSelected;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) void (^showShopDetailBlock)(NSString *shopID);
@property (nonatomic, copy) void (^selectAllGoodsBlock)(BOOL isSelected);
@property (nonatomic, copy) void (^selectGoodsBlock)(YYGoodsModel *goodsModel);

@end
