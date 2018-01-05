//
//  YYHistoryHeaderView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/13.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYHistoryHeaderView : UICollectionReusableView
@property (nonatomic, copy) void (^selectBlock)(BOOL isSelected);
@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, assign) BOOL isSelected;

@end
