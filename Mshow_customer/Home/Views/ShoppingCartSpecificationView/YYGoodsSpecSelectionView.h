//
//  YYGoodsSpecSelectionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/28.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYGoodsSpecSelectionView : UIView
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, copy) void (^didSelectSpec)(NSString *specID, NSString *spec);

@end
