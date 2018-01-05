//
//  YYSearchSelectionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYSearchModel;

typedef NS_ENUM(NSInteger, YYSearchSelectionViewType) {
    YYSearchSelectionViewTypeHistory,
    YYSearchSelectionViewTypeHot,
};

@interface YYSearchSelectionView : UIView
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, assign) YYSearchSelectionViewType type;
@property (nonatomic, copy) void (^didSelectBlock)(YYSearchModel *searchModel);
@property (nonatomic, copy) void (^deleteActionBlock)(void);

@end
