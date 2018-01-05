//
//  YYDealChildView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/10.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYDealChildView.h"
#import "YYMineWardrobeViewCell.h"
#import "YYDealModel.h"
#import "YYGoodsModel.h"
#import "YYShopModel.h"

@interface YYDealChildView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;

@end

@implementation YYDealChildView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView setSeparatorColor:YYSeparatorColor];
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        [tableView setLayoutMargins:UIEdgeInsetsZero];
//        tableView.backgroundColor = mRGBToColor(0xf0f0f0);
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
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView.mj_header endRefreshing];
            });
        }];
        
        self.tableView.mj_footer  =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView.mj_footer endRefreshing];
            });
        }];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.tableView reloadData];
}

- (void)deleteDeal:(YYDealModel *)dealModel
{
    NSMutableArray <YYDealModel *> *array = [NSMutableArray arrayWithArray:_dataArray];
    [array enumerateObjectsUsingBlock:^(YYDealModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([dealModel.dealID isEqualToString:obj.dealID]) {
            *stop = YES;
            [array removeObject:obj];
            _dataArray = array;
            [self.tableView beginUpdates];
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:idx] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }
    }];
}

- (void)updateDealStatus:(YYDealModel *)dealModel
{
    NSMutableArray <YYDealModel *> *array = [NSMutableArray arrayWithArray:_dataArray];
    [array enumerateObjectsUsingBlock:^(YYDealModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([dealModel.dealID isEqualToString:obj.dealID]) {
            *stop = YES;
            [array replaceObjectAtIndex:idx withObject:dealModel];
            _dataArray = array;
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:idx] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }
    }];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YYDealModel *model = self.dataArray[section];
    return model.goodsArray.count + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"cellID:%ld%ld", (long)indexPath.row, (long)indexPath.section];
    YYMineWardrobeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        YYDealModel *dealModel = self.dataArray[indexPath.section];
        cell = [[YYMineWardrobeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        if (indexPath.row == 0) {
            switch (_type) {
                case YYDealStatusTypeWaitForSubmit:
                case YYDealStatusTypeInAppeal:
                    cell.type = YYMineWardrobeViewCellTypeTitleWithState;
                    break;
                case YYDealStatusTypeWaitForRecieve:
                    cell.type = YYMineWardrobeViewCellTypeTitleWithFuction;
                    break;
                default:
                    cell.type = YYMineWardrobeViewCellTypeTitle;
                    break;
            }
        } else if (indexPath.row == dealModel.goodsArray.count + 1) {
            if (_type == YYDealStatusTypeAll) {
                cell.dealStatusType = YYDealStatusTypeWaitForPay;
            } else {
                cell.dealStatusType = _type;
            }
        } else if (indexPath.row == dealModel.goodsArray.count + 2) {
            cell.backgroundColor = YYSectionFooterColor;
        } else {
            cell.type = _type == YYDealStatusTypeWaitForReturn ? YYMineWardrobeViewCellTypeTriedGoods : YYMineWardrobeViewCellTypeBoughtGoods;
        }
        cell.actionBlock = ^(YYMineFunctionType functionType, YYGoodsModel *goodsModel, YYDealModel *dealModel, YYShopModel *shopModel) {
            switch (functionType) {
                case YYMineFunctionTypeDeleteDeal:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeDeletDeal:)]) {
                        [_delegate executeDeletDeal:dealModel];
                    }
                    break;
                case YYMineFunctionTypeReturnBySelf:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeReturnBySelf:)]) {
                        [_delegate executeReturnBySelf:dealModel];
                    }
                    break;
                case YYMineFunctionTypeReturn:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeReturnGoods:)]) {
                        [_delegate executeReturnGoods:dealModel];
                    }
                    break;
                case YYMineFunctionTypeBuy:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeBuyGoods:)]) {
                        [_delegate executeBuyGoods:dealModel];
                    }
                    break;
                case YYMineFunctionTypeCancelDeal:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeCancelDeal:)]) {
                        [_delegate executeCancelDeal:dealModel];
                    }
                    break;
                case YYMineFunctionTypeConformReceipt:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeConfirmReceipt:)]) {
                        [_delegate executeConfirmReceipt:dealModel];
                    }
                    break;
                case YYMineFunctionTypeComments:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeCommentDeal:)]) {
                        [_delegate executeCommentDeal:dealModel];
                    }
                    break;
                case YYMineFunctionTypePayDeal:
                    if (_delegate && [_delegate respondsToSelector:@selector(executePayDeal:)]) {
                        [_delegate executePayDeal:dealModel];
                    }
                    break;
                case YYMineFunctionTypeRemindDeal:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeReturnGoods:)]) {
                        [_delegate executeRemindDeal:dealModel];
                    }
                    break;
                case YYMineFunctionTypeShowDelivery:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeShowDealDelivery:)]) {
                        [_delegate executeShowDealDelivery:dealModel];
                    }
                    break;
                case YYMineFunctionTypeSubmitDeal:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeSubmitDeal:)]) {
                        [_delegate executeSubmitDeal:dealModel];
                    }
                    break;
                case YYMineFunctionTypeAppeal:
                    if (_delegate && [_delegate respondsToSelector:@selector(executeAppealDeal:)]) {
                        [_delegate executeAppealDeal:dealModel];
                    }
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
    } else if (indexPath.row == dealModel.goodsArray.count + 2) {
        
    } else {
        cell.goodsModel = dealModel.goodsArray[indexPath.row - 1];
    }
    
    switch (_type) {
        case YYDealStatusTypeWaitForSubmit:
        case YYDealStatusTypeInAppeal:
            cell.state = dealModel.statusType == YYDealStatusTypeInAppeal ? @"买家申诉中" : @"买家已收货";
            break;
            
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeShowDealDetail:)]) {
        [_delegate executeShowDealDetail:self.dataArray[indexPath.section]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYDealModel *dealModel = self.dataArray[indexPath.section];
    if (indexPath.row == 0) {
        return RELATIVE_WIDTH(80);
    } else if (indexPath.row == dealModel.goodsArray.count + 1) {
        return RELATIVE_WIDTH(132);
    } else if (indexPath.row == dealModel.goodsArray.count + 2) {
        return RELATIVE_WIDTH(10);
    } else {
        return RELATIVE_WIDTH(238);
    }
}


@end
