//
//  YYSelectChildViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseViewController.h"

typedef NS_ENUM(NSInteger, YYSelectChildViewType) {
    YYSelectChildViewTypeMan,
    YYSelectChildViewTypeShop,
    YYSelectChildViewTypeWomen,
    YYSelectChildViewTypeChild,
    YYSelectChildViewTypeBrand,
    YYSelectChildViewTypeScene,
};

@interface YYSelectChildViewController : YYBaseViewController
@property (nonatomic, assign) YYSelectChildViewType type;
@property (nonatomic, assign) YYSelectChildViewDataType dataType;
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, assign) BOOL isTableView;

@end
