//
//  YYSettleWashDealViewCell.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSettleWashDealViewCell.h"
#import "YYAddressInfoView.h"
#import "YYWashDealGoodsView.h"
#import "YYButton.h"

@interface YYSettleWashDealViewCell ()
@property (nonatomic, weak) YYAddressInfoView *addressView;
@property (nonatomic, weak) YYWashDealGoodsView *goodsView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *tagLabel;
@property (nonatomic, weak) UILabel *bonusPointsLabel;
@property (nonatomic, weak) YYButton *selectButton;

@end

@implementation YYSettleWashDealViewCell

- (YYAddressInfoView *)addressView {
    if (!_addressView) {
        YYAddressInfoView *view = [[YYAddressInfoView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(60), WIN_WIDTH, RELATIVE_WIDTH(160))];
        view.hideLine = YES;
        view.hideTagView = NO;
        [self addSubview:view];
        _addressView = view;
    }
    return _addressView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(26), RELATIVE_WIDTH(26), RELATIVE_WIDTH(140), RELATIVE_WIDTH(32))];
        label.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(30)];
        label.textColor = YYTextColor;
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
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


- (YYWashDealGoodsView *)goodsView {
    if (!_goodsView) {
        YYWashDealGoodsView *view = [[YYWashDealGoodsView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:view];
        WS(ws);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws.contentView);
        }];
        _goodsView = view;
    }
    return _goodsView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        self.textLabel.textColor = YYTextColor;
        self.detailTextLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        self.detailTextLabel.textColor = YYGrayTextColor;
    }
    return self;
}

- (void)selectAction:(UIButton *)sender
{
    self.selectButton.selected = !self.selectButton.isSelected;
    if (_selectSameAddrssBlock) {
        _selectSameAddrssBlock(self.selectButton.isSelected);
    }
}

- (void)switchAction:(UISwitch *)sender
{
    if (sender.on) {
        
    }
}

- (void)setType:(YYSettleWashDealViewCellType)type
{
    _type = type;
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_arrow_right"]];
    arrow.frame = CGRectMake(0, 0, RELATIVE_WIDTH(26), RELATIVE_WIDTH(26));
    switch (type) {
        case YYSettleWashDealViewCellTypeTakeClothAdrress:
        {
            self.accessoryView = arrow;
            self.titleLabel.text = @"取衣地址";
            [self addressView];
            break;
        }
        case YYSettleWashDealViewCellTypeShippingAdrress:
        {
            self.accessoryView = arrow;
            self.titleLabel.text = @"送衣地址";
            [self addressView];
            break;
        }
        case YYSettleWashDealViewCellTypeSameAddressButton:
        {
            YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
            [button setLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] selectedLeftImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] rightTitle:@"同取衣地址" selectedRightTitle:nil];
            button.titleFont = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
            button.normalColor = YYGrayTextColor;
            button.frame = CGRectMake(0, 0, RELATIVE_WIDTH(200), RELATIVE_WIDTH(44));
            [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            self.accessoryView = button;
            _selectButton = button;
//            button.backgroundColor = [UIColor orangeColor];
//            [self addSubview:button];
//            WS(ws);
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
//                make.centerY.equalTo(ws);
//                make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(200), RELATIVE_WIDTH(40)));
//            }];
            break;
        }
        case YYSettleWashDealViewCellTypeGoods:
        {
            [self goodsView];
            break;
        }
        case YYSettleWashDealViewCellTypeFee:
        {
            self.detailTextLabel.textColor = YYGlobalColor;
            break;
        }
        case YYSettleWashDealViewCellTypeCoupon:
        {
            self.accessoryView = nil;
            [self tagLabel];
            break;
        }
        case YYSettleWashDealViewCellTypeDefault:
        {
            self.accessoryView = arrow;
            break;
        }
        case YYSettleWashDealViewCellTypeBonusPoints:
        {
            UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(104), RELATIVE_WIDTH(42))];
            [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            switchButton.onTintColor = YYGlobalColor;
            self.accessoryView = switchButton;
            [self bonusPointsLabel];
            break;
        }
        default:
            break;
    }
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    _goodsView.goodsModel = goodsModel;
}

- (void)setAddressModel:(YYAddressModel *)addressModel
{
    _addressModel = addressModel;
    _addressView.addressModel = addressModel;
}

- (void)setBonusPoints:(NSString *)bonusPoints
{
    _bonusPoints = bonusPoints;
    self.bonusPointsLabel.text = [NSString stringWithFormat:@"可用积分%@", bonusPoints];
}

@end
