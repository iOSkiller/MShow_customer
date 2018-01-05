//
//  YYMineInfoViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineInfoViewCell.h"

@interface YYMineInfoViewCell ()

@property (nonatomic, weak) UIImageView *arrowView;

@end

@implementation YYMineInfoViewCell

- (UIImageView *)arrowView {
    if (!_arrowView) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_arrow_right"]];
        [self.contentView addSubview:arrowView];
        _arrowView = arrowView;
    }
    return _arrowView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       
        self.textLabel.textColor = YYTextColor;
        self.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        
        self.detailTextLabel.textColor = YYGrayTextColor;
        self.detailTextLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        self.detailTextLabel.textAlignment = NSTextAlignmentRight;
//        [self arrowView];
    }
    return self;
}

- (void)setType:(YYMineFunctionType)type
{
    _type = type;
    if (type == YYMineInfoTypeIcon) {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.layer.cornerRadius = RELATIVE_WIDTH(50);
        imageView.layer.masksToBounds = YES;
        imageView.image = [UIImage imageNamed:@"login_logo"];
        [self.contentView addSubview:imageView];
        _imgView = imageView;
        WS(ws);
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(RELATIVE_WIDTH(100));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(20));
            make.centerY.equalTo(ws.contentView);
        }];
    }
    
}



@end
