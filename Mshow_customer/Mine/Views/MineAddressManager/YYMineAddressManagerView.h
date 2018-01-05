//
//  YYMineAddressManagerView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/16.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYAddressModel;

@protocol YYMineAddressManagerViewDelegate <NSObject>
- (void)executeDeleteAddress:(YYAddressModel *)addressModel;
- (void)executeEditeAddress:(YYAddressModel *)addressModel;
- (void)executeChageDefaultAddress:(YYAddressModel *)addressModel;
- (void)executeAddAddress;
- (void)executeSelectAddress:(YYAddressModel *)addressModel;

@end

@interface YYMineAddressManagerView : UIView
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, weak) id <YYMineAddressManagerViewDelegate> delegate;

@end
