//
//  YYMyCouponViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/10.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMyCouponViewCell.h"
#import "YYCouponModel.h"

#define disableColor mRGBToColor(0x999999)

@interface YYMyCouponViewCell ()
@property (nonatomic, weak) UILabel *sumLabel;
@property (nonatomic, weak) UILabel *conditionLabel;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *subLabel;
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UIImageView *backView;

@end

@implementation YYMyCouponViewCell

- (UIImageView *)backView {
    if (!_backView) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_coupons_back"]];
        [self.contentView addSubview:view];
        _backView = view;
    }
    return _backView;
}

- (UILabel *)subLabel {
    if (!_subLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        label.textColor = mRGBToColor(0x303030);
        label.text = @"全场通用";
        [self.backView addSubview:label];
        _subLabel = label;
    }
    return _subLabel;
}

- (UILabel *)sumLabel {
    if (!_sumLabel) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.attributedText = [NSString str1:@"￥" font1:[UIFont systemFontOfSize:RELATIVE_WIDTH(44)] color1:[UIColor whiteColor] str2:@"10" font2:[UIFont systemFontOfSize:RELATIVE_WIDTH(66)] color2:[UIColor whiteColor]];
        label.backgroundColor = mRGBToColor(0xfcb4b1);
        [self.backView addSubview:label];
        _sumLabel = label;
    }
    return _sumLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(36)];
        label.textColor = YYTextColor;
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"充值抵押券";
        [self.backView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)conditionLabel {
    if (!_conditionLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(24)];
        label.textColor = [UIColor whiteColor];
        label.text = @"无消费金额限制";
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = mRGBToColor(0xfcb4b1);
        [self.backView addSubview:label];
        _conditionLabel = label;
    }
    return _conditionLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.text = @"有效期:2017.09.20-2017.10.20";
        [self.backView addSubview:label];
        _dateLabel = label;
    }
    return _dateLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = mRGBToColor(0xf0f0f0);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}



- (void)setCouponModel:(YYCouponModel *)couponModel
{
    _couponModel = couponModel;
    
    WS(ws);
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(26));
        make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
    }];
    
    [self.sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(RELATIVE_WIDTH(50));
        make.left.equalTo(self.backView).offset(RELATIVE_WIDTH(16));
        make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(200), RELATIVE_WIDTH(70)));
    }];
    
    [self.conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView.mas_bottom).offset(RELATIVE_WIDTH(-20));
        make.left.equalTo(self.backView).offset(RELATIVE_WIDTH(16));
        make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(200), RELATIVE_WIDTH(26)));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(RELATIVE_WIDTH(28));
        make.left.equalTo(self.backView).offset(RELATIVE_WIDTH(260));
        make.right.equalTo(self.backView).offset(-RELATIVE_WIDTH(16));
        make.height.mas_equalTo(RELATIVE_WIDTH(38));
    }];
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(RELATIVE_WIDTH(20));
        make.left.equalTo(self.backView).offset(RELATIVE_WIDTH(260));
        make.right.equalTo(self.backView).offset(-RELATIVE_WIDTH(16));
        make.height.mas_equalTo(RELATIVE_WIDTH(36));
    }];

    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(RELATIVE_WIDTH(260));
        make.right.equalTo(self.backView).offset(-RELATIVE_WIDTH(16));
        make.height.mas_equalTo(RELATIVE_WIDTH(26));
        make.bottom.equalTo(self.backView).offset(-RELATIVE_WIDTH(20));
    }];
    
    if (!couponModel.isAvailable) {
        
        self.subLabel.textColor = disableColor;
        self.sumLabel.textColor = disableColor;
        self.sumLabel.backgroundColor = mRGBToColor(0xffffff);
        self.nameLabel.textColor = disableColor;
        self.dateLabel.textColor = disableColor;
        self.conditionLabel.textColor = disableColor;
        self.conditionLabel.backgroundColor = mRGBToColor(0xffffff);
        self.backView.image = [UIImage imageNamed:@"img_coupons_used"];
    }
}

@end
