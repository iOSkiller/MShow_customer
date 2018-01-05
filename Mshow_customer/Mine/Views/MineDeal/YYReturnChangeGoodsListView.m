//
//  YYReturnChangeGoodsListView.m
//  Mshow_customer
//
//  Created by YYZ on 2018/1/3.
//  Copyright © 2018年 YYZ. All rights reserved.
//

#import "YYReturnChangeGoodsListView.h"
#import "YYMineWardrobeViewCell.h"
#import "YYDealModel.h"

@interface YYReturnChangeGoodsListView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YYReturnChangeGoodsListView

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.backgroundColor = [UIColor whiteColor];
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
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (_delegate && [_delegate respondsToSelector:@selector(executeLoadMoreData)]) {
                [_delegate executeLoadMoreData];
            }
        }];
    }
    return self;
}

- (void)setDealArray:(NSArray *)dealArray
{
    _dealArray = dealArray;
    
    if (self.dataArray.count > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
            
            if (self.dataArray.count > 0) {
                dealArray.count < 10 ? [self.tableView.mj_footer endRefreshingWithNoMoreData] : [self.tableView.mj_footer endRefreshing];
            }
            
            [self.dataArray addObjectsFromArray:_dealArray];
            [self.tableView reloadData];
            [self.tableView layoutIfNeeded];
            self.tableView.mj_footer.hidden = self.tableView.contentSize.height < self.tableView.mj_h;
        });
    } else {
        [self.dataArray addObjectsFromArray:_dealArray];
        [self.tableView reloadData];
        [self.tableView layoutIfNeeded];
        self.tableView.mj_footer.hidden = self.tableView.contentSize.height < self.tableView.mj_h;
    }
    
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YYDealModel *dealModel = self.dataArray[section];
    return dealModel.goodsArray.count + 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYReturnChangeGoodsListViewCellID:%@%@", @(indexPath.row), @(indexPath.section)];
    YYMineWardrobeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYMineWardrobeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        YYDealModel *dealModel = self.dataArray[indexPath.section];
        if (indexPath.row == 0) {
            cell.type = YYMineWardrobeViewCellTypeTitle;
            cell.shopModel = dealModel.shopModel;
        } else if (indexPath.row == dealModel.goodsArray.count + 1) {
            
        } else if (indexPath.row == dealModel.goodsArray.count + 2) {
            cell.type = YYMineWardrobeViewCellTypeReturnChangeGoodsDealFunction;
            cell.actionBlock = ^(YYMineFunctionType functionType, YYGoodsModel *goodsModel, YYDealModel *dealModel, YYShopModel *shopModel) {
                if (_delegate && [_delegate respondsToSelector:@selector(executeShowDealDetail:)]) {
                    [_delegate executeShowDealDetail:dealModel];
                }
            };
        } else if (indexPath.row == dealModel.goodsArray.count + 3) {
            cell.backgroundColor = YYSectionFooterColor;
        } else {
            cell.type = YYMineWardrobeViewCellTypeTriedGoods;
            cell.goodsModel = dealModel.goodsArray[indexPath.row - 1];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYMineWardrobeViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    YYDealModel *dealModel = self.dataArray[indexPath.section];
    if (indexPath.row == dealModel.goodsArray.count + 1) {
        cell.textLabel.text = dealModel.returnChangeStatus;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYDealModel *dealModel = self.dataArray[indexPath.section];
    if (indexPath.row == 0 || indexPath.row == dealModel.goodsArray.count + 1) {
        return RELATIVE_WIDTH(80);
    }
    if (indexPath.row == dealModel.goodsArray.count + 2) {
        return RELATIVE_WIDTH(90);
    }
    if (indexPath.row == dealModel.goodsArray.count + 3) {
        return RELATIVE_WIDTH(10);
    }
    return RELATIVE_WIDTH(232);
}


@end
