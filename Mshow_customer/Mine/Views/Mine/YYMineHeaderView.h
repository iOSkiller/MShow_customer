//
//  YYMineHeaderView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYUserModel;

@interface YYMineHeaderView : UIView
@property (nonatomic, copy) void (^tapActionBlock)(void);
@property (nonatomic, copy) void (^setActionBlock)(void);
@property (nonatomic, copy) void (^messageActionBlock)(void);
@property (nonatomic, copy) void (^showBonusPointsActionBlock)(void);
@property (nonatomic, copy) void (^functionActionBlock)(YYMineFunctionType type);
@property (nonatomic, assign) NSInteger messageCount;
@property (nonatomic, strong) YYUserModel *userModel;

@end
