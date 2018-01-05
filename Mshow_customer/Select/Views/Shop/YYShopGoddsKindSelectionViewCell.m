//
//  YYShopGoddsKindSelectionViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/29.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShopGoddsKindSelectionViewCell.h"

@implementation YYShopGoddsKindSelectionViewCell
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = YYSeparatorColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = YYSeparatorColor;
        [self contentLabel];
        WS(ws);
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(26));
            make.centerY.equalTo(ws.contentView);
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
            make.height.greaterThanOrEqualTo(@(RELATIVE_WIDTH(32)));
        }];
    }
    return self;
}

@end
