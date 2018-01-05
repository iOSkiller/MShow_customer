//
//  YYGoodsSpecInfoView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/28.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYGoodsSpecInfoView.h"

@interface YYGoodsSpecInfoView ()

@end

@implementation YYGoodsSpecInfoView

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [[UIImageView alloc] init];
        [self addSubview:view];
        _imgView = view;
    }
    return _imgView;
}

- (UILabel *)lastestPriceLabel {
    if (!_lastestPriceLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _lastestPriceLabel = label;
    }
    return _lastestPriceLabel;
}

- (UILabel *)cheapPriceLabel {
    if (!_cheapPriceLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _cheapPriceLabel = label;
    }
    return _cheapPriceLabel;
}

- (UILabel *)stockLabel {
    if (!_stockLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _stockLabel = label;
    }
    return _stockLabel;
}

- (UILabel *)specLabel {
    if (!_specLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _specLabel = label;
    }
    return _specLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self imgView];
        [self lastestPriceLabel];
        [self cheapPriceLabel];
        [self stockLabel];
        [self specLabel];
        self.backgroundColor = [UIColor clearColor];
        WS(ws);
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.bottom.equalTo(ws).offset(-RELATIVE_WIDTH(2));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(242), RELATIVE_WIDTH(262)));
        }];
        
        [self.lastestPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView).offset(RELATIVE_WIDTH(80));
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(20));
            make.width.greaterThanOrEqualTo(@0);
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
        }];
        
        [self.cheapPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lastestPriceLabel.mas_bottom).offset(RELATIVE_WIDTH(20));
            make.left.height.equalTo(self.lastestPriceLabel);
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.specLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws);
            make.left.height.equalTo(self.lastestPriceLabel);
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.specLabel.mas_top).offset(-RELATIVE_WIDTH(20));
            make.left.height.equalTo(self.lastestPriceLabel);
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        self.imgView.image = [UIImage clipImage:[UIImage imageNamed:@"woman19.jpg"] toRect:CGSizeMake(RELATIVE_WIDTH(242), 262)];
    }
    return self;
}

@end
