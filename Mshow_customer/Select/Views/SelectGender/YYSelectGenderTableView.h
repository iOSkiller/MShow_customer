//
//  YYSelectGenderTableView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYGoodsModel;
@class YYSelectGenderTableView;

@protocol YYSelectGenderTableViewDelegate <NSObject>
- (void)selectGenderTableView:(YYSelectGenderTableView *)tableView showGoodsDetail:(YYGoodsModel *)goodsModel;
- (void)selectGenderTableView:(YYSelectGenderTableView *)tableView showShopDetail:(NSString *)shopID;
- (void)tableViewLoadMoreData;

@optional
- (void)tableViewDidScrollToIndex:(NSUInteger)index;

@end

@interface YYSelectGenderTableView : UIView
@property (nonatomic, copy) NSArray *goodsArray;
@property (nonatomic, weak) id <YYSelectGenderTableViewDelegate> delegate;
- (void)scrollToIndex:(NSUInteger)index;
- (void)endRefresh;

@end
