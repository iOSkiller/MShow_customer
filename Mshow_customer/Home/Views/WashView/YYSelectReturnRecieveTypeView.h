//
//  YYSelectReturnRecieveTypeView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/3.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYSelectReturnRecieveViewType) {
    YYSelectReturnRecieveViewTypeReturn,
    YYSelectReturnRecieveViewTypeDelivery,
    
};
@interface YYSelectReturnRecieveTypeView : UIView
@property (nonatomic, copy) void (^didSelectType)(YYMineFunctionType type);
@property (nonatomic, assign) YYSelectReturnRecieveViewType  type;
@end
