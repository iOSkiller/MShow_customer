//
//  YYMineWardrobeTitleView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/11/9.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYMineWardrobeTitleViewType) {
    YYMineWardrobeTitleViewTypeFunction,
    YYMineWardrobeTitleViewTypeNormal,
    YYMineWardrobeTitleViewTypeState,
};

@interface YYMineWardrobeTitleView : UIView
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) void (^buttonActionBlock)(void);
@property (nonatomic, copy) void (^tapActionBlock)(void);
- (instancetype)initWithFrame:(CGRect)frame type:(YYMineWardrobeTitleViewType)type;

@end
