//
//  YYMineEditeViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYMineAddressEditeViewCellType) {
    YYMineAddressEditeViewCellTypeName,
    YYMineAddressEditeViewCellTypePhone,
    YYMineAddressEditeViewCellTypeGender,
    YYMineAddressEditeViewCellTypeCity,
    YYMineAddressEditeViewCellTypeDetailAddress,
};

@interface YYMineAddressEditeViewCell : UITableViewCell
@property (nonatomic, assign) YYMineAddressEditeViewCellType type;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) void (^nameBlock)(NSString *name);
@property (nonatomic, copy) void (^phoneBlock)(NSString *phone);
@property (nonatomic, copy) void (^detailAddressBlock)(NSString *detailAddress);

@end
