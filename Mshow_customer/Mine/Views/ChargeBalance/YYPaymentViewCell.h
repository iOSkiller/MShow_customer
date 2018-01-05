//
//  YYChargeBalanceViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYPaymentViewCell : UITableViewCell
@property (nonatomic, copy) void (^selectBlock)(BOOL isSelected);

@end
