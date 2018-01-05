//
//  YYTextView.m
//  DDFood
//
//  Created by YZ Y on 16/7/11.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYTextView.h"

@interface YYTextView () <UITextViewDelegate>
@property (nonatomic, weak) UILabel *placeHolderLabel;
@property (nonatomic, weak) UILabel *textNumberLabel;
@property (nonatomic, weak) UITextView *textView;

@end

@implementation YYTextView

- (UITextView *)textView {
    if (!_textView) {
        UITextView *view = [[UITextView alloc] init];
        view.delegate = self;
        [self addSubview:view];
        _textView = view;
    }
    return _textView;
}


- (UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
        _placeHolderLabel = label;
    }
    return _placeHolderLabel;
}

- (UILabel *)textNumberLabel {
    if (!_textNumberLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = YYPlaceHolderColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
        _textNumberLabel = label;
        _textNumberLabel.hidden = YES;
    }
    return _textNumberLabel;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self textView];
        self.placeHolderLabel.hidden = NO;
        self.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        [self textNumberLabel];
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.textView.backgroundColor = backgroundColor;
    self.placeHolderLabel.backgroundColor = backgroundColor;
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    if (placeHolder != nil && ![placeHolder isEqualToString:@""]) {
        _placeHolder = placeHolder;
        self.placeHolderLabel.hidden = NO;
        self.placeHolderLabel.text = placeHolder;
    }
}

- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder
{
    self.placeHolderLabel.hidden = hidePlaceHolder;
    
}

- (void)setNumLabelText:(NSString *)numLabelText
{
    _numLabelText = numLabelText;
}

- (void)setPlaceHolderTextColor:(UIColor *)placeHolderTextColor
{
    [self setPlaceHolder:_placeHolder placeHolderTextColor:placeHolderTextColor];
}

- (void)setPlaceHolder:(NSString *)placeHolder placeHolderTextColor:(UIColor *)placeHolderTextColor
{
    self.placeHolderLabel.textColor = placeHolderTextColor;
    self.placeHolderLabel.text = placeHolder;
}

- (void)setFont:(UIFont *)font
{
    self.textView.font = font;
    self.placeHolderLabel.font = font;
    
}

- (void)setText:(NSString *)text
{
    self.textView.text = text;
    if ([text isEqualToString:@""] || text == nil) {
        self.placeHolderLabel.hidden = NO;
    } else {
        self.placeHolderLabel.hidden = YES;
    }
    
}

#pragma mark - 获取当前所在的控制器
/** 获取当前View的控制器对象 */
- (UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    if ([textView isFirstResponder]) {
//        if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] ||
//            ![[textView textInputMode] primaryLanguage] ||
//            range.location >= _maxTextCount) {
//            return NO;
//        }
//    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    _placeHolderLabel.hidden = [textView.text length] > 0 ? YES : NO;
    if (_textDidChangeBlock) {
        _textDidChangeBlock([textView.text getStringRect:self.textView.font size:CGSizeMake(self.mj_w, MAXFLOAT)].size, textView.text);
    }
    textView.layoutManager.allowsNonContiguousLayout = NO;
    if (_maxTextCount == 0) {
        return;
    }
    
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    if (selectedRange && position)
    {
        return;
    }
    else if(selectedRange == nil && position == nil)
    {
        _textNumberLabel.text = [NSString stringWithFormat:@"还可输入%d个字", _maxTextCount - (int)textView.text.length];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_numLabelText != nil && ![_numLabelText isEqualToString:@""]) {
        self.textNumberLabel.text = _numLabelText;
        self.textNumberLabel.hidden = NO;
        self.textNumberLabel.frame = CGRectMake(RELATIVE_WIDTH(10), self.mj_h - RELATIVE_WIDTH(4) - RELATIVE_WIDTH(34), self.mj_w - RELATIVE_WIDTH(20), RELATIVE_WIDTH(34));
        self.textView.frame = CGRectMake(RELATIVE_WIDTH(0), RELATIVE_WIDTH(0), self.mj_w, self.mj_h - RELATIVE_WIDTH(42));
    } else {
        self.textView.frame = self.frame;
    }
    CGFloat textHeight = [self.placeHolderLabel.text getStringRect:self.textView.font size:CGSizeMake(self.mj_w - RELATIVE_WIDTH(12), MAXFLOAT)].size.height;
    self.placeHolderLabel.frame = CGRectMake(RELATIVE_WIDTH(6), RELATIVE_WIDTH(16), self.mj_w - RELATIVE_WIDTH(12), textHeight);
}

@end
