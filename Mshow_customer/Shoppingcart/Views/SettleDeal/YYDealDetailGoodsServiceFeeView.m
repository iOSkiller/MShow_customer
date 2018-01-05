//
//  YYDealDetailGoodsServiceFeeView.m
//  Mshow_customer
//
//  Created by YYZ on 2018/1/2.
//  Copyright © 2018年 YYZ. All rights reserved.
//

#import "YYDealDetailGoodsServiceFeeView.h"

@interface YYDealDetailGoodsServiceFeeView ()
@property (nonatomic, weak) UILabel *washFeeLabel;
@property (nonatomic, weak) UILabel *tryFeeLabel;
@property (nonatomic, weak) UILabel *damageFeeLabel;

@end

@implementation YYDealDetailGoodsServiceFeeView

- (UILabel *)washFeeLabel {
    if (!_washFeeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        [self addSubview:label];
        _washFeeLabel = label;
    }
    return _washFeeLabel;
}

- (UILabel *)tryFeeLabel {
    if (!_tryFeeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _tryFeeLabel = label;
    }
    return _tryFeeLabel;
}

- (UILabel *)damageFeeLabel {
    if (!_damageFeeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.textAlignment = NSTextAlignmentRight;
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [label addGestureRecognizer:tap];
        [self addSubview:label];
        _damageFeeLabel = label;
    }
    return _damageFeeLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        WS(ws);
        self.userInteractionEnabled = YES;
        self.backgroundColor = mRGBToColor(0xfafafa);
        [self.washFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.centerY.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(30));
            make.width.greaterThanOrEqualTo(@20);
        }];
        
        [self.tryFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(ws);
            make.width.greaterThanOrEqualTo(@20);
            make.height.mas_equalTo(RELATIVE_WIDTH(30));
        }];
        
        [self.damageFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
            make.centerY.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(30));
            make.width.greaterThanOrEqualTo(@20);
        }];
    }
    return self;
}

- (void)tapAction
{
    if (!_isShowingDamageInfo) {
        if (_showDamageInfoBlock) {
            _showDamageInfoBlock();
        }
    }
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    self.washFeeLabel.text = @"干洗费￥20";
    self.tryFeeLabel.text = @"体验费￥10/天*2=￥20";
    self.damageFeeLabel.text = @"折损费￥1.00";
}

@end
