//
//  YYPlaceHolderView.h
//  DDFood
//
//  Created by YZ Y on 16/7/2.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

typedef NS_ENUM(NSInteger, YYPlaceHolderViewType) {
    YYPlaceHolderViewTypeLoading,
    YYPlaceHolderViewTypeGif,
    YYPlaceHolderViewTypeShoppingCart,
    YYPlaceHolderViewTypeFailed,
    YYPlaceHolderViewTypeNoneDeal,
};


#import <UIKit/UIKit.h>

@protocol YYPlaceHolderViewDelegate <NSObject>
@optional
- (void)backHome;
- (void)gotoPromotion;
- (void)tapToReload;

@end

@interface YYPlaceHolderView : UIView
- (void)show;
- (void)setImage:(NSString *)image type:(YYPlaceHolderViewType)type;
- (void)dismiss;
@property (nonatomic, weak) id <YYPlaceHolderViewDelegate> delegate;

@end
