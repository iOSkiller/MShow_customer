//
//  YYMineWardrobeTitleView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/9.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineWardrobeTitleView.h"

@interface YYMineWardrobeTitleView ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *functionLabel;
@property (nonatomic, weak) UILabel *stateLabel;

@end

@implementation YYMineWardrobeTitleView

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        label.text = @"某某某店铺";
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [label addGestureRecognizer:tap];
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_shop"]];
        [self addSubview:imgView];
        _imgView = imgView;
    }
    return _imgView;
}

- (UILabel *)functionLabel {
    if (!_functionLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.textColor = YYGrayTextColor;
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"查看物流";
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction)];
        [label addGestureRecognizer:tap];
        [self addSubview:label];
        _functionLabel = label;
    }
    return _functionLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYGlobalColor;
        label.textAlignment = NSTextAlignmentRight;
        [self addSubview:label];
        _stateLabel = label;
    }
    return _stateLabel;
}


- (instancetype)initWithFrame:(CGRect)frame type:(YYMineWardrobeTitleViewType)type
{
    if (self = [super initWithFrame:frame]) {
        WS(ws);
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(24));
            make.width.height.mas_offset(RELATIVE_WIDTH(44));
            make.centerY.equalTo(ws);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(4));
            make.top.bottom.equalTo(ws);
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        switch (type) {
            case YYMineWardrobeTitleViewTypeState:
            {
                [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
                    make.top.equalTo(ws);
                    make.width.greaterThanOrEqualTo(@0);
                    make.height.mas_equalTo(RELATIVE_WIDTH(78));
                }];
            }
                break;
            case YYMineWardrobeTitleViewTypeNormal:
                break;
            case YYMineWardrobeTitleViewTypeFunction:
            {
                [self.functionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
                    make.top.equalTo(ws);
                    make.width.mas_equalTo(RELATIVE_WIDTH(150));
                    make.height.mas_equalTo(RELATIVE_WIDTH(78));
                }];
            }
                break;
            default:
                break;
        }
        
       
        
        
    }
    return self;
}

- (void)setShopName:(NSString *)shopName
{
    _shopName = shopName;
    self.titleLabel.text = shopName;
}

- (void)setState:(NSString *)state
{
    _state = state;
    self.stateLabel.text = state;
}

- (void)tapAction
{
    if (_tapActionBlock) {
        _tapActionBlock();
    }
}

- (void)buttonAction
{
    if (_buttonActionBlock) {
        _buttonActionBlock();
    }
}


@end
