//
//  YYMineInvateViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineInvateViewCell.h"
#import "YYButton.h"

@interface YYMineInvateViewCell ()
@property (nonatomic, weak) UIButton *invateButton;
@property (nonatomic, weak) YYButton *seeButton;

@end

@implementation YYMineInvateViewCell

- (UIButton *)invateButton {
    if (!_invateButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"立即邀请好友" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        button.backgroundColor = YYGlobalColor;
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        button.frame = CGRectMake(RELATIVE_WIDTH(226), RELATIVE_WIDTH(50), RELATIVE_WIDTH(300), RELATIVE_WIDTH(80));
        [button addTarget:self action:@selector(invateAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        WS(ws);
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(50));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(300), RELATIVE_WIDTH(80)));
            make.centerX.equalTo(ws.contentView);
        }];
        _invateButton = button;
    }
    return _invateButton;
}

- (YYButton *)seeButton {
    if (!_seeButton) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        [button setRightImage:[UIImage imageNamed:@"img_arrow_right"] selectedRightImage:nil leftTitle:@"查看奖励" selectedLeftTitle:nil];
        button.titleFont = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(seeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        WS(ws);
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.invateButton.mas_bottom).offset(RELATIVE_WIDTH(20));
            make.centerX.equalTo(ws.contentView);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(180), RELATIVE_WIDTH(32)));
        }];
        _seeButton = button;
    }
    return _seeButton;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textColor = YYTextColor;
        self.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        self.detailTextLabel.textColor = YYTextColor;
        self.detailTextLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
    }
    return self;
}

- (void)setShowButton:(BOOL)showButton
{
    showButton = showButton;
    [self invateButton];
    [self seeButton];
}

- (void)invateAction
{
    if (_invateActionBlock) {
        _invateActionBlock();
    }
}

- (void)seeAction
{
    if (_seeActionBlock) {
        _seeActionBlock();
    }
}

@end
