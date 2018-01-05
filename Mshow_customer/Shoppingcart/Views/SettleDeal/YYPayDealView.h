//
//  YYPayDealView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYPayDealViewDelegate <NSObject>
- (void)executePayDeal:(YYPayType)payType;

@end

@interface YYPayDealView : UIView
@property (nonatomic, weak) id <YYPayDealViewDelegate> delegate;

@end
