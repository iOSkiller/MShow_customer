//
//  YYLoginViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYLoginViewCellType) {
    YYLoginViewCellTypePhone,
    YYLoginViewCellTypeCode,
    YYLoginViewCellTypePassword,
};

@interface YYLoginViewCell : UITableViewCell
@property (nonatomic, assign) YYLoginViewCellType type;
@property (nonatomic, copy) void (^phoneTextFieldBlock)(NSString *phone);
@property (nonatomic, copy) void (^codeTextFieldBlock)(NSString *code);
@property (nonatomic, copy) void (^passwordTextFieldBlock)(NSString *password);

@end
