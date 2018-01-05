//
//  YYMineBrandCollectionViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineBrandCollectionViewCell.h"
#import "YYImageTextView.h"
#import "YYBrandModel.h"

@interface YYMineBrandCollectionViewCell ()
@property (nonatomic, weak) YYImageTextView *imageTextView;
@property (nonatomic, weak) UILabel *brandLabel;
@property (nonatomic, weak) UILabel *likeCountLabel;
@property (nonatomic, weak) UIButton *selectButton;
@end

@implementation YYMineBrandCollectionViewCell

- (YYImageTextView *)imageTextView {
    if (!_imageTextView) {
        YYImageTextView *view = [[YYImageTextView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(80), RELATIVE_WIDTH(80))];
        view.label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(20)];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _imageTextView = view;
    }
    return _imageTextView;
}

- (UILabel *)brandLabel {
    if (!_brandLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.textColor = YYTextColor;
        label.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _brandLabel = label;
    }
    return _brandLabel;
}

- (UILabel *)likeCountLabel {
    if (!_likeCountLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(20)];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        [self.contentView addSubview:label];
        _likeCountLabel = label;
    }
    return _likeCountLabel;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _selectButton = button;
    }
    return _selectButton;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self brandLabel];
        [self likeCountLabel];
        [self imageTextView];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setBrandModel:(YYBrandModel *)brandModel
{
    _brandModel = brandModel;
    self.brandLabel.text = brandModel.brand;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%@人已收藏", brandModel.likeCount];
    self.imageTextView.label.text = brandModel.brand;
}

- (void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    WS(ws);
    if (isEditing) {
        self.selectButton.selected = NO;
        self.selectButton.hidden = NO;
        [self.selectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(ws.contentView);
            make.width.mas_equalTo(RELATIVE_WIDTH(84));
        }];
        
        [self.imageTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selectButton.mas_right);
            make.centerY.equalTo(ws.contentView);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(80), RELATIVE_WIDTH(80)));
        }];
        
    } else {
        self.selectButton.hidden = YES;
        [self.selectButton removeFromSuperview];
        
        [self.imageTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(24));
            make.centerY.equalTo(ws.contentView);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(80), RELATIVE_WIDTH(80)));
        }];
    }
    [self.brandLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageTextView.mas_right).offset(RELATIVE_WIDTH(28));
        make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(50));
        make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(22));
        make.height.mas_equalTo(RELATIVE_WIDTH(26));
    }];
    
    [self.likeCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(22));
        make.right.left.equalTo(self.brandLabel);
        make.height.mas_equalTo(RELATIVE_WIDTH(24));
    }];
}

- (void)selectAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (_selectBrandBlock) {
        _selectBrandBlock(_brandModel, sender.isSelected);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
