//
//  YYCommentSelectImageViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCommentSelectImageViewCell.h"

@interface YYCommentSelectImageViewCell ()
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UIButton *deleteButton;
@property (nonatomic, weak) UILabel *infoLabel;
@property (nonatomic, weak) UILabel *countLabel;

@end

@implementation YYCommentSelectImageViewCell

{
    CAShapeLayer *_border;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *imgView = [UIImageView new];
        [self.contentView addSubview:imgView];
        _imgView = imgView;
    }
    return _imgView;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"ic_cancel"] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        _deleteButton = button;
    }
    return _deleteButton;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.backgroundColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        _infoLabel = label;
    }
    return _infoLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self imgView];
    }
    return self;
}

- (void)setIsCamera:(BOOL)isCamera
{
    _isCamera = isCamera;
    
    WS(ws);
    if (isCamera) {
        if (_deleteButton) {
            [_deleteButton removeFromSuperview];
        }
        self.imgView.image = [UIImage imageNamed:@"tab_icon_show_n"];
        self.infoLabel.text = @"增加照片最多3张";
        [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(30));
            make.centerX.equalTo(ws.contentView);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
        }];
        
        [self.infoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView.mas_bottom).offset(RELATIVE_WIDTH(8));
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(30));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(30));
            make.height.greaterThanOrEqualTo(@(RELATIVE_WIDTH(26)));
        }];
        
        CAShapeLayer *border = [CAShapeLayer layer];
        
        border.strokeColor = YYGrayTextColor.CGColor;
        
        border.fillColor = nil;
        
        border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        
        border.frame = self.bounds;
        
        border.lineWidth = 1.f;
        
        border.lineCap = @"square";
        
        border.lineDashPattern = @[@4, @4];
        _border = border;
        [self.layer addSublayer:border];
        
    } else {
        if (_infoLabel) {
            [_infoLabel removeFromSuperview];
        }
        
        [self.deleteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(ws.contentView);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(50));
        }];
        
        [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws.contentView);
        }];
        if (_border) {
            [_border removeFromSuperlayer];
        }        
    }
    
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imgView.image = image;
}

- (void)deleteAction
{
    if (_deleteActionBlock) {
        _deleteActionBlock(_image, _indexPath);
    }
}

@end
