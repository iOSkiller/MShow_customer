//
//  YYCollectionChildViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYBaseViewController.h"

typedef NS_ENUM(NSInteger, YYCollectionChildViewType) {
    YYCollectionChildViewTypeGoods,
    YYCollectionChildViewTypeShop,
    YYCollectionChildViewTypeBrand,
};

@interface YYCollectionChildViewController : YYBaseViewController
@property (nonatomic, assign) YYCollectionChildViewType type;
@property (nonatomic, assign) BOOL isEditing;

@end
