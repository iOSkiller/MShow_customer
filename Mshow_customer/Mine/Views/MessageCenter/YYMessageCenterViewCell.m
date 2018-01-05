//
//  YYMessageCenterViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMessageCenterViewCell.h"
#import "YYMessageModel.h"

@interface YYMessageCenterViewCell ()
@property (nonatomic, weak) UILabel *typeLabel;
@property (nonatomic, weak) UILabel *statusLabel;
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UIImageView *iconView;

@end

@implementation YYMessageCenterViewCell

- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *view = [UIImageView new];
        view.layer.cornerRadius = RELATIVE_WIDTH(34);
        view.layer.borderColor = mRGBToColor(0xc1c1c1).CGColor;
        view.layer.borderWidth = RELATIVE_WIDTH(2);
        view.layer.masksToBounds = YES;
        view.backgroundColor = [UIColor whiteColor];
        view.contentMode = UIViewContentModeScaleAspectFit;
//        view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        view.clipsToBounds = YES;
        [self.contentView addSubview:view];
        _iconView = view;
    }
    return _iconView;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [self.contentView addSubview:label];
        _typeLabel = label;
    }
    return _typeLabel;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        [self.contentView addSubview:label];
        _statusLabel = label;
    }
    return _statusLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        _dateLabel = label;
    }
    return _dateLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self iconView];
        [self typeLabel];
        [self dateLabel];
        [self statusLabel];
        
        WS(ws);
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(68));
        }];
        
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(RELATIVE_WIDTH(20));
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(20));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(200), RELATIVE_WIDTH(32)));
        }];
        
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.typeLabel.mas_bottom).offset(RELATIVE_WIDTH(8));
            make.left.width.equalTo(self.typeLabel);
            make.height.mas_equalTo(RELATIVE_WIDTH(26));
        }];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(24));
            make.centerY.equalTo(ws.contentView);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(255), RELATIVE_WIDTH(26)));
        }];
    }
    return self;
}

- (void)setMessageModel:(YYMessageModel *)messageModel
{
    _messageModel = messageModel;
    NSString *icon = @"img_logistics";
    NSString *type = @"物流通知";
    NSString *status = @"今日新品";
    switch (messageModel.messageType) {
        case YYMessageTypeDelivery:
            icon = @"img_logistics";
        {
            switch (messageModel.dealType) {
                case YYDealStatusTypeWaitForRecieve:
                    status = @"订单已发货";
                    break;
                
                default:
                    break;
            }
            break;
        }
        case YYMessageTypeNews:
        {
            icon = @"login_logo";
            type = @"M秀通知";
            break;
        }
    }
    self.iconView.image = [UIImage imageNamed:icon];
    self.typeLabel.text = type;
    self.statusLabel.text = status;
    self.dateLabel.text = messageModel.date;
}




@end
