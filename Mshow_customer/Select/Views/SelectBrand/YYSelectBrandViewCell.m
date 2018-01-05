//
//  YYSelectBrandViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectBrandViewCell.h"
#import "YYImageTextView.h"
#import "YYBrandModel.h"

@interface YYSelectBrandViewCell ()
@property (nonatomic, weak) YYImageTextView *imageTextView;
@property (nonatomic, weak) UILabel *brandLabel;

@end

@implementation YYSelectBrandViewCell

- (YYImageTextView *)imageTextView {
    if (!_imageTextView) {
        YYImageTextView *view = [[YYImageTextView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(80), RELATIVE_WIDTH(80))];
        view.label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(20)];
        [self.contentView addSubview:view];
        _imageTextView = view;
    }
    return _imageTextView;
}

- (UILabel *)brandLabel {
    if (!_brandLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.textColor = mRGBToColor(0x646464);
        label.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _brandLabel = label;
    }
    return _brandLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self imageTextView];
        [self brandLabel];
        
        WS(ws);
        [self.imageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
            make.centerY.equalTo(ws.contentView);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(80), RELATIVE_WIDTH(80)));
        }];
        
        [self.brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(self.imageTextView.mas_right).offset(RELATIVE_WIDTH(16));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(20));
            make.height.mas_equalTo(RELATIVE_WIDTH(28));
        }];
    }
    return self;
}

- (void)setModel:(YYBrandModel *)model
{
    _model = model;
    self.imageTextView.label.text = @"ADFHTDCV";
    self.brandLabel.text = @"ADFHTDCV";
}


@end
