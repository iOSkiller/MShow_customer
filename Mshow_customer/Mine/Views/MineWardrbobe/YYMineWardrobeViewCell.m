//
//  YYMineWardrobeViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/9.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineWardrobeViewCell.h"
#import "YYMineWardrobeTitleView.h"
#import "YYMineWardrobeGoodsView.h"
#import "YYMineWardrobeFunctionView.h"
#import "YYShopModel.h"
#import "YYGoodsModel.h"
#import "YYDealModel.h"

@interface YYMineWardrobeViewCell ()
@property (nonatomic, weak) YYMineWardrobeTitleView *titleView;
@property (nonatomic, weak) YYMineWardrobeGoodsView *goodsView;
@property (nonatomic, weak) YYMineWardrobeFunctionView *functionView;

@end

@implementation YYMineWardrobeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.textLabel.textColor = YYGrayTextColor;
        self.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
    }
    return self;
}

- (void)setDealStatusType:(YYDealStatusType)dealStatusType
{
    _dealStatusType = dealStatusType;
    switch (dealStatusType) {
        case YYDealStatusTypeWaitForPay:
        {
            YYMineWardrobeFunctionView *functionView = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(132)) functionArray:@[@"付款", @"取消订单"] haveDealInfo:@"共1件   实付:￥304.00(包含运费￥4.00)"];
            functionView.statusType = dealStatusType;
            [self.contentView addSubview:functionView];
            _functionView = functionView;
            break;
        }
        case YYDealStatusTypeWaitForReturn:
        {
            YYMineWardrobeFunctionView *functionView = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(132)) functionArray:@[@"下单归还", @"自还", @"我要买",] haveDealInfo:@"共1件   实付:￥304.00(包含运费￥4.00)"];
            functionView.statusType = dealStatusType;
            [self.contentView addSubview:functionView];
            _functionView = functionView;
            break;
        }
        case YYDealStatusTypeWaitForComment:
        {
            YYMineWardrobeFunctionView *functionView = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(132)) functionArray:@[@"评价", @"删除订单"] haveDealInfo:@"共1件   实付:￥304.00(包含运费￥4.00)"];
            functionView.statusType = dealStatusType;
            [self.contentView addSubview:functionView];
            _functionView = functionView;
            break;
        }
        case YYDealStatusTypeWaitForRecieve:
        {
            YYMineWardrobeFunctionView *functionView = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(132)) functionArray:@[@"确认收货"] haveDealInfo:@"共1件   实付:￥304.00(包含运费￥4.00)"];
            functionView.statusType = dealStatusType;
            [self.contentView addSubview:functionView];
            _functionView = functionView;
            break;
        }
        case YYDealStatusTypeWaitForDelivery:
        {
            YYMineWardrobeFunctionView *functionView = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(132)) functionArray:@[@"催单", @"取消订单"] haveDealInfo:@"共1件   实付:￥304.00(包含运费￥4.00)"];
            functionView.statusType = dealStatusType;
            [self.contentView addSubview:functionView];
            _functionView = functionView;
            break;
        }
        case YYDealStatusTypeWaitForSubmit:
        {
            YYMineWardrobeFunctionView *functionView = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(132)) functionArray:@[@"确认订单", @"申诉"] haveDealInfo:@"共1件   实付:￥304.00(包含运费￥4.00)"];
            functionView.statusType = dealStatusType;
            [self.contentView addSubview:functionView];
            _functionView = functionView;
        }
            break;
        default:
            break;
    }
    self.functionView.buttonActionBlock = ^(YYMineFunctionType type) {
        if (_actionBlock) {
            _actionBlock(type, _goodsModel, _dealModel, _shopModel);
        }
    };
}

- (void)setState:(NSString *)state
{
    _state = state;
    self.titleView.state = state;
}

