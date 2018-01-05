//
//  YYSelectGenderViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectGenderViewCell.h"
#import "YYGoodsModel.h"

@interface YYSelectGenderViewCell ()
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *typeLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *feeLabel;
//@property (nonatomic, weak) UIButton *likeButton;

@end

@implementation YYSelectGenderViewCell

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *view = [UIImageView new];
        view.backgroundColor = [UIColor whiteColor];
//        view.contentMode = UIViewContentModeScaleAspectFit;
//        view.autoresizesSubviews = YES;
//        view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:view];
        _imgView = view;
    }
    return _imgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.textColor = YYGrayTextColor;
        label.text = @"欧根纱拼接连衣裙";
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.textColor = YYGrayTextColor;
        label.text = @"XS S M L";
        [self.contentView addSubview:label];
        _typeLabel = label;
    }
    return _typeLabel;
}

//- (UIButton *)likeButton {
//    if (!_likeButton) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.backgroundColor = [UIColor whiteColor];
//        [button setImage:[UIImage imageNamed:@"choose_btn_collect_n"] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"choose_btn_collect_pre"] forState:UIControlStateSelected];
//        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:button];
//        _likeButton = button;
//    }
//    return _likeButton;
//}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _priceLabel = label;
    }
    return _priceLabel;
}

- (UILabel *)feeLabel {
    if (!_feeLabel) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentRight;
        label.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _feeLabel = label;
    }
    return _feeLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self imgView];
        [self nameLabel];
        [self typeLabel];
//        [self likeButton];
        
        WS(ws);
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(450));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(ws.contentView);
            make.top.equalTo(self.imgView.mas_bottom).offset(RELATIVE_WIDTH(8));
            make.height.mas_equalTo(RELATIVE_WIDTH(30));
        }];
        
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(ws.contentView);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(RELATIVE_WIDTH(8));
            make.height.mas_equalTo(RELATIVE_WIDTH(28));
        }];
        
        //    CGSize imgSize = self.likeButton.currentImage.size;
        
//        [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.imgView.mas_bottom).offset(RELATIVE_WIDTH(16));
//            //        make.size.mas_equalTo(imgSize);
//            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
//            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(28));
//        }];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(RELATIVE_WIDTH(10));
            make.left.equalTo(ws.contentView);
            make.width.greaterThanOrEqualTo(@0);
            make.height.mas_equalTo(RELATIVE_WIDTH(30));
        }];
        
        [self.feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(RELATIVE_WIDTH(10));
            make.right.equalTo(ws.contentView);
            make.width.greaterThanOrEqualTo(@0);
            make.height.mas_equalTo(RELATIVE_WIDTH(30));
        }];
    }
    return self;
}

- (void)buttonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (_selectBlock) {
        _selectBlock(_goodsModel, sender.selected);
    }
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    [self.imgView performSelector:@selector(setImage:) withObject:[UIImage clipImage:[UIImage imageNamed:goodsModel.image] toRect:self.mj_size] afterDelay:0.2 inModes:@[NSDefaultRunLoopMode]];
    self.nameLabel.text = goodsModel.name;
    if ([goodsModel.goodsPrice hasPrefix:@"."]) {
        //分割字符串
        NSArray *array = [goodsModel.currentPrice componentsSeparatedByString:@"."];
        self.priceLabel.attributedText = [NSString stringsArray:@[@"￥", array[0], AppendString(@".", array[1])] fontsArray:@[[UIFont systemFontOfSize:RELATIVE_WIDTH(20)], [UIFont systemFontOfSize:RELATIVE_WIDTH(28)], [UIFont systemFontOfSize:RELATIVE_WIDTH(20)]] colorsArray:@[YYGlobalColor, YYGlobalColor, YYGlobalColor]];
    }
    
    self.feeLabel.attributedText = [NSString stringsArray:@[@"体验费", @"￥", @"10", @".00元/天"] fontsArray:@[[UIFont systemFontOfSize:RELATIVE_WIDTH(20)], [UIFont systemFontOfSize:RELATIVE_WIDTH(20)], [UIFont systemFontOfSize:RELATIVE_WIDTH(28)], [UIFont systemFontOfSize:RELATIVE_WIDTH(20)],] colorsArray:@[YYGrayTextColor, YYGlobalColor, YYGlobalColor, YYGlobalColor]];
    
}




@end
