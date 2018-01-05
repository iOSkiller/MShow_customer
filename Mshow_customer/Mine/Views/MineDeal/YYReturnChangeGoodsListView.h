//
//  YYReturnChangeGoodsListView.h
//  Mshow_customer
//
//  Created by YYZ on 2018/1/3.
//  Copyright © 2018年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYDealModel;

@protocol YYReturnChangeGoodsListViewDelegate <NSObject>
- (void)executeShowDealDetail:(YYDealModel *)dealModel;
- (void)executeLoadMoreData;

@end

@interface YYReturnChangeGoodsListView : UIView
@property (nonatomic, weak) id <YYReturnChangeGoodsListViewDelegate> delegate;
@property (nonatomic, copy) NSArray *dealArray;

@end
