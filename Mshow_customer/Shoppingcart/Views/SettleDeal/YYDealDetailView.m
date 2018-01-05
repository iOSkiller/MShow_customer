//
//  YYDealDetailView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYDealDetailView.h"
#import "YYDealDetailViewCell.h"
#import "YYDealModel.h"
#import "YYShopModel.h"
#import "YYAlertView.h"

#define DealStatusSection 0
#define DeliveryInfoSection 1
#define AddressInfoSection 2
#define RecieveDateSection 3
#define GoodsInfoSection 4
#define GoodsFeeInfoSection 5
#define ServiceFeeInfoSection 6
#define DiscountFeeInfoSection 7
#define ReturnFeeInfoSection 8


#define WashFeeRow 0
#define TryFeeRow 1
#define ServiceFeeRow 2
#define DamageFeeRow 3
#define DeliveryFeeRow 4

@interface YYDealDetailView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;

@end

@implementation YYDealDetailView

{
    NSString *_bonusPoints;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        [tableView setSeparatorColor:YYSeparatorColor];
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        [tableView setLayoutMargins:UIEdgeInsetsZero];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(70))];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self tableView];
    }
    return self;
}

- (void)setDealModel:(YYDealModel *)dealModel
{
    _dealModel = dealModel;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return 5 + self.dealModel.goodsArray.count;
    if (_dealModel.statusType == YYDealStatusTypeWaitForSubmit) {
        return 9;
    }
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case DealStatusSection:
        case DeliveryInfoSection:
        case AddressInfoSection:
        case RecieveDateSection:
            return 2;
            break;
        case GoodsInfoSection:
            return self.dealModel.goodsArray.count + 2;
            break;
        case GoodsFeeInfoSection:
            if (_dealModel.statusType == YYDealStatusTypeWaitForSubmit) {
                return 2;
            }
            return 5;
            break;
        case ServiceFeeInfoSection:
            return 6;
            break;
        case DiscountFeeInfoSection:
            return 4;
            break;
        case ReturnFeeInfoSection:
            return 3;
            break;
        default:
            break;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYDealDetailViewCellID:%@%@", @(indexPath.row), @(indexPath.section)];
    YYDealDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYDealDetailViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        
        switch (indexPath.section) {
            case DealStatusSection:
            {
                if (indexPath.row == 0) {
                    cell.type = YYDealDetailViewCellTypeDealStatus;
                    [cell setDealStatus:self.dealModel.statusType date:@"" dealCode:@""];
                } else {
                    cell.backgroundColor = YYSectionFooterColor;
                }
            }
                break;
            case DeliveryInfoSection:
                if (indexPath.row == 0) {
                    if (self.dealModel.statusType == YYDealStatusTypeWaitForComment ||
                        self.dealModel.statusType == YYDealStatusTypeWaitForRecieve ||
                        self.dealModel.statusType == YYDealStatusTypeWaitForSubmit) {
                        cell.type = YYDealDetailViewCellTypeDeliverInfo;
                        
                    }
                } else {
                    cell.backgroundColor = YYSectionFooterColor;
                }
                break;
            case AddressInfoSection:
            {
                if (indexPath.row == 0) {
                    cell.type = YYDealDetailViewCellTypeAddress;
                    cell.accessoryView = nil;
                } else {
                    cell.backgroundColor = YYSectionFooterColor;
                }
            }
                break;
            case RecieveDateSection:
            {
                if (indexPath.row == 0) {
                    cell.type = YYDealDetailViewCellTypeSelectRecieveDate;
                    cell.accessoryView = nil;
                    cell.textLabel.text = @"2017-11-27 收货";
                } else {
                    cell.backgroundColor = YYSectionFooterColor;
                }
            }
                break;
            case GoodsInfoSection:
                if (indexPath.row == 0) {
                    cell.type = YYDealDetailViewCellTypeShop;
                    cell.textLabel.text = self.dealModel.shopModel.shopName;
                } else if (indexPath.row == self.dealModel.goodsArray.count + 1) {
                    cell.backgroundColor = YYSectionFooterColor;
                    
                } else if (indexPath.row == self.dealModel.goodsArray.count + 2) {
                    cell.type = YYDealDetailViewCellTypeSelectDuration;
                    cell.detailTextLabel.text = @"租用10天";
                } else {
                    cell.type = self.dealModel.statusType == YYDealStatusTypeWaitForSubmit ? YYDealDetailViewCellTypeGoodsWithFee : YYDealDetailViewCellTypeGoods;
                    cell.goodsModel = self.dealModel.goodsArray[indexPath.row - 1];
                    cell.showGoodsDamageDetailBlock = ^(YYGoodsModel *goodsModel) {
                        YYAlertView *alertView = [[YYAlertView alloc] initWithType:YYAlertViewTypeGoodsDamageImage];
                        alertView.goodsDamageImageArray = @[@"woman37.jpg", @"woman27.jpg", @"woman22.jpg"];
                        [alertView show];
                    };
                }
                break;
            case GoodsFeeInfoSection:
            {
                switch (indexPath.row) {
                    case 0:
                        cell.textLabel.text = @"商品金额";
                        cell.detailTextLabel.text = @"￥670.00";
                        break;
                    case 1:
                        if (self.dealModel.statusType == YYDealStatusTypeWaitForSubmit) {
                            cell.backgroundColor = YYSectionFooterColor;
                        } else {
                            cell.textLabel.text = @"运费";
                            cell.detailTextLabel.text = @"+￥12.00";
                        }
                        break;
                    case 2:
                        cell.textLabel.text = @"优惠金额";
                        cell.detailTextLabel.text = @"-￥10.00";
                        break;
                    case 3:
                        cell.textLabel.text = @"实付款";
                        cell.detailTextLabel.textColor = YYGlobalColor;
                        cell.detailTextLabel.text = @"￥718.00";
                        break;
                    default:
                        cell.backgroundColor = YYSectionFooterColor;
                        break;
                }
            }
                break;
            case ServiceFeeInfoSection:
            {
                NSString *text = @"";
                NSString *fee = @"";
                switch (indexPath.row) {
                    case WashFeeRow:
                        text = @"干洗费";
                        fee = @"￥60.00";
                        break;
                    case TryFeeRow:
                        text = @"体验费";
                        fee = @"￥50.00";
                        break;
                    case ServiceFeeRow:
                        cell.type = YYDealDetailViewCellTypeServiceFee;
                        cell.detailTextLabel.textColor = YYGlobalColor;
                        text = @"服务费";
                        fee = @"-￥110.00";
                        break;
                    case DamageFeeRow:
                        cell.detailTextLabel.textColor = YYGlobalColor;
                        text = @"折损费";
                        fee = @"-￥1.00";
                        break;
                    case DeliveryFeeRow:
                        cell.detailTextLabel.textColor = YYGlobalColor;
                        text = @"取送费";
                        fee = @"-￥10.00";
                        break;
                    default:
                        break;
                }
                if (indexPath.row == 5) {
                    cell.backgroundColor = YYSectionFooterColor;
                } else {
                    cell.textLabel.text = text;
                    cell.detailTextLabel.text = fee;
                }
            }
                break;
            case DiscountFeeInfoSection:
            {
                switch (indexPath.row) {
                    case 0:
                    {
                        cell.textLabel.text = @"积分";
                        cell.bonusPoints = @"6";
                        cell.type = YYDealDetailViewCellTypeBonusPoints;
                        cell.useBonusPointsBlock = ^(NSString *bonusPoints) {
                            _bonusPoints = bonusPoints;
                            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:DiscountFeeInfoSection]] withRowAnimation:UITableViewRowAnimationNone];
                        };
                    }
                        break;
                    case 1:
                        cell.type = YYDealDetailViewCellTypeSelectCoupon;
                        break;
                    case 2:
                        cell.textLabel.text = @"积分兑换";
                        cell.detailTextLabel.textColor = YYGlobalColor;
                        break;
                    default:
                        cell.backgroundColor = YYSectionFooterColor;
                        break;
                }
            }
                break;
            case ReturnFeeInfoSection:
            {
                switch (indexPath.row) {
                    case 0:
                        cell.type = YYDealDetailViewCellTypeReturnFee;
                        cell.textLabel.text = @"退回金额";
                        cell.detailTextLabel.textColor = YYGlobalColor;
                        cell.detailTextLabel.text = @"￥685.00";
                        break;
                    case 1:
                        cell.type = YYDealDetailViewCellTypeCallShop;
                        break;
                    default:
                        cell.backgroundColor = YYSectionFooterColor;
                        break;
                }
            }
                break;
            default:
                break;
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYDealDetailViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    switch (indexPath.section) {
        case DiscountFeeInfoSection:
            if (indexPath.row == 2) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"+￥%.2f", [_bonusPoints doubleValue]];
            }
            break;
            
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case DeliveryInfoSection:
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowDealDeliveryDetail:)]) {
                [_delegate executeShowDealDeliveryDetail:_dealModel];
            }
            break;
        case GoodsInfoSection:
            if (indexPath.row > 0) {
                YYDealDetailViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                if (!cell.isShowingDamageInfo) {
                    if (_delegate && [_delegate respondsToSelector:@selector(executeShowGoodsDetail:)]) {
                        [_delegate executeShowGoodsDetail:self.dealModel.goodsArray[indexPath.row - 1]];
                    }
                }
            }
            break;
        case 6:
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case DealStatusSection:
            if (indexPath.row == 1) {
                return RELATIVE_WIDTH(10);
            }
            return RELATIVE_WIDTH(150);
            break;
        case DeliveryInfoSection:
            if (self.dealModel.statusType == YYDealStatusTypeWaitForComment ||
                self.dealModel.statusType == YYDealStatusTypeWaitForRecieve ||
                self.dealModel.statusType == YYDealStatusTypeWaitForSubmit) {
                if (indexPath.row == 1) {
                    return RELATIVE_WIDTH(RELATIVE_WIDTH(10));
                }
                return RELATIVE_WIDTH(100);
            } else {
                return 0.00001;
            }
            break;
        case AddressInfoSection:
            if (indexPath.row == 1) {
                return RELATIVE_WIDTH(10);
            }
            return RELATIVE_WIDTH(170);
            break;
        case RecieveDateSection:
            if (indexPath.row == 1) {
                return RELATIVE_WIDTH(10);
            }
            return RELATIVE_WIDTH(80);
            break;
        case GoodsFeeInfoSection:
            if (self.dealModel.statusType == YYDealStatusTypeWaitForSubmit) {
                if (indexPath.row == 1) {
                    return RELATIVE_WIDTH(10);
                }
            } else {
                if (indexPath.row == 4) {
                    return RELATIVE_WIDTH(10);
                }
                return RELATIVE_WIDTH(80);
            }
            
            break;
        case GoodsInfoSection:
            if (indexPath.row == 0 || indexPath.row == self.dealModel.goodsArray.count + 2) {
                return RELATIVE_WIDTH(80);
            } else if (indexPath.row == self.dealModel.goodsArray.count + 1) {
                return RELATIVE_WIDTH(10);
            } else {
                if (self.dealModel.statusType == YYDealStatusTypeWaitForSubmit) {
                    return RELATIVE_WIDTH(292);
                }
                return RELATIVE_WIDTH(232);
            }
            break;
        case ServiceFeeInfoSection:
            if (indexPath.row == ServiceFeeRow) {
                return RELATIVE_WIDTH(120);
            }
            if (indexPath.row == 5) {
                return RELATIVE_WIDTH(10);
            }
            break;
        case DiscountFeeInfoSection:
            if (indexPath.row == 3) {
                return RELATIVE_WIDTH(10);
            }
            break;
        case ReturnFeeInfoSection:
            if (indexPath.row == 0) {
                return RELATIVE_WIDTH(180);
            }
            if (indexPath.row == 2) {
                return RELATIVE_WIDTH(10);
            }
            break;
        default:
            break;
    }
    return RELATIVE_WIDTH(80);
}


@end
