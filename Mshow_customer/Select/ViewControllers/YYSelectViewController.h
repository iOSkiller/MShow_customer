//
//  YYSelectViewController.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YZDisplayViewController.h"

typedef NS_ENUM(NSInteger, YYSelectViewControllerType) {
    YYSelectViewControllerTypeNormal,
    YYSelectViewControllerTypeHot,
    YYSelectViewControllerTypeNew,
    YYSelectViewControllerTypeShop,
    YYSelectViewControllerTypeBrand,
};

@interface YYSelectViewController : YZDisplayViewController
@property (nonatomic, assign) BOOL hideToobBar;
@property (nonatomic, copy) NSString *searchText;

@end
