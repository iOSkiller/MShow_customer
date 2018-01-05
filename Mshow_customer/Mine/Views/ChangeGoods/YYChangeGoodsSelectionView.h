//
//  YYChangeGoodsSelectionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/22.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYChangeReturnModel;

typedef NS_ENUM(NSInteger, YYChangeGoodsSelectionViewType) {
    YYChangeGoodsSelectionViewTypeReason,
    YYChangeGoodsSelectionViewTypeKind,
};

@interface YYChangeGoodsSelectionView : UIView
@property (nonatomic, copy) NSArray *reasonArray;
@property (nonatomic, copy) NSArray *typeArray;
@property (nonatomic, assign) YYChangeGoodsSelectionViewType type;
@property (nonatomic, copy) void (^didSelectChangeTypeBlock)(YYChangeReturnModel *typeModel);
@property (nonatomic, copy) void (^didSelectChangeReasonBlock)(YYChangeReturnModel *reasonModel);
- (void)hide;
- (void)show;

@end
