//
//  YYSelectReturnRecieveTypeViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/3.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYSelectReturnRecieveTypeViewCell : UITableViewCell
@property (nonatomic, copy) void (^selectBlock)(BOOL isSelected);
@property (nonatomic, weak) UILabel *label;

@end
