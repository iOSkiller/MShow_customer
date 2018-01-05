//
//  YYMineView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYUserModel;

@protocol YYMineViewDelegate <NSObject>
- (void)executeShowFunctionDetail:(YYMineFunctionType)functionType;
- (void)executeShowDealDetail:(YYDealStatusType)dealStatus;
- (void)executeShowInfoDetail;
- (void)executeShowSetting;
- (void)executeShowMessage;
- (void)executeShowAllDeal;

@end

@interface YYMineView : UIView
@property (nonatomic, weak) id <YYMineViewDelegate> delegate;

- (void)reloadCustomerInfo:(YYUserModel *)userModel;

@end
