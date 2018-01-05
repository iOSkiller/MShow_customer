//
//  YYReturnChangeDealViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYReturnChangeDealViewCellType) {
    YYReturnChangeDealViewCellTypeSum,
    YYReturnChangeDealViewCellTypeFlow,
    YYReturnChangeDealViewCellTypeReason,
};

@interface YYReturnChangeDealViewCell : UITableViewCell
@property (nonatomic, assign) YYReturnChangeDealViewCellType type;

@end
