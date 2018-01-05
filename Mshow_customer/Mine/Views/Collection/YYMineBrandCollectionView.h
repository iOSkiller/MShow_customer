//
//  YYMineBrandCollectionView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYBrandModel;

@protocol YYMineBrandCollectionViewDelegate <NSObject>
- (void)executeShowBrandDetail:(YYBrandModel *)brandModel;
- (void)executeDeleteLikeBrand:(YYBrandModel *)brandModel;
- (void)executeDeleteLikeBrands:(NSArray *)brandsArray;

@end

@interface YYMineBrandCollectionView : UIView
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, weak) id <YYMineBrandCollectionViewDelegate> delegate;

@end
