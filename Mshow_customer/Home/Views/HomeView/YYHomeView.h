//
//  YYHomeView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYGoodsModel;
@class YYShopModel;

@protocol YYHomeViewDelegate <NSObject>

@optional
/**滚动*/
- (void)homeViewDidScroll:(CGPoint)contentoffset;
/**展示广告信息*/
- (void)showAdsDetail:(NSString *)adsID;
/**展示商品详情*/
- (void)homeViewDidSelectItem:(YYGoodsModel *)goodsModel index:(NSInteger)index;
/**功能区*/
- (void)homeViewShowMoreInfo:(YYHomeCellType)type;
/**展示店铺*/
- (void)homeViewDidSelectShop:(YYShopModel *)shopModel;
/**首页功能区*/
- (void)homeViewShowHomeFunction:(YYHomeFunctionType)functionType;

@end

@interface YYHomeView : UIView
@property (nonatomic, weak) id <YYHomeViewDelegate> delegate;

@end
