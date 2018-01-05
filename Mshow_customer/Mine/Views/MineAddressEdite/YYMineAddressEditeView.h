//
//  YYMineEditeView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYAddressModel;

@protocol YYMineAddressEditeViewDelegate <NSObject>
- (void)executeFinishAction:(YYAddressModel *)addressModel;

@end

@interface YYMineAddressEditeView : UIView
@property (nonatomic, weak) id <YYMineAddressEditeViewDelegate> delegate;
@property (nonatomic, strong) YYAddressModel *addressModel;

@end
