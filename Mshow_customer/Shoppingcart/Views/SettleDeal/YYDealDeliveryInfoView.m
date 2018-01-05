//
//  YYDealDeliveryInfoView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYDealDeliveryInfoView.h"

@interface YYDealDeliveryInfoView ()
@property (nonatomic, weak) UILabel *infoLabel;
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UIImageView *iconView;

@end

@implementation YYDealDeliveryInfoView

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.text = @"已签收";
        [self addSubview:label];
        _infoLabel = label;
    }
    return _infoLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.textColor = YYGrayTextColor;
        label.text = [NSString currentDate:@"yyyy-MM-dd HH:mm"];
        [self addSubview:label];
        _dateLabel = label;
    }
    return _dateLabel;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_logistics"]];
        [self addSubview:view];
        _iconView = view;
    }
    return _iconView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self infoLabel];
        [self dateLabel];
        [self iconView];
        WS(ws);
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.centerY.equalTo(ws);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
        }];
        
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.greaterThanOrEqualTo(@0);
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(20));
        }];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(28));
            make.width.greaterThanOrEqualTo(@0);
            make.top.equalTo(self.infoLabel.mas_bottom).offset(RELATIVE_WIDTH(10));
        }];
    }
    return self;
}
@end
