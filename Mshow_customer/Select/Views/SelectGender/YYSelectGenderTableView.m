//
//  YYSelectGenderTableView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectGenderTableView.h"
#import "YYSelectGenderTableViewCell.h"

@interface YYSelectGenderTableView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) YYBaseTableView *tableView;

@end

@implementation YYSelectGenderTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.separatorColor = YYSeparatorColor;
        view.separatorInset = UIEdgeInsetsZero;
        view.layoutMargins = UIEdgeInsetsZero;
        view.backgroundColor = [UIColor whiteColor];
        view.delegate = self;
        view.dataSource = self;
        view.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(30))];
        [self addSubview:view];
        _tableView = view;
        _dataArray = [NSMutableArray array];
        self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            if (_delegate && [_delegate respondsToSelector:@selector(tableViewLoadMoreData)]) {
                [_delegate tableViewLoadMoreData];
            }
        }];
        WS(ws);
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
    }
    return self;
}

- (void)setGoodsArray:(NSArray *)goodsArray
{
    if (self.dataArray.count > 0) {
        goodsArray.count < 10 ? [self.tableView.mj_footer endRefreshingWithNoMoreData] : [self.tableView.mj_footer endRefreshing];
    }
    
    _goodsArray = goodsArray;
    [self.dataArray addObjectsFromArray:goodsArray];
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    self.tableView.mj_footer.hidden = self.tableView.contentSize.height < self.tableView.mj_h;
}

- (void)scrollToIndex:(NSUInteger)index
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

- (void)endRefresh
{
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"cellID:%@%@", @(indexPath.row), @(indexPath.section)];
    YYSelectGenderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYSelectGenderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.goodsModel = self.dataArray[indexPath.row];
        cell.showShopDetailBlock = ^(NSString *shopID) {
            if (_delegate && [_delegate respondsToSelector:@selector(selectGenderTableView:showShopDetail:)]) {
                [_delegate selectGenderTableView:self showShopDetail:shopID];
            }
        };
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(selectGenderTableView:showGoodsDetail:)]) {
        [_delegate selectGenderTableView:self showGoodsDetail:self.goodsArray[indexPath.row]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(222);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSIndexPath *indexPath = [[self.tableView indexPathsForVisibleRows] firstObject];
    if (_delegate && [_delegate respondsToSelector:@selector(tableViewDidScrollToIndex:)]) {
        [_delegate tableViewDidScrollToIndex:indexPath.row];
    }
}

@end
