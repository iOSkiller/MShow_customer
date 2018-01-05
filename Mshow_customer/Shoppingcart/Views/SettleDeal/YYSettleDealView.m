//
//  YYSettleDealView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSettleDealView.h"
#import "YYDealDetailViewCell.h"
#import "YYShopModel.h"
#import "YYAddressModel.h"

@interface YYSettleDealView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) UILabel *addressLabel;
@property (nonatomic, strong) NSMutableArray <YYShopModel *> *originalArray;

@end

@implementation YYSettleDealView

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.mj_h - RELATIVE_WIDTH(66), self.mj_w, RELATIVE_WIDTH(66))];
        label.numberOfLines = 0;
        label.backgroundColor = mRGBAColor(249, 228, 159, 0.75);
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.text = @"   收货地址：江苏省南京市鼓楼区建宁路亚都大厦715";
        label.textColor = YYTextColor;
        label.hidden = YES;
        [self addSubview:label];
        _addressLabel = label;
    }
    return _addressLabel;
}


- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [view setSeparatorColor:YYSeparatorColor];
        [view setSeparatorInset:UIEdgeInsetsZero];
        [view setLayoutMargins:UIEdgeInsetsZero];
        view.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(66))];
        view.delegate = self;
        view.dataSource = self;
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}

- (NSMutableArray *)originalArray {
    if (!_originalArray) {
        _originalArray = [NSMutableArray array];
    }
    return _originalArray;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self tableView];
        [self addressLabel];
    }
    return self;
}

- (void)setGoodsArray:(NSArray *)goodsArray
{
    _goodsArray = goodsArray;
    [self.originalArray addObjectsFromArray:goodsArray];
}

- (void)setAddressModel:(YYAddressModel *)addressModel
{
    _addressModel = addressModel;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    self.addressLabel.text = [NSString stringWithFormat:@"收货地址：%@-%@-%@-%@", addressModel.province, addressModel.city, addressModel.area, addressModel.detailAddress];
}

- (void)updateDuration:(NSString *)duration shop:(YYShopModel *)shopModel indexPath:(NSIndexPath *)indexPath
{
    [self.originalArray enumerateObjectsUsingBlock:^(YYShopModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([shopModel.shopName isEqualToString:obj.shopName]) {
            shopModel.duration = duration;
            [self.originalArray replaceObjectAtIndex:idx withObject:shopModel];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            *stop = YES;
        }
    }];
}

- (void)setDateForRecieve:(NSString *)dateForRecieve
{
    _dateForRecieve = dateForRecieve;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    
}


#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.originalArray.count + 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 2;
    } else if (section == self.originalArray.count + 2) {
        return 4;
//        return 5;
    } else if (section == self.originalArray.count + 3) {
        return 2;
    } else {
        YYShopModel *model = self.originalArray[section - 2];
//        return model.goodsArray.count + 3;
        return model.goodsArray.count + 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYSettleDealViewCellID:%ld%ld", (long)indexPath.section, (long)indexPath.row];
    YYDealDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYDealDetailViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.type = YYDealDetailViewCellTypeAddress;
            } else {
                cell.backgroundColor = YYSectionFooterColor;
            }
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.type = YYDealDetailViewCellTypeSelectRecieveDate;
            } else {
                cell.backgroundColor = YYSectionFooterColor;
            }
        } else if (indexPath.section == self.originalArray.count + 2) {
            cell.type = YYDealDetailViewCellTypeDealInfo;
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"商品金额";
                    cell.detailTextLabel.text = @"￥670.00";
                    break;
                case 1:
                    cell.textLabel.text = @"运费";
                    cell.detailTextLabel.text = @"+￥12.00";
                    break;
                case 2:
                    cell.textLabel.text = @"干洗费";
                    cell.detailTextLabel.text = @"￥6.00";
                    break;
//                case 3:
//                    cell.textLabel.text = @"体验费";
//                    cell.detailTextLabel.text = @"+￥10.00";
//                    break;
                default:
                    cell.backgroundColor = YYSectionFooterColor;
                    break;
            }
        } else if (indexPath.section == self.originalArray.count + 3) {
            if (indexPath.row == 0) {
                cell.type = YYDealDetailViewCellTypeSelectCoupon;
                cell.detailTextLabel.textColor = YYGrayTextColor;
                cell.detailTextLabel.text = @"使用优惠券";
            } else {
                cell.backgroundColor = YYSectionFooterColor;
            }
        } else {
            YYShopModel *model = self.originalArray[indexPath.section - 2];
            if (indexPath.row == 0) {
                cell.type = YYDealDetailViewCellTypeShop;
                cell.textLabel.text = model.shopName;
            } else if (indexPath.row == model.goodsArray.count + 2) {
                cell.type = YYDealDetailViewCellTypeSelectDuration;
                cell.detailTextLabel.text = [model.duration integerValue] > 0 ? [NSString stringWithFormat:@"试穿%@天", model.duration] : @"请选择试穿天数";
            } else if (indexPath.row == model.goodsArray.count + 1) {
                cell.backgroundColor = YYSectionFooterColor;
            } else {
                cell.type = YYDealDetailViewCellTypeGoods;
                cell.goodsModel = model.goodsArray[indexPath.row - 1];
            }
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYDealDetailViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = [_dateForRecieve isValid] ? AppendString(_dateForRecieve, @" 收货") : @"请选择收货时间";
        }
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.addressModel = _addressModel;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >= 2 && indexPath.section < self.originalArray.count + 1) {
        YYShopModel *model = self.originalArray[indexPath.section - 2];
        if (indexPath.row == model.goodsArray.count + 1) {
            if (_delegate && [_delegate respondsToSelector:@selector(executeSelectDuration:indexPath:)]) {
                [_delegate executeSelectDuration:model indexPath:indexPath];
            }
        }
    }
    if (indexPath.section == 1) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeSelectDateForRecieve)]) {
            [_delegate executeSelectDateForRecieve];
        }
    }
    if (indexPath.section == 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeSelectAddress)]) {
            [_delegate executeSelectAddress];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return RELATIVE_WIDTH(10);
        }
        return RELATIVE_WIDTH(170);
    } else if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            return RELATIVE_WIDTH(10);
        }
        return RELATIVE_WIDTH(80);
    } else if (indexPath.section == self.originalArray.count + 2) {
        if (indexPath.row == 3) {
            return RELATIVE_WIDTH(10);
        }
        return RELATIVE_WIDTH(80);
    } else if (indexPath.section == self.originalArray.count + 3) {
        if (indexPath.row == 1) {
            return RELATIVE_WIDTH(10);
        }
        return RELATIVE_WIDTH(80);
    } else {
        YYShopModel *model = self.originalArray[indexPath.section - 2];
        if (indexPath.row == 0 || indexPath.row == model.goodsArray.count + 2) {
            return RELATIVE_WIDTH(80);
        } else if (indexPath.row == model.goodsArray.count + 1) {
            return 0.00001;
        } else {
            return RELATIVE_WIDTH(232);
        }
    }
    return 1;
}

@end
