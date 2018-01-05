//
//  YYGoodsInfoView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/7.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYGoodsInfoView.h"

@interface YYGoodsInfoView ()
/**长度*/
@property (nonatomic, weak) UILabel *sizeLabel;
/**款式*/
@property (nonatomic, weak) UILabel *styleLabel;
/**编号*/
@property (nonatomic, weak) UILabel *codeLabel;
/**版型*/
@property (nonatomic, weak) UILabel *typeLabel;
/**材质*/
@property (nonatomic, weak) UILabel *materialLabel;
/**风格*/
@property (nonatomic, weak) UILabel *kindLabel;
/**季节*/
@property (nonatomic, weak) UILabel *seasonLabel;

@end

@implementation YYGoodsInfoView

- (UILabel *)sizeLabel {
    if (!_sizeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.text = @"长度:短款";
        [self addSubview:label];
        _sizeLabel = label;
    }
    return _sizeLabel;
}

- (UILabel *)styleLabel {
    if (!_styleLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.text = @"款式:半身裙";
        [self addSubview:label];
        _styleLabel = label;
    }
    return _styleLabel;
}

- (UILabel *)kindLabel {
    if (!_kindLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.text = @"风格:甜美";
        [self addSubview:label];
        _kindLabel = label;
    }
    return _kindLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.text = @"版型:修身";
        [self addSubview:label];
        _typeLabel = label;
    }
    return _typeLabel;
}

- (UILabel *)materialLabel {
    if (!_materialLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.text = @"材质:棉";
        [self addSubview:label];
        _materialLabel = label;
    }
    return _materialLabel;
}

- (UILabel *)seasonLabel {
    if (!_seasonLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.text = @"季节:春秋";
        [self addSubview:label];
        _seasonLabel = label;
    }
    return _seasonLabel;
}

- (UILabel *)codeLabel {
    if (!_codeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.text = @"服装编号:123456789";
        [self addSubview:label];
        _codeLabel = label;
    }
    return _codeLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self sizeLabel];
        [self typeLabel];
        [self kindLabel];
        [self codeLabel];
        [self styleLabel];
        [self seasonLabel];
        [self materialLabel];
        
        WS(ws);
        CGFloat width = (WIN_WIDTH - RELATIVE_WIDTH(20) - RELATIVE_WIDTH(48)) / 3;
        [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(20));
            make.size.mas_equalTo(CGSizeMake(width, RELATIVE_WIDTH(30)));
        }];
        
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sizeLabel.mas_right).offset(RELATIVE_WIDTH(10));
            make.top.width.height.equalTo(self.sizeLabel);
        }];
        
        [self.styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.equalTo(self.typeLabel);
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
        }];
        
        [self.kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.size.mas_equalTo(CGSizeMake(width, RELATIVE_WIDTH(30)));
            make.top.equalTo(self.sizeLabel.mas_bottom).offset(RELATIVE_WIDTH(6));
        }];
        
        [self.materialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.kindLabel.mas_right).offset(RELATIVE_WIDTH(10));
            make.top.width.height.equalTo(self.kindLabel);
        }];
        
        [self.seasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.equalTo(self.kindLabel);
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
        }];
        
        [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
            make.height.mas_equalTo(RELATIVE_WIDTH(30));
            make.top.equalTo(self.kindLabel.mas_bottom).offset(RELATIVE_WIDTH(6));
        }];
    }
    return self;
}



@end
