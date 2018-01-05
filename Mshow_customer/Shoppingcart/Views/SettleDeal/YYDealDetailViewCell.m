//
//  YYDealDetailViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYDealDetailViewCell.h"
#import "YYAddressInfoView.h"
#import "YYMineWardrobeGoodsView.h"
#import "YYDealStatusView.h"
#import "YYDealDeliveryInfoView.h"
#import "YYDealDetailGoodsServiceFeeView.h"
#import "YYDamageSuspendView.h"
#import "YYButton.h"
#import "YYDeviceHandle.h"

@interface YYDealDetailViewCell ()
@property (nonatomic, weak) YYAddressInfoView *addressInfoView;
@property (nonatomic, weak) YYMineWardrobeGoodsView *goodsInfoView;
@property (nonatomic, weak) YYDealDetailGoodsServiceFeeView *goodsServiceFeeView;
@property (nonatomic, weak) YYDealStatusView *statusView;
@property (nonatomic, weak) YYDealDeliveryInfoView *deliveryInfoView;
@property (nonatomic, weak) UILabel *tagLabel;
@property (nonatomic, weak) UILabel *bonusPointsLabel;
@property (nonatomic, weak) YYButton *callButton;
@property (nonatomic, weak) UILabel *returnFeeLabel;
@property (nonatomic, weak) UILabel *returnFeeDetailLabel;
@property (nonatomic, weak) UILabel *serviceFeeLabel;

@end

@implementation YYDealDetailViewCell

- (YYAddressInfoView *)addressInfoView {
    if (!_addressInfoView) {
        YYAddressInfoView *view = [[YYAddressInfoView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(170))];
        view.hideTagView = NO;
        [self addSubview:view];
        _addressInfoView = view;
    }
    return _addressInfoView;
}

- (UILabel *)tagLabel {
    if (!_tagLabel) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = RELATIVE_WIDTH(17);
        label.layer.borderColor = YYGlobalColor.CGColor;
        label.layer.borderWidth = RELATIVE_WIDTH(1);
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.textColor = YYGlobalColor;
        label.text = @"不可用";
        [self.contentView addSubview:label];
        WS(ws);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(128));
            make.centerY.equalTo(ws.contentView);
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(100), RELATIVE_WIDTH(34)));
        }];
        _tagLabel = label;
    }
    return _tagLabel;
}

- (YYMineWardrobeGoodsView *)goodsInfoView {
    if (!_goodsInfoView) {
        YYMineWardrobeGoodsView *view = [[YYMineWardrobeGoodsView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:view];
        WS(ws);
        if (_type == YYDealDetailViewCellTypeGoodsWithFee) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.left.equalTo(ws.contentView);
                make.height.mas_equalTo(RELATIVE_WIDTH(232));
            }];
        } else {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(ws.contentView);
            }];
        }
        _goodsInfoView = view;
    }
    return _goodsInfoView;
}

- (YYDealDetailGoodsServiceFeeView *)goodsServiceFeeView {
    if (!_goodsServiceFeeView) {
        YYDealDetailGoodsServiceFeeView *feeView = [[YYDealDetailGoodsServiceFeeView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(20), WIN_WIDTH, RELATIVE_WIDTH(60))];
        [self.contentView addSubview:feeView];
        WS(ws);
        [feeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(60));
        }];
        feeView.showDamageInfoBlock = ^{
            StrongSelf(strongSelf);
            strongSelf = ws;
            [strongSelf showDamageInfo];
        };
        _goodsServiceFeeView = feeView;
    }
    return _goodsServiceFeeView;
}

- (YYDealStatusView *)statusView {
    if (!_statusView) {
        YYDealStatusView *view = [[YYDealStatusView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:view];
        WS(ws);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws.contentView);
        }];
        _statusView = view;
    }
    return _statusView;
}

- (YYDealDeliveryInfoView *)deliveryInfoView {
    if (!_deliveryInfoView) {
        YYDealDeliveryInfoView *view = [[YYDealDeliveryInfoView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:view];
        WS(ws);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws.contentView);
        }];
        _deliveryInfoView = view;
    }
    return _deliveryInfoView;
}

- (UILabel *)bonusPointsLabel {
    if (!_bonusPointsLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        [self.contentView addSubview:label];
        WS(ws);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(100));
            make.centerY.equalTo(ws.contentView);
            make.height.mas_equalTo(RELATIVE_WIDTH(28));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        _bonusPointsLabel = label;
    }
    return _bonusPointsLabel;
}

- (YYButton *)callButton {
    if (!_callButton) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, self.mj_h - RELATIVE_WIDTH(100), self.mj_w, RELATIVE_WIDTH(100));
        button.normalColor = YYTextColor;
        [button setLeftImage:[UIImage imageNamed:@"img_telephone"] selectedLeftImage:nil rightTitle:@"联系商家" selectedRightTitle:nil];
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        WS(ws);
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(ws.contentView);
            make.width.mas_equalTo(RELATIVE_WIDTH(180));
            make.centerX.equalTo(ws.contentView);
        }];
        _callButton = button;
    }
    return _callButton;
}

- (UILabel *)serviceFeeLabel {
    if (!_serviceFeeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        [self.contentView addSubview:label];
        WS(ws);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(26));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
            make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(10));
            make.height.mas_equalTo(RELATIVE_WIDTH(26));
        }];
        _serviceFeeLabel = label;
    }
    return _serviceFeeLabel;
}

