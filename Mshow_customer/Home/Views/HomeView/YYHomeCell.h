//
//  YYHomeCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;
@class YYShopModel;

@interface YYHomeCell : UITableViewCell
@property (nonatomic, assign) YYHomeCellType type;
@property (nonatomic, copy) void (^selectItemBlock)(YYGoodsModel *goodsModel, NSInteger index);
@property (nonatomic, copy) void (^showMorBlock)(YYHomeCellType type);
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) YYShopModel *shopModel;
@property (nonatomic, weak) UILabel *label;

@end
