//
//  YYAddressInfoView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYAddressModel;


@interface YYAddressInfoView : UIView
@property (nonatomic, assign) BOOL hideLine;
@property (nonatomic, assign) BOOL hideTagView;
@property (nonatomic, strong) YYAddressModel *addressModel;

@end
