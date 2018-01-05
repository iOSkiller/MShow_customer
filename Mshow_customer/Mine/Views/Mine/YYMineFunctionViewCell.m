//
//  YYMineFunctionViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineFunctionViewCell.h"

@interface YYMineFunctionViewCell ()
@property (nonatomic, weak) UIImageView *imgView;

@property (nonatomic, weak) UILabel *countLabel;
@property (nonatomic, weak) UILabel *countInfoLabel;

@end

@implementation YYMineFunctionViewCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)countInfoLabel {
    if (!_countInfoLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        [self.contentView addSubview:label];
        WS(ws);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(8));
            make.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(44));
        }];
        _countInfoLabel = label;
    }
    return _countInfoLabel;
}


- (UILabel *)countLabel {
    if (!_countLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = YYGlobalColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(16)];
        label.layer.cornerRadius = RELATIVE_WIDTH(13);
        label.layer.masksToBounds = YES;
        label.hidden = YES;
        [self.contentView addSubview:label];
        _countLabel = label;
    }
    return _countLabel;
}


- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [UIImageView new];
        [self.contentView addSubview:view];
        _imgView = view;
    }
    return _imgView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self imgView];
        [self titleLabel];
        [self countLabel];
    }
    return self;
}

- (void)setImage:(UIImage *)image title:(NSString *)title
{
    self.imgView.image = image;
    self.titleLabel.text = title;
    
    WS(ws);
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
        make.centerX.equalTo(ws.contentView);
        make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(8));
    }];
    
    if (!self.countLabel.hidden) {
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(26));
            make.centerX.equalTo(self.imgView.mas_right);
        }];
    }
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).offset(RELATIVE_WIDTH(10));
        make.left.right.equalTo(ws.contentView);
        make.height.mas_equalTo(RELATIVE_WIDTH(32));
    }];
}

- (void)setTitle:(NSString *)title countInfo:(NSString *)countInfo
{
    WS(ws);
    self.titleLabel.text = title;
    self.countInfoLabel.text = countInfo;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countInfoLabel.mas_bottom).offset(RELATIVE_WIDTH(10));
        make.left.right.equalTo(ws.contentView);
        make.height.mas_equalTo(RELATIVE_WIDTH(32));
    }];
}

@end