- (UILabel *)returnFeeLabel {
    if (!_returnFeeLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        [self.contentView addSubview:label];
        WS(ws);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(26));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
            make.bottom.equalTo(self.returnFeeDetailLabel.mas_top).offset(-RELATIVE_WIDTH(6));
            make.height.mas_equalTo(RELATIVE_WIDTH(26));
        }];
        _returnFeeLabel = label;
    }
    return _returnFeeLabel;
}

- (UILabel *)returnFeeDetailLabel {
    if (!_returnFeeDetailLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        [self.contentView addSubview:label];
        WS(ws);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(RELATIVE_WIDTH(126));
            make.right.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(26));
            make.bottom.equalTo(ws.contentView).offset(-RELATIVE_WIDTH(10));
            make.height.mas_equalTo(RELATIVE_WIDTH(26));
        }];
        _returnFeeDetailLabel = label;
    }
    return _returnFeeDetailLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        self.textLabel.textColor = YYTextColor;
        self.detailTextLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        self.detailTextLabel.textColor = YYGrayTextColor;
    }
    return self;
}

#pragma mark - button action
- (void)callAction
{
    [YYDeviceHandle makeCall:@"02583412930"];
}

#pragma mark - switch action
- (void)switchAction:(UISwitch *)sender
{
    if (_useBonusPointsBlock) {
        NSString *bounsPoints = sender.isOn ? _bonusPoints : @"0";
        _useBonusPointsBlock(bounsPoints);
    }
}

- (void)showDamageInfo
{
    WS(weakSelf);
    _isShowingDamageInfo = YES;
    self.goodsServiceFeeView.isShowingDamageInfo = YES;
    YYDamageSuspendView *damageView = [[YYDamageSuspendView alloc] initWithFrame:CGRectMake(WIN_WIDTH - RELATIVE_WIDTH(200) - RELATIVE_WIDTH(40), RELATIVE_WIDTH(292) - RELATIVE_WIDTH(40) - RELATIVE_WIDTH(130), RELATIVE_WIDTH(200), RELATIVE_WIDTH(160))];
    damageView.closeBlock = ^{
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        strongSelf.goodsServiceFeeView.isShowingDamageInfo = NO;
        strongSelf.isShowingDamageInfo = NO;
    };
    damageView.showDamageDetailBlock = ^{
        if (_showGoodsDamageDetailBlock) {
            _showGoodsDamageDetailBlock(_goodsModel);
        }
    };
    [self.contentView addSubview:damageView];

}

- (void)setType:(YYDealDetailViewCellType)type
{
    _type = type;
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_arrow_right"]];
    arrow.frame = CGRectMake(0, 0, RELATIVE_WIDTH(26), RELATIVE_WIDTH(26));
    switch (type) {
        case YYDealDetailViewCellTypeShop:
            self.imageView.image = [UIImage imageNamed:@"img_shop"];
            break;
        case YYDealDetailViewCellTypeGoods:
            [self goodsInfoView];
            break;
        case YYDealDetailViewCellTypeGoodsWithFee:
            [self goodsInfoView];
            [self goodsServiceFeeView];
            break;
        case YYDealDetailViewCellTypeAddress:
            self.accessoryView = arrow;
            [self addressInfoView];
            break;
        case YYDealDetailViewCellTypeDealInfo:
            self.detailTextLabel.textColor = YYGlobalColor;
            break;
        case YYDealDetailViewCellTypeDealStatus:
            [self statusView];
            break;
        case YYDealDetailViewCellTypeDeliverInfo:
            [self deliveryInfoView];
            self.accessoryView = arrow;
            break;
        case YYDealDetailViewCellTypeSelectCoupon:
            self.accessoryView = nil;
            self.textLabel.text = @"优惠券";
            [self tagLabel];
            break;
        case YYDealDetailViewCellTypeSelectDuration:
            self.textLabel.text = @"试穿天数";
            self.accessoryView = arrow;
            break;
        case YYDealDetailViewCellTypeSelectRecieveDate:
            self.imageView.image = [UIImage imageNamed:@"img_dates"];
            self.accessoryView = arrow;
            break;
        case YYDealDetailViewCellTypeCallShop:
            [self callButton];
            break;
        case YYDealDetailViewCellTypeReturnFee:
        {
            self.returnFeeLabel.text = @"退回金额=商品金额-服务费-取送费+积分抵扣+优惠券";
            self.returnFeeDetailLabel.text = @"=￥900.00-￥60.00-￥6.00+￥6.00+￥0.00";
        }
            break;
        case YYDealDetailViewCellTypeServiceFee:
        {
            self.serviceFeeLabel.text = @"服务收费标准:干洗费+体验费*(天数-1)";
        }
            break;
        case YYDealDetailViewCellTypeBonusPoints:
        {
            UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(104), RELATIVE_WIDTH(42))];
            [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            switchButton.onTintColor = YYGlobalColor;
            self.accessoryView = switchButton;
            [self bonusPointsLabel];
        }
            break;
    }
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    self.goodsInfoView.goodsModel = goodsModel;
    if (_type == YYDealDetailViewCellTypeGoodsWithFee) {
        self.goodsServiceFeeView.goodsModel = goodsModel;
        [self showDamageInfo];
    }
}

- (void)setAddressModel:(YYAddressModel *)addressModel
{
    _addressModel = addressModel;
    _addressInfoView.addressModel = addressModel;
}

- (void)setDealStatus:(YYDealStatusType)dealStatus date:(NSString *)date dealCode:(NSString *)dealCode
{
    [self.statusView setDealStatus:dealStatus date:date dealCode:dealCode];
}

- (void)setBonusPoints:(NSString *)bonusPoints
{
    _bonusPoints = bonusPoints;
    self.bonusPointsLabel.text = [NSString stringWithFormat:@"可用积分%@", bonusPoints];
}

@end
