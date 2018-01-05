//
//  YYSelectBrandView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYBrandModel;

@protocol YYSelectBrandViewDelegate <NSObject>
/**展示品牌*/
- (void)executeShowBrandDetail:(YYBrandModel *)brandModel;
/**展示热门品牌*/
- (void)executeShowHotBrandDetail:(YYBrandModel *)brandModel;

@end

@interface YYSelectBrandView : UIView
@property (nonatomic, weak) id <YYSelectBrandViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame indexArray:(NSArray *)indexArray;

@end
