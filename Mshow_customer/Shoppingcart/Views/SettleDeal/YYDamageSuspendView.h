//
//  YYDamageSuspendView.h
//  Mshow_customer
//
//  Created by YYZ on 2018/1/3.
//  Copyright © 2018年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYDamageSuspendView : UIView
@property (nonatomic, copy) void (^showDamageDetailBlock)(void);
@property (nonatomic, copy) void (^closeBlock)(void);

@end
