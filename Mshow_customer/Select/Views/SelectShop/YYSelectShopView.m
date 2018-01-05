//
//  YYSelectShopView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectShopView.h"
#import "YYSelectShopViewCell.h"

@interface YYSelectShopView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;

@end


@implementation YYSelectShopView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(160) - 49) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self tableView];
        WS(ws);
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"homeCellID:%ld%ld", (long)indexPath.section, (long)indexPath.row];
    YYSelectShopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYSelectShopViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    cell.backgroundColor = mRGBToColor(0xedd9d5);
    cell.showGoodsBlock = ^(YYGoodsModel *model) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeShowGoods:)]) {
            [_delegate executeShowGoods:model];
        }
    };
    
    cell.gotoShopBlock = ^(YYShopModel *model) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeGotoShop:)]) {
            [_delegate executeGotoShop:model];
        }
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull YYSelectShopViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    cell.shopModel = self.dataArray[indexPath.section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(410);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.0001;
    }
    return RELATIVE_WIDTH(10);
}


@end