- (void)setType:(YYMineWardrobeViewCellType)type
{
    _type = type;
    switch (type) {
        case YYMineWardrobeViewCellTypeBoughtGoods:
        {
            YYMineWardrobeGoodsView *view = [[YYMineWardrobeGoodsView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(236))];
            view.type = YYMineWardrobeViewTypePayed;
            [self.contentView addSubview:view];
            _goodsView = view;
            break;
        }
        case YYMineWardrobeViewCellTypeTriedGoods:
        {
            YYMineWardrobeGoodsView *view = [[YYMineWardrobeGoodsView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(236))];
            view.type = YYMineWardrobeViewTypeTried;
            [self.contentView addSubview:view];
            _goodsView = view;
            break;
        }
        case YYMineWardrobeViewCellTypeTitle:
        {
            YYMineWardrobeTitleView *view = [[YYMineWardrobeTitleView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(80)) type:YYMineWardrobeTitleViewTypeNormal];
            [self.contentView addSubview:view];
            view.buttonActionBlock = ^{
                if (_actionBlock) {
                    _actionBlock(YYMineFunctionTypeShowDelivery, _goodsModel, _dealModel, _shopModel);
                }
            };
            _titleView = view;
            break;
        }
        case YYMineWardrobeViewCellTypeTitleWithFuction:
        {
            YYMineWardrobeTitleView *view = [[YYMineWardrobeTitleView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(80)) type:YYMineWardrobeTitleViewTypeFunction];
            [self.contentView addSubview:view];
            view.buttonActionBlock = ^{
                if (_actionBlock) {
                    _actionBlock(YYMineFunctionTypeShowDelivery, _goodsModel, _dealModel, _shopModel);
                }
            };
            view.tapActionBlock = ^{
                if (_actionBlock) {
                    _actionBlock(YYMineFunctionTypeShowShop, _goodsModel, _dealModel, _shopModel);
                }
            };
            _titleView = view;
            break;
        }
        case YYMineWardrobeViewCellTypeTitleWithState:
        {
            YYMineWardrobeTitleView *view = [[YYMineWardrobeTitleView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(80)) type:YYMineWardrobeTitleViewTypeState];
            [self.contentView addSubview:view];
            _titleView = view;
        }
            break;
        case YYMineWardrobeViewCellTypeDealFunction:
        {
            YYMineWardrobeFunctionView *view = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(132)) functionArray:@[@"退换货", @"评价", @"秀一秀",] haveDealInfo:@"共1件   实付:￥304.00(包含运费￥4.00)"];
            view.statusType = YYDealStatusTypeBought;
            view.dealInfo = @"共1件   实付:￥304.00(包含运费￥4.00)";
            view.buttonActionBlock = ^(YYMineFunctionType type) {
                if (_actionBlock) {
                    _actionBlock(type, _goodsModel, _dealModel, _shopModel);
                }
            };
            [self.contentView addSubview:view];
            _functionView = view;
            break;
        }
        case YYMineWardrobeViewCellTypeGoodsFunction:
        {
            YYMineWardrobeFunctionView *view = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(132)) functionArray:@[@"我要买", @"评价", @"秀一秀", @"归还"] haveDealInfo:@"共1件   实付:￥304.00(包含运费￥4.00)"];
            view.statusType = YYDealStatusTypeTried;
            view.buttonActionBlock = ^(YYMineFunctionType type) {
                if (_actionBlock) {
                    _actionBlock(type, _goodsModel, _dealModel, _shopModel);
                }
            };
            [self.contentView addSubview:view];
            _functionView = view;
            break;
        }
        case YYMineWardrobeViewCellTypeReturnChangeGoodsDealFunction:
        {
            YYMineWardrobeFunctionView *view = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(90)) functionArray:@[@"查看订单"] haveDealInfo:nil];
            view.statusType = YYDealStatusTypeReturnChange;
            view.buttonActionBlock = ^(YYMineFunctionType type) {
                if (_actionBlock) {
                    _actionBlock(type, _goodsModel, _dealModel, _shopModel);
                }
            };
            [self.contentView addSubview:view];
            _functionView = view;
            break;
        }
        default:
            break;
    }
}

- (void)setShopModel:(YYShopModel *)shopModel
{
    _shopModel = shopModel;
    self.titleView.shopName = shopModel.shopName;
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    self.goodsView.goodsModel = goodsModel;
}

- (void)setDealModel:(YYDealModel *)dealModel
{
    _dealModel = dealModel;
    self.functionView.dealInfo = [NSString stringWithFormat:@"共%ld件   实付￥%@(含运费￥%@)", (long)dealModel.goodsArray.count, dealModel.price, dealModel.delivery_fee];
}

@end
