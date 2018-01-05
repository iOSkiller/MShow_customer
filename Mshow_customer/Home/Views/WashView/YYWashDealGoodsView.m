//
//  YYWashDealGoodsView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYWashDealGoodsView.h"
#import "YYGoodsModel.h"

@interface YYWashDealGoodsView ()
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *countLabel;

@end

@implementation YYWashDealGoodsView

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _priceLabel = label;
    }
    return _priceLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYGrayTextColor;
        label.textAlignment = NSTextAlignmentRight;
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _countLabel = label;
    }
    return _countLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        WS(ws);
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.centerY.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(216));
            make.centerY.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
            make.centerY.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.greaterThanOrEqualTo(@0);
        }];
    }
    return self;
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    self.nameLabel.text = goodsModel.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",goodsModel.currentPrice];
    self.countLabel.text = [NSString stringWithFormat:@"x%@", goodsModel.count];
}

@end
