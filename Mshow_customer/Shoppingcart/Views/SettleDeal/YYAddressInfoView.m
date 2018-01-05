//
//  YYAddressInfoView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYAddressInfoView.h"
#import "YYAddressModel.h"

@interface YYAddressInfoView ()
@property (nonatomic, weak) UILabel *defaultLabel;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *phoneLabel;
@property (nonatomic, weak) UILabel *addressLabel;
@property (nonatomic, weak) UIImageView *addressView;
@property (nonatomic, weak) UIImageView *lineView;
@property (nonatomic, weak) UILabel *placeHolderLabel;

@end

@implementation YYAddressInfoView

- (UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"请选择地址";
        label.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(34)];
        label.textColor = YYTextColor;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _placeHolderLabel = label;
        WS(ws);
        [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(ws);
            make.centerY.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(38));
        }];
    }
    return _placeHolderLabel;
}


- (UILabel *)defaultLabel {
    if (!_defaultLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = YYGlobalColor;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"默认";
        label.layer.cornerRadius = CommonCornerRadius;
        label.layer.masksToBounds = YES;
        [self addSubview:label];
        _defaultLabel = label;
    }
    return _defaultLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.text = @"收货人：某某某";
        [self addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.text = @"18306118609";
        [self addSubview:label];
        _phoneLabel = label;
    }
    return _phoneLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.numberOfLines = 0;
        label.text = @"收货地址：江苏省-南京市-鼓楼区-亚都大厦715";
        [self addSubview:label];
        _addressLabel = label;
    }
    return _addressLabel;
}

- (UIImageView *)addressView {
    if (!_addressView) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_img_address"]];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _addressView = view;
    }
    return _addressView;
}

- (UIImageView *)lineView {
    if (!_lineView) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_blueredline"]];
        [self addSubview:view];
        _lineView = view;
    }
    return _lineView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self defaultLabel];
        [self nameLabel];
        [self phoneLabel];
        [self addressLabel];
        [self addressView];
        [self lineView];
        
    }
    return self;
}

- (void)setHideLine:(BOOL)hideLine
{
    _hideLine = hideLine;
    self.lineView.hidden = hideLine;
}

- (void)setAddressModel:(YYAddressModel *)addressModel
{
    if ([addressModel.name isValid]) {
        self.nameLabel.hidden = NO;
        self.phoneLabel.hidden = NO;
        self.addressView.hidden = NO;
        self.addressLabel.hidden = NO;
        self.defaultLabel.hidden = NO;
        self.placeHolderLabel.hidden = YES;
        _addressModel = addressModel;
        self.nameLabel.text = addressModel.name;
        self.phoneLabel.text = addressModel.phone;
        self.addressLabel.text = [NSString stringWithFormat:@"%@-%@-%@-%@", addressModel.province, addressModel.city, addressModel.area, addressModel.detailAddress];
    } else {
        self.nameLabel.hidden = YES;
        self.addressView.hidden = YES;
        self.phoneLabel.hidden = YES;
        self.addressLabel.hidden = YES;
        self.defaultLabel.hidden = YES;
        self.placeHolderLabel.hidden = NO;
    }
    
}

- (void)setHideTagView:(BOOL)hideTagView
{
    _hideTagView = hideTagView;
    self.addressView.hidden = _hideTagView;
    self.defaultLabel.hidden = _hideTagView;
    
    WS(ws);
    if (!_hideTagView) {
        [self.defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(20));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(80), RELATIVE_WIDTH(36)));
        }];
        
        [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.defaultLabel);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
            make.top.equalTo(self.defaultLabel.mas_bottom).offset(RELATIVE_WIDTH(20));
        }];
    }
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        _hideTagView ? make.left.equalTo(ws).offset(RELATIVE_WIDTH(26)) : make.left.equalTo(self.defaultLabel.mas_right).offset(RELATIVE_WIDTH(14));
        make.top.equalTo(ws).offset(RELATIVE_WIDTH(20));
        make.width.greaterThanOrEqualTo(@20);
        make.height.mas_equalTo(RELATIVE_WIDTH(32));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).offset(-RELATIVE_WIDTH(68));
        make.top.equalTo(ws).offset(RELATIVE_WIDTH(20));
        make.height.mas_equalTo(RELATIVE_WIDTH(32));
        make.width.greaterThanOrEqualTo(@20);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).offset(-RELATIVE_WIDTH(68));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(RELATIVE_WIDTH(20));
        make.left.equalTo(self.nameLabel);
        make.height.greaterThanOrEqualTo(@(RELATIVE_WIDTH(30)));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(ws);
        make.height.mas_equalTo(RELATIVE_WIDTH(14));
    }];
    
}

@end
