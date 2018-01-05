//
//  YYSearchBar.m
//  DDFood
//
//  Created by YZ Y on 16/6/3.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYSearchBar.h"

@interface YYSearchBar () <UITextFieldDelegate>
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *leftLine;
@property (nonatomic, weak) UILabel *rightLine;
@property (nonatomic, weak) UILabel *bottomLine;
@property (nonatomic, weak) UILabel *textLabel;

@end

@implementation YYSearchBar

- (UITextField *)textField {
    if (!_textField) {
        UITextField *textField = [UITextField new];
        textField.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        textField.placeholder = @"商品搜索";
        textField.returnKeyType = UIReturnKeySearch;
        textField.backgroundColor = [UIColor clearColor];
        textField.delegate = self;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.returnKeyType = UIReturnKeyDone;
        [self addSubview:textField];
        _textField = textField;
    }
    return _textField;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_search"]];
        [self addSubview:imgView];
        _imgView = imgView;
    }
    return _imgView;
}

- (UILabel *)rightLine {
    if (!_rightLine) {
        UILabel *rightLine = [UILabel new];
        rightLine.backgroundColor = YYGlobalColor;
        [self addSubview:rightLine];
        _rightLine = rightLine;
    }
    return _rightLine;
}

- (UILabel *)leftLine {
    if (!_leftLine) {
        UILabel *leftLine = [UILabel new];
        leftLine.backgroundColor = YYGlobalColor;
        [self addSubview:leftLine];
        _leftLine = leftLine;
    }
    return _leftLine;
}

- (UILabel *)bottomLine {
    if (!_bottomLine) {
        UILabel *bottomLine = [UILabel new];
        bottomLine.backgroundColor = YYGlobalColor;
        [self addSubview:bottomLine];
        _bottomLine = bottomLine;
    }
    return _bottomLine;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYPlaceHolderColor;
        label.text = @"商品搜索";
        [self addSubview:label];
        _textLabel = label;
    }
    return _textLabel;
}


- (instancetype)init
{
    if (self = [super init]) {
        [self textField];
        [self textLabel];
        [self imgView];
        [self leftLine];
        [self bottomLine];
        [self rightLine];
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
        self.hideLine = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(WIN_WIDTH - (_isFull ? 0 : 88) - RELATIVE_WIDTH(40), RELATIVE_WIDTH(66));
}

- (void)setHideLine:(BOOL)hideLine
{
    _hideLine = hideLine;
    self.leftLine.hidden = !hideLine;
    self.rightLine.hidden = !hideLine;
    self.bottomLine.hidden = !hideLine;
}

- (void)setLeftImage:(BOOL)leftImage
{
    _leftImage = leftImage;
    
}

- (void)setBlackStyle:(BOOL)blackStyle
{
    [self.imgView setImage:[UIImage imageNamed:@"search_black"]];
}

- (void)setFullStyle:(BOOL)fullStyle
{
    _fullStyle = fullStyle;
}

- (void)setText:(NSString *)text
{
    if (text.length > 0) {
        self.textLabel.text = text;
        self.textLabel.textColor = YYTextColor;
    }
}

- (void)setType:(YYSearchBarType)type
{
    _type = type;
    self.textLabel.hidden = _type == YYSearchBarTypeTextField;
    self.textField.hidden = !(_type == YYSearchBarTypeTextField);
    if (_type == YYSearchBarTypeLabel || _type == YYSearchBarTypeNavi) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabel)];
        [self addGestureRecognizer:tap];
    }
}

- (void)tapLabel
{
    if (_showSearchViewBlock != nil) {
        _showSearchViewBlock();
    }
}

#pragma mark - UITextFieldDelegate

#pragma mark - 监控实时文字
- (void)textFieldDidChange:(NSNotification *)noti
{
    UITextField *textField = (UITextField *)noti.object;
    NSString *textString = textField.text;
    //    NSString lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    //    currentInputMode 在ios7之后弃用了。用下面的。
    NSString *lang = textField.textInputMode.primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计、限制等处理
        if (!position) {
            NSLog(@"textString = %@", textString);
        }else{
            // 有高亮选择的字符串，则暂不对文字进行统计、限制等处理
        }
    }else{
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        NSLog(@"textString = %@", textString);
    }
    
    if (_didChangeTextBlock != nil) {
        _didChangeTextBlock(textString);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string
{
    NSString *current = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (_didChangeTextBlock) {
        _didChangeTextBlock(current);
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_endEdite) {
        _endEdite(self.textField.text);
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    WS(ws);
    CGSize imgSize = self.imgView.image.size;

    
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).offset(RELATIVE_WIDTH(28));
        make.size.mas_equalTo(imgSize);
        make.centerY.equalTo(ws.mas_centerY);
    }];
    
    if (_type == YYSearchBarTypeLabel) {
        [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.height.right.equalTo(ws);
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(12));
        }];
    } else {
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.height.right.equalTo(ws);
//            make.left.equalTo(ws.mas_left).offset(RELATIVE_WIDTH(12));
            make.left.equalTo(self.imgView.mas_right).offset(RELATIVE_WIDTH(12));
        }];
    }
    
}

@end
