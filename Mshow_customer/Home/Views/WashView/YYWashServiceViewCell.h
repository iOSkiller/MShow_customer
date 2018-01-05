//
//  YYWashServiceViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYWashModel;

@interface YYWashServiceViewCell : UITableViewCell
@property (nonatomic, copy) void (^didSelectCountBlock)(NSString *count, YYWashModel *model);
@property (nonatomic, strong) YYWashModel *washModel;

@end
