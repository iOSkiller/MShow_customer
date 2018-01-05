//
//  YYMineHeaderView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineHeaderView.h"
#import "YYMineFunctionView.h"
#import "YYUserModel.h"

@interface YYMineHeaderView ()
@property (nonatomic, weak) UILabel *nickNameLabel;
@property (nonatomic, weak) UILabel *levelLabel;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UIButton *settingButton;
@property (nonatomic, weak) UIButton *messageButton;
@property (nonatomic, weak) UILabel *bonusPointsLabel;
@property (nonatomic, weak) UILabel *countLabel;
@property (nonatomic, weak) YYMineFunctionView *functionView;

@end

@implementation YYMineHeaderView

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xf3615f);
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        label.text = @"请登录";
        [self addSubview:label];
        _nickNameLabel = label;
    }
    return _nickNameLabel;
}

- (UILabel *)levelLabel {
    if (!_levelLabel) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = mRGBToColor(0xf9b1b0);
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(20)];
        label.layer.cornerRadius = RELATIVE_WIDTH(18);
        label.layer.masksToBounds = YES;
        label.text = @"初级麻豆";
        label.hidden = YES;
        [self addSubview:label];
        _levelLabel = label;
    }
    return _levelLabel;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [UIImageView new];
        view.layer.cornerRadius = RELATIVE_WIDTH(67);
        view.layer.borderColor = [UIColor whiteColor].CGColor;
        view.layer.borderWidth = RELATIVE_WIDTH(2);
        view.layer.masksToBounds = YES;
        view.userInteractionEnabled = YES;
        view.image = [UIImage imageNamed:@"login_logo"];
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
        _imgView = view;
    }
    return _imgView;
}

- (UIButton *)settingButton {
    if (!_settingButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_set"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _settingButton = button;
    }
    return _settingButton;
}

- (UIButton *)messageButton {
    if (!_messageButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_informationwhite"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _messageButton = button;
    }
    return _messageButton;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = YYGlobalColor;
        label.layer.cornerRadius = RELATIVE_WIDTH(30);
        label.layer.masksToBounds = YES;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.hidden = YES;
        [self addSubview:label];
        _countLabel = label;
    }
    return _countLabel;
}

- (UILabel *)bonusPointsLabel {
    if (!_bonusPointsLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = YYGlobalColor;
        label.layer.borderColor = [UIColor whiteColor].CGColor;
        label.layer.borderWidth = RELATIVE_WIDTH(1);
        label.layer.cornerRadius = RELATIVE_WIDTH(18);
        label.layer.masksToBounds = YES;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(20)];
        label.text = @"积分100";
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBonusPointAction)];
        [label addGestureRecognizer:tap];
        label.hidden = YES;
        [self addSubview:label];
        _bonusPointsLabel = label;
    }
    return _bonusPointsLabel;
}

- (YYMineFunctionView *)functionView {
    if (!_functionView) {
        YYMineFunctionView *view = [[YYMineFunctionView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(150))];
        view.backgroundColor = YYGlobalColor;
        [view setTitleArray:@[@"收藏", @"优惠券", @"余额", @"足迹"] imageArray:@[@"img_my_collect"] countArray:@[@"3", @"0.00", @"100"]];
        view.hidden = YES;
        [self addSubview:view];
        _functionView = view;
    }
    return _functionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = mRGBToColor(0xf3615f);
        [self imgView];
        [self nickNameLabel];
        [self levelLabel];
        [self settingButton];
        [self messageButton];
        [self countLabel];
        self.functionView.tapActionBlock = ^(NSUInteger index) {
            YYMineFunctionType type = YYMineFunctionTypeCollection;
            switch (index) {
                case 0:
                    type = YYMineFunctionTypeCollection;
                    break;
                case 1:
                    type = YYMineFunctionTypeCoupon;
                    break;
                case 2:
                    type = YYMineFunctionTypeWallet;
                    break;
                case 3:
                    type = YYMineFunctionTypeHistory;
                    break;
                default:
                    break;
            }
            if (_functionActionBlock) {
                _functionActionBlock(type);
            }
        };
        self.userInteractionEnabled = YES;
        
        WS(ws);
        
        [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(100));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(134));
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
        }];
        
        [self.messageButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(64));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(24));
        }];
        
        [self.settingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.equalTo(self.messageButton);
            make.right.equalTo(self.messageButton.mas_left).offset(-RELATIVE_WIDTH(32));
        }];
        
        [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.messageButton.imageView.mas_top);
            make.centerX.equalTo(self.messageButton.imageView.mas_right);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(60));
        }];
        
        [self.functionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(150));
            make.top.equalTo(self.imgView.mas_bottom);
        }];
        
    }
    return self;
}

- (void)setUserModel:(YYUserModel *)userModel
{
    WS(ws);
    
    if ((mAppDelegate).isLogin) {
        self.nickNameLabel.text = @"妞妞哑";
        self.levelLabel.hidden = NO;
        self.bonusPointsLabel.hidden = NO;
        self.functionView.hidden = NO;
//        self.countLabel.hidden = NO;
        [self.nickNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(120));
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(36));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(300), RELATIVE_WIDTH(36)));
        }];
        
        [self.levelLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nickNameLabel.mas_bottom).offset(RELATIVE_WIDTH(20));
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(36));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(130), RELATIVE_WIDTH(36)));
        }];
        
        [self.bonusPointsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.levelLabel.mas_right).offset(RELATIVE_WIDTH(20));
            make.centerY.equalTo(self.levelLabel);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(130), RELATIVE_WIDTH(36)));
        }];
        
    } else {
        self.nickNameLabel.text = @"请登录";
        self.levelLabel.hidden = YES;
        self.bonusPointsLabel.hidden = YES;
        self.functionView.hidden = YES;
//        self.countLabel.hidden = YES;
        
        [self.nickNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.imgView);
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(36));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(300), RELATIVE_WIDTH(36)));
        }];
        
    }
    
    
}

- (void)settingAction
{
    if (_setActionBlock) {
        _setActionBlock();
    }
}

- (void)messageAction
{
    if (_messageActionBlock) {
        _messageActionBlock();
    }
}

- (void)tapAction
{
    if (_tapActionBlock) {
        _tapActionBlock();
    }
}

- (void)showBonusPointAction
{
    if (_showBonusPointsActionBlock) {
        _showBonusPointsActionBlock();
    }
}

@end
