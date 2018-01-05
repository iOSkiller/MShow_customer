//
//  YYSelectGoodsCountView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/28.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYSelectGoodsCountView : UIView
@property (nonatomic, copy) void (^didSelectCountBlock)(NSString *count);

@end
