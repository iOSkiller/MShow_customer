//
//  YYSettleWashDealView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSettleWashDealView.h"
#import "YYSettleWashDealViewCell.h"
#import "YYAddressModel.h"
#import "YYDealModel.h"
#import "YYBottomSelectView.h"

/**分区*/
#define TakeClothAddressSection 0
#define ShippingAddressSection 1
#define GoodsSection 2
#define SubscribeSection 3
#define FeeSection 4

/**预约*/
#define SubscribeForTakeClothRow 0
#define SubscribeForWashShopRow 1
#define SubscribeForTakeClothTypeRow 2
#define SubscribeForShippingClothTypeRow 3

/**费用*/
#define FeeForWashRow 0
#define FeeForExpressRow 1
#define FeeForBonusPointsRow 2
#define FeeForCouponRow 3

@interface YYSettleWashDealView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;

@end

@implementation YYSettleWashDealView

{
    YYMineFunctionType _recieveType;
    YYMineFunctionType _deliveryType;
    NSString *_date;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.backgroundColor = [UIColor whiteColor];
        view.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(20))];
        [view setSeparatorInset:UIEdgeInsetsZero];
        [view setLayoutMargins:UIEdgeInsetsZero];
        view.delegate = self;
        view.dataSource = self;
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _dealModel = [YYDealModel testWashDeal];
        [self tableView];
    }
    return self;
}

