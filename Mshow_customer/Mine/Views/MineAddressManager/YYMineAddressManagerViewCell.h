//
//  YYMineAddressManagerViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/16.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYAddressModel;

@interface YYMineAddressManagerViewCell : UITableViewCell

@property (nonatomic, strong) YYAddressModel *addressModel;
@property (nonatomic, copy) void (^editeActionBlock)(YYAddressModel *addressModel);
@property (nonatomic, copy) void (^deleteActionBlock)(YYAddressModel *addressModel);
@property (nonatomic, copy) void (^changeDefaultBlock)(YYAddressModel *addressModel);

@end
