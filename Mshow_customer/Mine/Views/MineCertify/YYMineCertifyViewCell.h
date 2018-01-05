//
//  YYMineCertifyViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYMineCertifyViewCellType) {
    YYMineCertifyViewCellTypeName,
    YYMineCertifyViewCellTypeCode,
    YYMineCertifyViewCellTypeInfo,
};

@interface YYMineCertifyViewCell : UITableViewCell
@property (nonatomic, assign) YYMineCertifyViewCellType type;
@property (nonatomic, copy) void (^nameBlock)(NSString *name);
@property (nonatomic, copy) void (^codeBlock)(NSString *code);

@end