- (void)setShop:(NSString *)shop
{
    _shop = shop;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)setShipAddressModel:(YYAddressModel *)shipAddressModel
{
    _shipAddressModel = shipAddressModel;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:ShippingAddressSection] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)setTakeAddressModel:(YYAddressModel *)takeAddressModel
{
    _takeAddressModel = takeAddressModel;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:TakeClothAddressSection] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case TakeClothAddressSection:
            return 2;
            break;
        case ShippingAddressSection:
            return 3;
            break;
        case GoodsSection:
            return self.dealModel.goodsArray.count + 1;
            break;
        default:
            return 5;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYSettleWashDealViewCellID:%@%@", @(indexPath.row), @(indexPath.section)];
    YYSettleWashDealViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYSettleWashDealViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        switch (indexPath.section) {
            case TakeClothAddressSection:
                if (indexPath.row == 0) {
                    cell.type = YYSettleWashDealViewCellTypeTakeClothAdrress;
                } else {
                    cell.backgroundColor = YYSectionFooterColor;
                }
                break;
            case ShippingAddressSection:
                if (indexPath.row == 0) {
                    cell.type = YYSettleWashDealViewCellTypeShippingAdrress;
                }
                if (indexPath.row == 1) {
                    cell.type = YYSettleWashDealViewCellTypeSameAddressButton;
                    WS(weakSelf);
                    cell.selectSameAddrssBlock = ^(BOOL isSelected) {
                        StrongSelf(strongSelf);
                        strongSelf = weakSelf;
                        
                        if (isSelected) {
                            strongSelf.shipAddressModel = strongSelf.takeAddressModel;
                        } else {
                            strongSelf.shipAddressModel = nil;
                        }
                        [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:ShippingAddressSection]] withRowAnimation:UITableViewRowAnimationNone];
                    };
                }
                if (indexPath.row == 2) {
                    cell.backgroundColor = YYSectionFooterColor;
                }
                break;
            case GoodsSection:
                if (indexPath.row == self.dealModel.goodsArray.count) {
                    cell.backgroundColor = YYSectionFooterColor;
                } else {
                    cell.type = YYSettleWashDealViewCellTypeGoods;
                    cell.goodsModel = self.dealModel.goodsArray[indexPath.row];
                }
                break;
            case SubscribeSection:
                if (indexPath.row == 0) {
                    cell.type = YYSettleWashDealViewCellTypeDefault;
                } else if (indexPath.row == 4) {
                    cell.backgroundColor = YYSectionFooterColor;
                }
                break;
            case FeeSection:
                switch (indexPath.row) {
                    case FeeForWashRow:
                        cell.type = YYSettleWashDealViewCellTypeFee;
                        cell.textLabel.text = @"干洗费";
                        cell.detailTextLabel.text = @"￥165.00";
                        break;
                    case FeeForExpressRow:
                        cell.type = YYSettleWashDealViewCellTypeFee;
                        cell.textLabel.text = @"取送费";
                        cell.detailTextLabel.text = @"+￥10.00";
                        break;
                    case FeeForBonusPointsRow:
                        cell.type = YYSettleWashDealViewCellTypeBonusPoints;
                        cell.textLabel.text = @"积分";
                        cell.bonusPoints = @"600";
                        break;
                    case FeeForCouponRow:
                        cell.type = YYSettleWashDealViewCellTypeCoupon;
                        cell.textLabel.text = @"优惠券";
//                        cell.detailTextLabel.text = @"请选择优惠券";
                        break;
                    default:
                        cell.backgroundColor = YYSectionFooterColor;
                        break;
                }
                break;
                
            default:
                cell.backgroundColor = YYSectionFooterColor;
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYSettleWashDealViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        if (indexPath.section == 1) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, RELATIVE_WIDTH(26), 0, RELATIVE_WIDTH(26))];
        } else {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
    }
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if (indexPath.section == TakeClothAddressSection) {
        cell.addressModel = _takeAddressModel;
    }
    
    if (indexPath.section == ShippingAddressSection) {
        cell.addressModel = _shipAddressModel;
    }
    
    if (indexPath.section == SubscribeSection) {
        switch (indexPath.row) {
            case SubscribeForTakeClothRow:
                cell.textLabel.text = @"预约时间";
                cell.detailTextLabel.text = [_date isValid] ? _date : @"请选择时间";
                break;
            case SubscribeForWashShopRow:
                cell.textLabel.text = @"预约干洗店";
                cell.detailTextLabel.text = [_shop isValid] ? _shop : @"请选择干洗店";
                break;
            case SubscribeForTakeClothTypeRow:
                cell.textLabel.text = @"取衣方式";
                switch (_deliveryType) {
                    case YYMineFunctionTypeDeliveryByPost:
                        cell.detailTextLabel.text = @"上门取件";
                        break;
                    case YYMineFunctionTypeDeliveryBySelf:
                        cell.detailTextLabel.text = @"自送";
                        break;
                    default:
                        cell.detailTextLabel.text = @"请选择送衣方式";
                        break;
                }
                
                break;
            case SubscribeForShippingClothTypeRow:
                cell.textLabel.text = @"送衣方式";
                switch (_recieveType) {
                    case YYMineFunctionTypeReturnBySelf:
                        cell.detailTextLabel.text = @"自取";
                        break;
                    case YYMineFunctionTypeReturn:
                        cell.detailTextLabel.text = @"送上门";
                        break;
                    default:
                        cell.detailTextLabel.text = @"请选择取衣方式";
                        break;
                }
                
                break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == ShippingAddressSection) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeSelectShipAddress)]) {
            [_delegate executeSelectShipAddress];
        }
    }
    
    if (indexPath.section == TakeClothAddressSection) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeSelectTakeAddress)]) {
            [_delegate executeSelectTakeAddress];
        }
    }
    
    if (indexPath.section == SubscribeSection) {
        switch (indexPath.row) {
            case SubscribeForTakeClothRow:
            {
                YYBottomSelectView *selectView = [[YYBottomSelectView alloc] initWithFrame:self.bounds type:YYBottomSelectViewTypeDateTime];
                WS(weakSelf);
                selectView.didSelectDateAndTimeBlock = ^(NSString *date, NSString *time) {
                    StrongSelf(strongSelf);
                    strongSelf = weakSelf;
                    _date = [NSString stringWithFormat:@"%@ %@", date, time];
                    [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:SubscribeForTakeClothRow inSection:SubscribeSection]] withRowAnimation:UITableViewRowAnimationNone];
                };
                [selectView show];
                
                break;
            }
            case SubscribeForWashShopRow:
            {
                if (_delegate && [_delegate respondsToSelector:@selector(executeSelectWashShop)]) {
                    [_delegate executeSelectWashShop];
                }
                break;
            }
            case SubscribeForTakeClothTypeRow:
            {
                YYBottomSelectView *selectView = [[YYBottomSelectView alloc] initWithFrame:self.bounds type:YYBottomSelectViewTypeDelviery];
                WS(weakSelf);
                selectView.didFinishSelectBlock = ^(YYMineFunctionType functionType) {
                    StrongSelf(strongSelf);
                    strongSelf = weakSelf;
                    _deliveryType = functionType;
                    [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:SubscribeForTakeClothTypeRow inSection:SubscribeSection]] withRowAnimation:UITableViewRowAnimationNone];
                };
                [selectView show];
                break;
            }
            case SubscribeForShippingClothTypeRow:
            {
                YYBottomSelectView *selectView = [[YYBottomSelectView alloc] initWithFrame:self.bounds type:YYBottomSelectViewTypeRecieve];
                WS(weakSelf);
                StrongSelf(strongSelf);
                strongSelf = weakSelf;
                selectView.didFinishSelectBlock = ^(YYMineFunctionType functionType) {
                    _recieveType = functionType;
                    [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:SubscribeForShippingClothTypeRow inSection:SubscribeSection]] withRowAnimation:UITableViewRowAnimationNone];
                };
                [selectView show];
                break;
            }
            default:
                break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case TakeClothAddressSection:
            if (indexPath.row == 0) {
                return RELATIVE_WIDTH(220);
            }
            return RELATIVE_WIDTH(10);
            break;
        case ShippingAddressSection:
            if (indexPath.row == 0) {
                return RELATIVE_WIDTH(220);
            }
            if (indexPath.row == 1) {
                return RELATIVE_WIDTH(80);
            }
            return RELATIVE_WIDTH(10);
            break;
        case GoodsSection:
            if (indexPath.row == self.dealModel.goodsArray.count) {
                return RELATIVE_WIDTH(10);
            }
            return RELATIVE_WIDTH(100);
            break;
        case SubscribeSection:
            if (indexPath.row == 4) {
                return RELATIVE_WIDTH(10);
            }
            return RELATIVE_WIDTH(80);
            break;
        case FeeSection:
            if (indexPath.row == 4) {
                return RELATIVE_WIDTH(10);
            }
            return RELATIVE_WIDTH(80);
            break;
        default:
            return RELATIVE_WIDTH(80);
            break;
    }
}


@end
