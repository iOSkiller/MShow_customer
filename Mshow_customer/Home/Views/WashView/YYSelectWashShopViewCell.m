//
//  YYSelectWashShopViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/2.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectWashShopViewCell.h"
#import "YYShopModel.h"
#import "YYButton.h"

@interface YYSelectWashShopViewCell ()
@property (nonatomic, weak) UILabel *shopLabel;
@property (nonatomic, weak) UILabel *addressLabel;
@property (nonatomic, weak) UILabel *phoneLabel;

@end

@implementation YYSelectWashShopViewCell

- (UILabel *)shopLabel {
    if (!_shopLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        [self.contentView addSubview:label];
        WS(ws);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.greaterThanOrEqualTo(@0);
        }];
        _shopLabel = label;
    }
    return _shopLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.textColor = YYGrayTextColor;
        [self.contentView addSubview:label];
        WS(ws);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(24));
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(28));
            make.width.greaterThanOrEqualTo(@0);
        }];
        _addressLabel = label;
    }
    return _addressLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.textColor = YYGrayTextColor;
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        WS(ws);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.greaterThanOrEqualTo(@0);
        }];
        _phoneLabel = label;
    }
    return _phoneLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        self.textLabel.textColor = YYTextColor;
        self.detailTextLabel.textColor = YYGrayTextColor;
        self.detailTextLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
    }
    return self;
}

- (void)setType:(YYSelectWashShopViewCellType)type
{
    _type = type;
    switch (type) {
        case YYSelectWashShopViewCellTypeAddress:
        {
            YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
            [button setLeftImage:[UIImage imageNamed:@"img_positioning"] selectedLeftImage:nil rightTitle:@"重新定位" selectedRightTitle:nil];
            button.normalColor = YYTextColor;
            button.titleFont = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
            button.frame = CGRectMake(0, 0, RELATIVE_WIDTH(170), RELATIVE_WIDTH(44));
//            [self.contentView addSubview:button];
//            WS(ws);
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
//                make.centerY.equalTo(ws.contentView);
//                make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(180), RELATIVE_WIDTH(44)));
//            }];
            self.accessoryView = button;
            break;
        }
        case YYSelectWashShopViewCellTypeNearbyShop:
        {
            break;
        }
        case YYSelectWashShopViewCellTypeHistoryShop:
        {
            [self shopLabel];
            [self addressLabel];
            [self phoneLabel];
            break;
        }
        default:
            break;
    }
}

- (void)setShopModel:(YYShopModel *)shopModel
{
    _shopModel = shopModel;
    self.shopLabel.text = shopModel.shopName;
    self.addressLabel.text = shopModel.address;
    self.phoneLabel.text = shopModel.phone;
}

@end
