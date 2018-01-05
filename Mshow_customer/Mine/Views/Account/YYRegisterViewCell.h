//
//  YYRegisterViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYRegisterViewCellType) {
    YYRegisterViewCellTypePhone,
    YYRegisterViewCellTypeCode,
    YYRegisterViewCellTypePassword,
    YYRegisterViewCellTypeRePassword,
    YYRegisterViewCellTypeNewPassword,
};

@interface YYRegisterViewCell : UITableViewCell
@property (nonatomic, assign) YYRegisterViewCellType type;
@property (nonatomic, copy) void (^phoneTextFieldBlock)(NSString *phone);
@property (nonatomic, copy) void (^codeTextFieldBlock)(NSString *code);
@property (nonatomic, copy) void (^passwordTextFieldBlock)(NSString *password);
@property (nonatomic, copy) void (^repasswordTextFiedBlock)(NSString *repassword);
@property (nonatomic, copy) void (^sendPhoneCodeBlock)(void);
- (void)beginTimer;
@end
