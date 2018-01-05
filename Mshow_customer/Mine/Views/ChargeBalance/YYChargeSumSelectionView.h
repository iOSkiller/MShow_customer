//
//  YYChargeSumSelectionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYChargeSumModel;

@interface YYChargeSumSelectionView : UIView
@property (nonatomic, copy) void (^didSelectBlock)(YYChargeSumModel *chargeSumModel);
@property (nonatomic, copy) NSArray *selectionArray;

@end
