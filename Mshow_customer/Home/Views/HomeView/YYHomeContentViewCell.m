//
//  YYHomeContentViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHomeContentViewCell.h"
#import "YYGoodsModel.h"

@interface YYHomeContentViewCell ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *brandLabel;

@end

@implementation YYHomeContentViewCell

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *view = [UIImageView new];
        [self.contentView addSubview:view];
        _imageView = view;
    }
    return _imageView;
}

- (UILabel *)brandLabel {
    if (!_brandLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = mRGBAColor(0, 0, 0, 0.75);
        label.hidden = YES;
        [self.contentView addSubview:label];
        _brandLabel = label;
    }
    return _brandLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self imageView];
        [self brandLabel];
        
        WS(ws);
        [self.brandLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(44));
        }];
        
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws.contentView);
        }];
    }
    return self;
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    
    
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel type:(YYHomeCellType)type
{
    _goodsModel = goodsModel;
    _type = type;
    if (type == YYHomeCellTypeTried) {
//        self.brandLabel.text = goodsModel.brand;
//        self.brandLabel.hidden = NO;
    }
    
    if ([goodsModel.image isValid]) {
        [self.imageView performSelector:@selector(setImage:) withObject:[UIImage clipImage:[UIImage imageNamed:goodsModel.image] toRect:self.imageView.mj_size] afterDelay:0.2 inModes:@[NSDefaultRunLoopMode]];
        
    }
    
}


@end
