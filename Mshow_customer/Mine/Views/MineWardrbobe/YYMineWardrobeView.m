//
//  YYMineWardrobeView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/9.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineWardrobeView.h"
#import "YYMineWardrobeViewCell.h"
#import "YYDealModel.h"
#import "YYShopModel.h"
#import "YYGoodsModel.h"

@interface YYMineWardrobeView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) YYBaseTableView *tableView;
@end

@implementation YYMineWardrobeView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView setSeparatorColor:YYSeparatorColor];
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        [tableView setLayoutMargins:UIEdgeInsetsZero];
        tableView.backgroundColor = [UIColor whiteColor];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(1))];
        headerView.backgroundColor = YYSeparatorColor;
        tableView.tableHeaderView = headerView;
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(40))];
        footerView.backgroundColor = [UIColor whiteColor];
        tableView.tableFooterView = footerView;
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

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YYDealModel *dealModel = self.dataArray[section];
    return dealModel.goodsArray.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"cellID:%ld%ld", (long)indexPath.row, (long)indexPath.section];
    
    YYMineWardrobeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        YYDealModel *dealModel = self.dataArray[indexPath.section];
        cell = [[YYMineWardrobeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        if (indexPath.row == 0) {
            cell.type = YYMineWardrobeViewCellTypeTitle;
        } else if (indexPath.row == dealModel.goodsArray.count + 1) {
            cell.type = _type == YYMineWardrobeViewTypePayed ? YYMineWardrobeViewCellTypeDealFunction : YYMineWardrobeViewCellTypeGoodsFunction;
        } else {
            cell.type = _type == YYMineWardrobeViewTypePayed ? YYMineWardrobeViewCellTypeBoughtGoods : YYMineWardrobeViewCellTypeTriedGoods;
        }
        cell.actionBlock = ^(YYMineFunctionType functionType, YYGoodsModel *goodsModel, YYDealModel *dealModel, YYShopModel *shopModel) {
            switch (functionType) {
                case YYMineFunctionTypeShowShop:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeShowShopDetail:)]) {
                        [_delegate executeShowShopDetail:shopModel];
                    }
                    break;
                case YYMineFunctionTypeShowDelivery:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeShowDeliveryDetail:)]) {
                        [_delegate executeShowDeliveryDetail:dealModel];
                    }
                    break;
                case YYMineFunctionTypeComments:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeCommentGoods:)]) {
                        [_delegate executeCommentGoods:goodsModel];
                    }
                    break;
                case YYMineFunctionTypeBuy:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeBuyGoods:)]) {
                        [_delegate executeBuyGoods:goodsModel];
                    }
                    break;
                case YYMineFunctionTypeChange:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeChangeGoods:)]) {
                        [_delegate executeChangeGoods:goodsModel];
                    }
                    break;
                case YYMineFunctionTypeReturn:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeReturnGoods:)]) {
                        [_delegate executeReturnGoods:goodsModel];
                    }
                    break;
                case YYMineFunctionTypeShow:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeShowGoodsQuality:)]) {
                        [_delegate executeShowGoodsQuality:goodsModel];
                    }
                    break;
                default:
                    break;
            }
        };
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYMineWardrobeViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    YYDealModel *dealModel = self.dataArray[indexPath.section];
    if (indexPath.row == 0) {
        cell.shopModel = dealModel.shopModel;
    } else if (indexPath.row == dealModel.goodsArray.count + 1) {
        cell.dealModel = dealModel;
    } else {
        cell.goodsModel = dealModel.goodsArray[indexPath.row - 1];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0 && indexPath.row < 2) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeShowGoodsDetail:)]) {
            [_delegate executeShowGoodsDetail:[YYGoodsModel new]];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYDealModel *dealModel = self.dataArray[indexPath.section];
    if (indexPath.row == 0) {
        return RELATIVE_WIDTH(80);
    } else if (indexPath.row == dealModel.goodsArray.count + 1) {
        return RELATIVE_WIDTH(132);
    } else {
        return RELATIVE_WIDTH(238);
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.0000001;
    }
    return RELATIVE_WIDTH(10);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = RELATIVE_WIDTH(10);
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

@end
