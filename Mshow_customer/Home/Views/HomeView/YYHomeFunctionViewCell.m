//
//  YYHomeFunctionViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHomeFunctionViewCell.h"

@implementation YYHomeFunctionViewCell

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imgView = [[UIImageView alloc] init];
//        imgView.contentMode = UIViewContentModeCenter;
        imgView.layer.cornerRadius = RELATIVE_WIDTH(40);
        imgView.layer.masksToBounds = YES;
        [self.contentView addSubview:imgView];
        _imageView = imgView;
    }
    return _imageView;
}

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


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        WS(ws);
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(40));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(80));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(RELATIVE_WIDTH(10));
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(4));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(4));
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
        }];
    }
    return self;
}

@end
