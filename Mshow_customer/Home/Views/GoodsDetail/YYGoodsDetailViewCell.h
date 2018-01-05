//
//  YYGoodsDetailViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/7.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYCommentModel;

typedef NS_ENUM(NSInteger, YYGoodsDetailViewCellType) {
    YYGoodsDetailViewCellTypeDefault,
    YYGoodsDetailViewCellTypeName,
    YYGoodsDetailViewCellTypeInfo,
    YYGoodsDetailViewCellTypeSelectSizeColor,
    YYGoodsDetailViewCellTypeComment,
    YYGoodsDetailViewCellTypeCenterLabel,
};

@interface YYGoodsDetailViewCell : UITableViewCell
@property (nonatomic, assign) YYGoodsDetailViewCellType type;
@property (nonatomic, assign) CGFloat commentContentHeight;
@property (nonatomic, strong) YYCommentModel *commentModel;
- (void)setName:(NSString *)name currentPrice:(NSString *)currentPrice originalPrice:(NSString *)originalPrice;
@end
