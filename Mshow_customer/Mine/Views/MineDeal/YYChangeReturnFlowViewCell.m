//
//  YYChangeReturnFlowViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYChangeReturnFlowViewCell.h"

@implementation YYChangeReturnFlowViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *statusLabel = [UILabel new];
        statusLabel.backgroundColor = mRGBToColor(0xf4f4f4);
        statusLabel.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(24)];
        statusLabel.textColor = YYGrayTextColor;
        statusLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:statusLabel];
        _statusLabel = statusLabel;
        
        UILabel *dateLabel = [UILabel new];
        dateLabel.backgroundColor = mRGBToColor(0xf4f4f4);
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(18)];
        dateLabel.textColor = YYGrayTextColor;
        [self.contentView addSubview:dateLabel];
        _dateLabel = dateLabel;
        WS(ws);
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(20));
            make.width.greaterThanOrEqualTo(@0);
            make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(0));
        }];
        
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws.contentView);
            make.bottom.equalTo(self.dateLabel.mas_top).offset(-RELATIVE_WIDTH(8));
            make.height.mas_equalTo(RELATIVE_WIDTH(26));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
    }
    return self;
}
@end
