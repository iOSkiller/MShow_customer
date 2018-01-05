//
//  YYGoodsNameView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYGoodsNameView.h"

@interface YYGoodsNameView ()
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *priceLabel;

@end

@implementation YYGoodsNameView

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        [self addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _priceLabel = label;
    }
    return _priceLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        WS(ws);
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.bottom.equalTo(ws).offset(-RELATIVE_WIDTH(30));
            make.height.mas_equalTo(RELATIVE_WIDTH(36));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(30));
            make.height.mas_equalTo(RELATIVE_WIDTH(36));
            make.width.greaterThanOrEqualTo(@0);
        }];
    }
    return self;
}

- (void)setName:(NSString *)name currentPrice:(NSString *)currentPrice originalPrice:(NSString *)originalPrice
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:[NSString str1:[NSString stringWithFormat:@"￥%@", currentPrice] font1:[UIFont systemFontOfSize:RELATIVE_WIDTH(34)] color1:YYGrayTextColor str2:[NSString stringWithFormat:@" 专柜价￥%@", originalPrice] font2:[UIFont systemFontOfSize:RELATIVE_WIDTH(28)] color2:YYGrayTextColor]];
    NSString *str1 = [NSString stringWithFormat:@"￥%@", currentPrice];
    NSInteger lenth0 = [str1 length];
    NSString *str2 = [NSString stringWithFormat:@"专柜价￥%@", originalPrice];
    NSInteger lenth1 = [str2 length];
    //添加划线
    [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(lenth0, lenth1)];
    self.priceLabel.attributedText = str;
    self.nameLabel.text = name;
}

@end
