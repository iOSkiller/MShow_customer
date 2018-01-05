//
//  YYShoppingCartSpecificationViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/28.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShoppingCartSpecificationViewCell.h"
#import "YYGoodsSpecSelectionView.h"
#import "YYSelectGoodsCountView.h"

@interface YYShoppingCartSpecificationViewCell ()
@property (nonatomic, weak) YYGoodsSpecSelectionView *specView;
@property (nonatomic, weak) YYGoodsSpecSelectionView *sizeView;
@property (nonatomic, weak) YYSelectGoodsCountView *countView;

@end

@implementation YYShoppingCartSpecificationViewCell

- (YYGoodsSpecSelectionView *)specView {
    if (!_specView) {
        YYGoodsSpecSelectionView *view = [[YYGoodsSpecSelectionView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:view];
        _specView = view;
    }
    return _specView;
}

- (YYGoodsSpecSelectionView *)sizeView {
    if (!_sizeView) {
        YYGoodsSpecSelectionView *view = [[YYGoodsSpecSelectionView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:view];
        _sizeView = view;
    }
    return _sizeView;
}


- (YYSelectGoodsCountView *)countView {
    if (!_countView) {
        YYSelectGoodsCountView *view = [[YYSelectGoodsCountView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:view];
        _countView = view;
    }
    return _countView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setType:(YYShoppingCartSpecificationViewCellType)type selectionArray:(NSArray *)selectionArray
{
    WS(ws);
    switch (type) {
        case YYShoppingCartSpecificationViewCellTypeSizeSelection:
        {
            self.sizeView.titleLabel.text = @"尺寸";
            [self.sizeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(40));
                make.left.right.equalTo(ws.contentView);
                make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(30));
            }];
            self.sizeView.dataArray = selectionArray;
            self.sizeView.didSelectSpec = ^(NSString *specID, NSString *spec) {
                if (_didSelectSizeBlock) {
                    _didSelectSizeBlock(specID, spec);
                }
            };
            break;
        }
        case YYShoppingCartSpecificationViewCellTypeSpecSelection:
        {
            self.specView.titleLabel.text = @"颜色";
            [self.specView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(40));
                make.left.right.equalTo(ws.contentView);
                make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(30));
            }];
            self.specView.dataArray = selectionArray;
            self.specView.didSelectSpec = ^(NSString *specID, NSString *spec) {
                if (_didSelectSpecBlock) {
                    _didSelectSpecBlock(specID, spec);
                }
            };
            
            break;
        }
        
        case YYShoppingCartSpecificationViewCellTypeCountSelection:
        {
            [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(ws.contentView);
            }];
            self.countView.didSelectCountBlock = ^(NSString *count) {
                if (_didSelectCountBlock) {
                    _didSelectCountBlock(count);
                }
            };
            break;
        }
    }
}


@end
