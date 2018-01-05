//
//  YYSearchViewCell.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYSearchModel;

typedef NS_ENUM(NSInteger, YYSearchViewCellType) {
    YYSearchViewCellTypeDefault,
    YYSearchViewCellTypeHotSearch,
    YYSearchViewCellTypeHistorySearch,
    
};

@interface YYSearchViewCell : UITableViewCell
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, assign) YYSearchViewCellType type;
@property (nonatomic, copy) void (^didSelectSearchResultBlock)(YYSearchModel *searchModel);
@property (nonatomic, copy) void (^deleteHistoryBlock)(void);

@end
