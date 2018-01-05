//
//  YYDealCancelView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/22.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYDealCancelView : UIView
@property (nonatomic, copy) NSArray *selectionArray;
@property (nonatomic, copy) void (^didSelectReasonBlock)(YYCancelReasonType reasonType);

@end
