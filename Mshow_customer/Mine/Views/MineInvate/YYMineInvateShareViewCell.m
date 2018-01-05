//
//  YYMineInvateShareViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineInvateShareViewCell.h"

@interface YYMineInvateShareViewCell ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *imgView;

@end

@implementation YYMineInvateShareViewCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [UIImageView new];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _imgView = view;
    }
    return _imgView;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self titleLabel];
        [self imgView];
        WS(ws);
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
        }];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView);
            make.centerX.equalTo(ws.contentView);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(60));
            
        }];
    }
    return self;
}

- (void)setImage:(UIImage *)image title:(NSString *)title
{
    self.imgView.image = image;
    self.titleLabel.text = title;
}

@end
