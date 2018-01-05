//
//  YYSubscribeReturnGoodsViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSubscribeReturnGoodsViewCell.h"
#import "YYAddressInfoView.h"

@interface YYSubscribeReturnGoodsViewCell ()
@property (nonatomic, weak) YYAddressInfoView *addressInfoView;
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation YYSubscribeReturnGoodsViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(30)];
        self.textLabel.textColor = YYTextColor;
        self.detailTextLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        self.detailTextLabel.textColor = YYGrayTextColor;
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_arrow_right"]];
        arrow.frame = CGRectMake(0, 0, RELATIVE_WIDTH(26), RELATIVE_WIDTH(26));
        self.accessoryView = arrow;
    }
    return self;
}

- (void)setType:(YYSubscribeReturnGoodsViewCellType)type
{
    _type = type;
    switch (type) {
        case YYSubscribeReturnGoodsViewCellTypeDate:
            break;
        case YYSubscribeReturnGoodsViewCellTypeAddress:
        {
            YYAddressInfoView *view = [[YYAddressInfoView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(60), WIN_WIDTH, RELATIVE_WIDTH(160))];
            view.hideLine = YES;
            view.hideTagView = YES;
            [self.contentView addSubview:view];
            _addressInfoView = view;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(26), RELATIVE_WIDTH(26), RELATIVE_WIDTH(140), RELATIVE_WIDTH(32))];
            label.backgroundColor = [UIColor whiteColor];
            label.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(30)];
            label.textColor = YYTextColor;
            [self.contentView addSubview:label];
            _titleLabel = label;
            
        }
            break;
        default:
            break;
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

@end
