//
//  YYHomeCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHomeCell.h"
#import "YYHomeCellCotentView.h"
#import "YYGoodsModel.h"
#import "YYShopModel.h"
#import "YYShopInfoCellView.h"

@interface YYHomeCell ()
@property (nonatomic, weak) YYHomeCellCotentView *containerView;
@property (nonatomic, weak) YYShopInfoCellView *shopInfoView;

@end

@implementation YYHomeCell

- (YYHomeCellCotentView *)containerView {
    if (!_containerView) {
        YYHomeCellCotentView *view = [[YYHomeCellCotentView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h)];
        [self.contentView addSubview:view];
        _containerView = view;
    }
    return _containerView;
}

- (YYShopInfoCellView *)shopInfoView {
    if (!_shopInfoView) {
        YYShopInfoCellView *view = [[YYShopInfoCellView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _shopInfoView = view;
    }
    return _shopInfoView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = mRGBColor(240, 240, 240);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textColor = YYTextColor;
        self.textLabel.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(30)];
    }
    return self;
}

- (void)setType:(YYHomeCellType)type
{
    _type = type;
    WS(ws);
    switch (type) {
        case YYHomeCellTypeShop:
        {
            [self.shopInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.right.left.equalTo(ws.contentView);
//                make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(10));
                make.edges.equalTo(ws.contentView);
            }];
            break;
        }
        case YYHomeCellTypeLabel:
        {
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.left.right.equalTo(ws.contentView);
                make.top.equalTo(ws.contentView).offset(RELATIVE_WIDTH(10));
            }];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(26), RELATIVE_WIDTH(10), self.mj_w - RELATIVE_WIDTH(52), RELATIVE_WIDTH(32))];
            label.backgroundColor = [UIColor whiteColor];
            label.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(30)];
            label.textColor = YYTextColor;
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(view);
                make.left.equalTo(view).offset(RELATIVE_WIDTH(26));
                make.height.mas_equalTo(RELATIVE_WIDTH(32));
                make.width.greaterThanOrEqualTo(@0);
            }];
            _label = label;
            break;
        }
        default:
        {
            self.containerView.type = type;
            self.containerView.goodsArray = [YYGoodsModel testDataArray];
            [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(ws.contentView);
            }];
            
            self.containerView.selectItemBlock = ^(YYGoodsModel *goodsModel, NSInteger index) {
                if (_selectItemBlock) {
                    _selectItemBlock(goodsModel, index);
                }
            };
            
            self.containerView.showMoreBlock = ^(YYHomeCellType type) {
                if (_showMorBlock) {
                    _showMorBlock(type);
                }
            };
            break;
        }
    }
    if (type == YYHomeCellTypeShop) {
        
    } else {
        
    }
    
}


- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    self.containerView.goodsArray = dataArray;
}

- (void)setShopModel:(YYShopModel *)shopModel
{
    _shopModel = shopModel;
    self.shopInfoView.shopModel = shopModel;
}

@end
