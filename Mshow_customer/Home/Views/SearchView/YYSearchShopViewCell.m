//
//  YYSearchShopViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/2.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSearchShopViewCell.h"


@implementation YYSearchShopViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        self.textLabel.textColor = YYTextColor;
        self.detailTextLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        self.detailTextLabel.textColor = YYGrayTextColor;
        
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        WS(ws);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
            make.centerY.equalTo(ws.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(30));
            make.width.greaterThanOrEqualTo(@0);
        }];
        _distanceLabel = label;
    
    }
    return self;
}

@end
