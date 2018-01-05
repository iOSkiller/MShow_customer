//
//  YYSelectSceneViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectSceneViewCell.h"
@interface YYSelectSceneViewCell ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *sceneLabel;

@end

@implementation YYSelectSceneViewCell

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *view = [UIImageView new];
        view.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:view];
        _imageView = view;
    }
    return _imageView;
}

- (UILabel *)sceneLabel {
    if (!_sceneLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = mRGBAColor(0, 0, 0, 0.75);
        label.text = @"ALO";
        [self.contentView addSubview:label];
        _sceneLabel = label;
    }
    return _sceneLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self imageView];
        [self sceneLabel];
        
        WS(ws);
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws.contentView);
        }];
        
        [self.sceneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(ws.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(60));
        }];
    }
    return self;
}


@end
