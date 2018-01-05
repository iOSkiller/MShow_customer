//
//  YYReturnGoodsView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/12/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YYReturnGoodsViewDelegate <NSObject>
- (void)executeSureAction:(NSArray *)selectedGoodsArray;

@end

@interface YYReturnGoodsView : UIView
@property (nonatomic, copy) NSArray *goodsArray;
@property (nonatomic, weak) id <YYReturnGoodsViewDelegate> delegate;

@end
