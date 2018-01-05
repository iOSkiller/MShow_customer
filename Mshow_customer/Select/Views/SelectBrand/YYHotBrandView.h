//
//  YYHotBrandView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYBrandModel;

@interface YYHotBrandView : UIView
@property (nonatomic, copy) void (^showHotBrandBlock)(YYBrandModel *model);

@end
