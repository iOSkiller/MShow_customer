//
//  YYDealStatusView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYDealStatusView.h"

@interface YYDealStatusView ()
@property (nonatomic, weak) UILabel *statusLabel;
@property (nonatomic, weak) UILabel *dealCodeLabel;
@property (nonatomic, weak) UILabel *dateLabel;

@end

@implementation YYDealStatusView

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGlobalColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(36)];
        label.text = @"待发货";
        [self addSubview:label];
        _statusLabel = label;
    }
    return _statusLabel;
}

- (UILabel *)dealCodeLabel {
    if (!_dealCodeLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.textColor = YYGrayTextColor;
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"订单号：123456789";
        [self addSubview:label];
        _dealCodeLabel = label;
    }
    return _dealCodeLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.textColor = YYGrayTextColor;
        label.backgroundColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@"下单时间：%@", [NSString currentDate:@"yyyy-MM-dd HH:mm"]];
        [self addSubview:label];
        _dateLabel = label;
    }
    return _dateLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self statusLabel];
        [self dealCodeLabel];
        [self dateLabel];
        WS(ws);
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(20));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(38));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.dealCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.statusLabel.mas_bottom).offset(RELATIVE_WIDTH(10));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(28));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dealCodeLabel.mas_bottom).offset(RELATIVE_WIDTH(10));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(28));
            make.width.greaterThanOrEqualTo(@0);
        }];
    }
    return self;
}

- (void)setDealStatus:(YYDealStatusType)dealStatus date:(NSString *)date dealCode:(NSString *)dealCode
{
    switch (dealStatus) {
        case YYDealStatusTypeFinish:
            self.statusLabel.text = @"交易完成";
            break;
        case YYDealStatusTypeWaitForPay:
            self.statusLabel.text = @"待支付";
            break;
        case YYDealStatusTypeWaitForTakeOrder:
            self.statusLabel.text = @"待接单";
            break;
        case YYDealStatusTypeWaitForComment:
            self.statusLabel.text = @"待评论";
            break;
        case YYDealStatusTypeWaitForReturn:
            self.statusLabel.text = @"待归还";
            break;
        case YYDealStatusTypeWaitForRecieve:
            self.statusLabel.text = @"待收货";
            break;
        case YYDealStatusTypeWaitForDelivery:
            self.statusLabel.text = @"待发货";
            break;
        case YYDealStatusTypeWaitForSubmit:
            self.statusLabel.text = @"商家已确认";
            break;
        default:
            break;
    }
}

@end
