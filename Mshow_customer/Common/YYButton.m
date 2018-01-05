//
//  YYButton.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYButton.h"

@interface YYButton ()

@end

@implementation YYButton
{
    NSString *_title;
    NSString *_selectedTitle;
    UIImage *_image;
    UIImage *_selectedImage;
    YYButtonImageDirection _imageDirection;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [UIImageView new];
        [self addSubview:view];
        _imgView = view;
    }
    return _imgView;
}

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        [self addSubview:label];
        _label = label;
    }
    return _label;
}

- (void)setLeftImage:(UIImage *)leftImage selectedLeftImage:(UIImage *)selectedLeftImage rightTitle:(NSString *)rightTitle selectedRightTitle:(NSString *)selectedRightTitle
{
    _imageDirection = YYButtonImageDirectionLeft;
    _title = rightTitle;
    _selectedTitle = selectedRightTitle;
    _image = leftImage;
    _selectedImage = selectedLeftImage;
    
    self.imgView.image = leftImage;
    self.label.text = rightTitle;
    self.label.textAlignment = NSTextAlignmentRight;
    WS(ws);
    
    [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws);
        make.centerY.equalTo(ws);
        make.height.mas_equalTo(RELATIVE_WIDTH(30));
        make.width.greaterThanOrEqualTo(@0);
//        make.right.equalTo(ws).offset(-RELATIVE_WIDTH(8));
    }];
    
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws);
        make.centerY.equalTo(ws);
        make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
    }];
    
}

- (void)setRightImage:(UIImage *)rightImage selectedRightImage:(UIImage *)selectedRightImage leftTitle:(NSString *)leftTitle selectedLeftTitle:(NSString *)selectedLeftTitle
{
    _imageDirection = YYButtonImageDirectionRight;
    _title = leftTitle;
    _selectedTitle = selectedLeftTitle;
    _image = rightImage;
    _selectedImage = selectedRightImage;
    
    self.imgView.image = rightImage;
    self.imgView.backgroundColor = [UIColor whiteColor];
    self.label.text = leftTitle;
    self.label.textColor = YYGrayTextColor;
    self.label.backgroundColor = [UIColor whiteColor];
//    CGFloat labelWidth = [leftTitle getStringRect:self.label.font size:CGSizeMake(MAXFLOAT, RELATIVE_WIDTH(30))].size.width + RELATIVE_WIDTH(10);
    WS(ws);
    [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(ws).offset(RELATIVE_WIDTH(6));
        make.center.equalTo(ws);
        make.height.mas_equalTo(RELATIVE_WIDTH(30));
//        make.width.mas_equalTo(labelWidth);
        make.width.greaterThanOrEqualTo(@0);
    }];
    
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label.mas_right);
        make.centerY.equalTo(ws);
        make.width.height.mas_equalTo(RELATIVE_WIDTH(30));
    }];
}

- (void)setTopImage:(UIImage *)topImage selectedTopImage:(UIImage *)selectedTopImage bottomTitle:(NSString *)bottomTitle selctedBottomTitle:(NSString *)selctedBottomTitle
{
    _imageDirection = YYButtonImageDirectionTop;
    _image = topImage;
    _selectedImage = selectedTopImage;
    _title = bottomTitle;
    _selectedTitle = selctedBottomTitle;
    self.imgView.image = topImage;
    self.label.text = bottomTitle;
    self.label.textAlignment = NSTextAlignmentCenter;
    WS(ws);
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).offset(RELATIVE_WIDTH(10));
        make.centerX.equalTo(ws);
        make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
    }];
    
    [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws).offset(-RELATIVE_WIDTH(10));
        make.centerX.equalTo(ws);
        make.width.greaterThanOrEqualTo(@0);
        make.height.mas_equalTo(RELATIVE_WIDTH(30));
    }];
}

- (void)setTitleLeftMargin:(CGFloat)titleLeftMargin
{
    WS(ws);
    
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws);
        make.centerY.equalTo(ws);
        make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
    }];
    
    [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(titleLeftMargin);
        make.centerY.equalTo(ws);
        make.height.mas_equalTo(RELATIVE_WIDTH(30));
        make.width.greaterThanOrEqualTo(@0);
    }];
}

- (void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    self.label.textColor = normalColor;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    self.label.font = titleFont;
}

- (void)setImageSize:(CGSize)imageSize
{
    if (imageSize.width == 0 || imageSize.height == 0) {
        return;
    } else {
        WS(ws);
        
        switch (_imageDirection) {
            case YYButtonImageDirectionRight:
            {
                [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(ws);
                    make.centerY.equalTo(ws);
                    make.size.mas_equalTo(imageSize);
                }];
                
                [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(ws);
                    make.centerY.equalTo(ws);
                    make.height.equalTo(ws);
                    make.width.greaterThanOrEqualTo(@0);
                }];
            }
                break;
            case YYButtonImageDirectionLeft:
            {
                [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(ws);
                    make.centerY.equalTo(ws);
                    make.size.mas_equalTo(imageSize);
                }];
                
                [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(6));
                    make.centerY.equalTo(ws);
                    make.height.equalTo(ws);
                    make.width.greaterThanOrEqualTo(@0);
                }];
                
            }
                break;
            case YYButtonImageDirectionTop:
            {
                [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(ws).offset(RELATIVE_WIDTH(10));
                    make.centerX.equalTo(ws);
                    make.size.mas_equalTo(imageSize);
                }];
                
                [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(ws).offset(-RELATIVE_WIDTH(10));
                    make.centerX.equalTo(ws);
                    make.width.greaterThanOrEqualTo(@0);
                    make.height.mas_equalTo(RELATIVE_WIDTH(30));
                }];
            }
                break;
            default:
                break;
        }
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        if (_selectedImage) {
            self.imgView.image = _selectedImage;
        }
        if (_selectedTitle) {
            self.label.text = _selectedTitle;
        }
        if (_selectedColor) {
            self.label.textColor = _selectedColor;
        }
    } else {
        self.imgView.image = _image;
        self.label.text = _title;
        if (_normalColor) {
            self.label.textColor = _normalColor;
        }
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.label.backgroundColor = backgroundColor;
    self.imgView.backgroundColor = backgroundColor;
}


@end
