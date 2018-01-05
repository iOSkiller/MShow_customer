//
//  YYSubscribeReturnGoodsViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYSubscribeReturnGoodsViewCellType) {
    YYSubscribeReturnGoodsViewCellTypeDate,
    YYSubscribeReturnGoodsViewCellTypeAddress,
};

@interface YYSubscribeReturnGoodsViewCell : UITableViewCell
@property (nonatomic, assign) YYSubscribeReturnGoodsViewCellType type;
@property (nonatomic, copy) NSString *title;

@end
