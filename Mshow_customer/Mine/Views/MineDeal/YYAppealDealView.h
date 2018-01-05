//
//  YYAppealDealView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYDealModel;

@protocol YYAppealDealViewDelegate <NSObject>
- (void)executeCancelAction;
- (void)executeSureAction:(YYDealModel *)dealModel;

@end

@interface YYAppealDealView : UIView
@property (nonatomic, weak) id <YYAppealDealViewDelegate> delegate;
@property (nonatomic, weak) YYDealModel *dealModel;

@end
