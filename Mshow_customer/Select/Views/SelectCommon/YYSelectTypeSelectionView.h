//
//  YYSelectTypeSelectionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/6.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYTypeSelectionModel;

@interface YYSelectTypeSelectionView : UIView
@property (nonatomic, copy) NSArray *selectionArray;
@property (nonatomic, copy) void (^sureBlock)(YYTypeSelectionModel *model);
@property (nonatomic, copy) void (^resetBlock)(void);
//@property (nonatomic, copy) void (^selectBlock)(NSArray *selectArray);
//@property (nonatomic, copy) void (^selectBlock)(YYTypeSelectionModel *model);
- (void)show;
- (void)hide;

@end
