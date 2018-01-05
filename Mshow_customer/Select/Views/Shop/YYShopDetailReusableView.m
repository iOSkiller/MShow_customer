//
//  YYShopDetailReusableView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/29.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShopDetailReusableView.h"
#import "YYShopModel.h"

@interface YYShopDetailReusableView ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *shopNameLabel;
@property (nonatomic, weak) UILabel *goodsCountLabel;
@property (nonatomic, weak) UILabel *goodsLabel;
@property (nonatomic, weak) UILabel *followCountLabel;
@property (nonatomic, weak) UILabel *followLabel;
@property (nonatomic, weak) UILabel *scoreCountLabel;
@property (nonatomic, weak) UILabel *scoreLabel;
@property (nonatomic, weak) UIView *infoView;

@end

@implementation YYShopDetailReusableView

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *view = [UIImageView new];
        [self addSubview:view];
        _imageView = view;
    }
    return _imageView;
}

- (UILabel *)shopNameLabel {
    if (!_shopNameLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBAColor(0, 0, 0, 0.75);
        label.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(50)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.imageView addSubview:label];
        _shopNameLabel = label;
    }
    return _shopNameLabel;
}

- (UIView *)infoView {
    if (!_infoView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _infoView = view;
    }
    return _infoView;
}

- (UILabel *)goodsCountLabel {
    if (!_goodsCountLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYTextColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.backgroundColor = [UIColor whiteColor];
        [self.infoView addSubview:label];
        _goodsCountLabel = label;
    }
    return _goodsCountLabel;
}

- (UILabel *)goodsLabel {
    if (!_goodsLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYTextColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"商品数量";
        [self.infoView addSubview:label];
        _goodsLabel = label;
    }
    return _goodsLabel;
}

- (UILabel *)followLabel {
    if (!_followLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYTextColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"收藏人数";
        [self.infoView addSubview:label];
        _followLabel = label;
    }
    return _followLabel;
}

- (UILabel *)followCountLabel {
    if (!_followCountLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYTextColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.backgroundColor = [UIColor whiteColor];
        [self.infoView addSubview:label];
        _followCountLabel = label;
    }
    return _followCountLabel;
}

- (UILabel *)scoreCountLabel {
    if (!_scoreCountLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYTextColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.backgroundColor = [UIColor whiteColor];
        [self.infoView addSubview:label];
        _scoreCountLabel = label;
    }
    return _scoreCountLabel;
}

- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYTextColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"平均评分";
        [self.infoView addSubview:label];
        _scoreLabel = label;
    }
    return _scoreLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self imageView];
        [self shopNameLabel];
        [self infoView];
        [self goodsLabel];
        [self goodsCountLabel];
        [self followCountLabel];
        [self followLabel];
        [self scoreCountLabel];
        [self scoreLabel];
        self.backgroundColor = YYSeparatorColor;
        WS(ws);
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(500));
        }];
        
        [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(74));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(74));
            make.centerY.equalTo(self.imageView);
            make.height.mas_equalTo(RELATIVE_WIDTH(100));
        }];
        
        [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(ws);
            make.bottom.equalTo(ws).offset(-RELATIVE_WIDTH(10));
            make.height.mas_equalTo(RELATIVE_WIDTH(100));
        }];
        
        CGFloat margin = RELATIVE_WIDTH(120);
        CGFloat width = (self.mj_w - margin * 2) / 3;
        [self.goodsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.infoView);
            make.top.equalTo(self.infoView).offset(RELATIVE_WIDTH(16));
            make.size.mas_equalTo(CGSizeMake(width, RELATIVE_WIDTH(32)));
        }];
        
        [self.goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.infoView);
            make.bottom.equalTo(self.infoView).offset(-RELATIVE_WIDTH(16));
            make.size.mas_equalTo(CGSizeMake(width, RELATIVE_WIDTH(32)));
        }];
        
        [self.followCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.infoView).offset(RELATIVE_WIDTH(16));
            make.left.equalTo(self.goodsCountLabel.mas_right).offset(margin);
            make.size.mas_equalTo(CGSizeMake(width, RELATIVE_WIDTH(32)));
        }];
        
        [self.followLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.infoView).offset(-RELATIVE_WIDTH(16));
            make.left.equalTo(self.goodsCountLabel.mas_right).offset(margin);
            make.size.mas_equalTo(CGSizeMake(width, RELATIVE_WIDTH(32)));
        }];
        
        [self.scoreCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.infoView).offset(RELATIVE_WIDTH(16));
            make.left.equalTo(self.followCountLabel.mas_right).offset(margin);
            make.size.mas_equalTo(CGSizeMake(width, RELATIVE_WIDTH(32)));
        }];
        
        [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.infoView).offset(-RELATIVE_WIDTH(16));
            make.left.equalTo(self.followCountLabel.mas_right).offset(margin);
            make.size.mas_equalTo(CGSizeMake(width, RELATIVE_WIDTH(32)));
        }];
        
    }
    return self;
}

- (void)setShopModel:(YYShopModel *)shopModel
{
    _shopModel = shopModel;
    self.imageView.image = [UIImage clipImage:[UIImage imageNamed:@"woman29.jpg"] toRect:CGSizeMake(WIN_WIDTH, RELATIVE_WIDTH(500))];
    self.shopNameLabel.text = @"SKDJHS旗舰店";
    self.goodsCountLabel.text = @"10";
    self.followCountLabel.text = @"210";
    self.scoreCountLabel.text = @"4.8";
}

@end
