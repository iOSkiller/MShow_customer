//
//  YYHistoryTableView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/15.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYGoodsModel;

@protocol YYHistoryTableViewDelegate <NSObject>
- (void)tableViewShowGoodsDetail:(YYGoodsModel *)goodsModel;
- (void)tableViewShowShopDetail:(NSString *)shopID;
@end

@interface YYHistoryTableView : UIView
@property (nonatomic, weak) id <YYHistoryTableViewDelegate> delegate;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, assign) BOOL isEditing;
- (void)deleteSelectedGoods;

@end
