//
//  YYMineWardrobeGoodsView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/9.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineWardrobeGoodsView.h"
#import "YYGoodsModel.h"

@interface YYMineWardrobeGoodsView ()
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *colorLabel;
@property (nonatomic, weak) UILabel *marketPriceLabel;
@property (nonatomic, weak) UILabel *sizeLabel;
@property (nonatomic, weak) UILabel *discountLabel;
@property (nonatomic, weak) UILabel *currentPriceLabel;
@property (nonatomic, weak) UILabel *countLabel;

@end

@implementation YYMineWardrobeGoodsView

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [UIImageView new];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _imgView = view;
    }
    return _imgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.text = @"韩版时尚卫衣";
        [self addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)colorLabel {
    if (!_colorLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.textColor = YYGrayTextColor;
        label.text = @"颜色:米色";
        [self addSubview:label];
        _colorLabel = label;
    }
    return _colorLabel;
}

- (UILabel *)marketPriceLabel {
    if (!_marketPriceLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.textColor = YYGrayTextColor;
        label.text = @"市场价:￥400.00";
        [self addSubview:label];
        _marketPriceLabel = label;
    }
    return _marketPriceLabel;
}

- (UILabel *)sizeLabel {
    if (!_sizeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.textColor = YYGrayTextColor;
        label.text = @"尺寸:S";
        [self addSubview:label];
        _sizeLabel = label;
    }
    return _sizeLabel;
}

- (UILabel *)discountLabel {
    if (!_discountLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.textColor = YYGrayTextColor;
        label.text = @"M秀折扣:-￥100.00";
        [self addSubview:label];
        _discountLabel = label;
    }
    return _discountLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.textColor = YYGrayTextColor;
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"x1";
        [self addSubview:label];
        _countLabel = label;
    }
    return _countLabel;
}

- (UILabel *)currentPriceLabel {
    if (!_currentPriceLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xfafafa);
        label.attributedText = [NSString str1:@"折扣价" font1:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color1:YYTextColor str2:@"￥300.00" font2:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color2:YYGlobalColor];
        [self addSubview:label];
        _currentPriceLabel = label;
    }
    return _currentPriceLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self imgView];
        [self nameLabel];
        [self colorLabel];
        [self marketPriceLabel];
        [self sizeLabel];
        [self discountLabel];
        [self currentPriceLabel];
        [self countLabel];
        self.backgroundColor = mRGBToColor(0xfafafa);
        
        WS(ws);
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(182));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(20));
            make.top.equalTo(self.imgView);
            make.height.mas_equalTo(RELATIVE_WIDTH(30));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
        }];
        
        [self.colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(RELATIVE_WIDTH(14));
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(20));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(230), RELATIVE_WIDTH(28)));
        }];
        
        [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.colorLabel.mas_bottom).offset(RELATIVE_WIDTH(6));
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(20));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(230), RELATIVE_WIDTH(28)));
        }];
        
        [self.marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
            make.top.equalTo(self.nameLabel.mas_bottom).offset(RELATIVE_WIDTH(14));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(300), RELATIVE_WIDTH(28)));
        }];
        
        [self.discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
            make.top.equalTo(self.marketPriceLabel.mas_bottom).offset(RELATIVE_WIDTH(6));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(300), RELATIVE_WIDTH(28)));
        }];
        
        [self.currentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(20));
            make.top.equalTo(self.sizeLabel.mas_bottom).offset(RELATIVE_WIDTH(30));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
            make.height.mas_equalTo(RELATIVE_WIDTH(30));
        }];
        
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.currentPriceLabel);
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(80), RELATIVE_WIDTH(30)));
        }];
    }
    return self;
}

- (void)setShowCount:(BOOL)showCount
{
    _showCount = showCount;
    self.countLabel.hidden = !showCount;
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    
    [self.imgView performSelector:@selector(setImage:) withObject:[UIImage clipImage:[UIImage imageNamed:goodsModel.image] toRect:CGSizeMake(RELATIVE_WIDTH(182), RELATIVE_WIDTH(182))] afterDelay:0.2 inModes:@[NSDefaultRunLoopMode]];
    
    self.sizeLabel.text = [NSString stringWithFormat:@"尺寸:%@", goodsModel.size];
    self.colorLabel.text = [NSString stringWithFormat:@"颜色:%@", goodsModel.color];
    self.marketPriceLabel.text = [NSString stringWithFormat:@"市场价:￥%@", goodsModel.marketPrice];
    self.discountLabel.text = [NSString stringWithFormat:@"M秀折扣价:-￥%@", goodsModel.discountPrice];
    NSString *str1 = _type == YYMineWardrobeViewTypeTried ? @"押金:" : @"折扣价:";
    self.currentPriceLabel.attributedText = [NSString str1:str1 font1:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color1:YYTextColor str2:[NSString stringWithFormat:@"￥%@", goodsModel.currentPrice] font2:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color2:YYGlobalColor];
}



@end
