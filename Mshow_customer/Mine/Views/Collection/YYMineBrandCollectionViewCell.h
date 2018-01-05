//
//  YYMineBrandCollectionViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYBrandModel;

@interface YYMineBrandCollectionViewCell : UITableViewCell
@property (nonatomic, strong) YYBrandModel *brandModel;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, copy) void (^selectBrandBlock)(YYBrandModel *brandModel, BOOL isSelected);

@end
