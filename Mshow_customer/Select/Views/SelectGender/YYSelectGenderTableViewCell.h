//
//  YYSelectGenderTableViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;

@interface YYSelectGenderTableViewCell : UITableViewCell
@property (nonatomic, strong) YYGoodsModel *goodsModel;
@property (nonatomic, copy) void (^showShopDetailBlock)(NSString *shopID);

@end
