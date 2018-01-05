//
//  YYConsumerdetailsViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYConsumerdetailsViewCell.h"

@interface YYConsumerdetailsViewCell ()
@property (nonatomic, weak) UILabel *consumeLabel;
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UILabel *feeLabel;

@end

@implementation YYConsumerdetailsViewCell

- (UILabel *)consumeLabel {
    if (!_consumeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.text = @"秋季时尚大衣";
        [self.contentView addSubview:label];
        _consumeLabel = label;
    }
    return _consumeLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.text = @"2017.09.29  10:00";
        [self.contentView addSubview:label];
        _dateLabel = label;
    }
    return _dateLabel;
}

- (UILabel *)feeLabel {
    if (!_feeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(30)];
        label.text = @"-￥10.00";
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        _feeLabel = label;
    }
    return _feeLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self consumeLabel];
        [self dateLabel];
        [self feeLabel];
        WS(ws);
        [self.consumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(20));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(420), RELATIVE_WIDTH(32)));
        }];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.contentView).mas_equalTo(-RELATIVE_WIDTH(20));
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(420), RELATIVE_WIDTH(26)));
        }];
        
        [self.feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(24));
            make.centerY.equalTo(ws.contentView);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(200), RELATIVE_WIDTH(32)));
        }];
    }
    return self;
}

@end
