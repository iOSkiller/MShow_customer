//
//  YYCommentDefectSelectionViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCommentDefectSelectionViewCell.h"
#import "YYDefectModel.h"

@interface YYCommentDefectSelectionViewCell ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation YYCommentDefectSelectionViewCell

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"]];
        [self.contentView addSubview:view];
        _imageView = view;
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self imageView];
        [self titleLabel];
        WS(ws);
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
            make.centerY.equalTo(ws.contentView);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(ws.contentView);
            make.width.greaterThanOrEqualTo(@0.0f);
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.left.equalTo(self.imageView.mas_right).offset(RELATIVE_WIDTH(10));
        }];
        
    }
    return self;
}

- (void)setDefectModel:(YYDefectModel *)defectModel
{
    _defectModel = defectModel;
    self.titleLabel.text = defectModel.content;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    self.imageView.image = isSelected ? [UIImage imageNamed:@"wardrobe_btn_choose_pre"] : [UIImage imageNamed:@"wardrobe_btn_choose_n"];
}


@end
