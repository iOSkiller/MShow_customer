//
//  YYMineShopCollectionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineShopCollectionView.h"
#import "YYMineShopCollectionViewCell.h"
#import "YYHistoryFunctionView.h"
#import "YYGoodsModel.h"
#import "YYShopModel.h"

@interface YYMineShopCollectionView () <UITableViewDelegate, UITableViewDataSource, YYHistoryFunctionViewDelegate>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) YYHistoryFunctionView *functionView;
@property (nonatomic, strong) NSMutableArray *selectedArray;
@property (nonatomic, strong) NSMutableArray *originalArray;

@end

@implementation YYMineShopCollectionView

- (NSMutableArray *)originalArray {
    if (!_originalArray) {
        _originalArray = [NSMutableArray array];
    }
    return _originalArray;
}

- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}

- (YYHistoryFunctionView *)functionView {
    if (!_functionView) {
        YYHistoryFunctionView *view = [[YYHistoryFunctionView alloc] initWithFrame:CGRectMake(0, self.mj_h - RELATIVE_WIDTH(100) - (kDevice_Is_iPhoneX ? RELATIVE_WIDTH(20) : 0), self.mj_w, RELATIVE_WIDTH(100))];
        view.delegate = self;
        [self addSubview:view];
        _functionView = view;
    }
    return _functionView;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(80)) style:UITableViewStylePlain];
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
        [self functionView];
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
    [self.originalArray addObjectsFromArray:dataArray];
    [self.tableView reloadData];
}

- (void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    [self.tableView reloadData];
    isEditing ? [self.functionView show] : [self.functionView hide];
    WS(ws);
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws);
        isEditing ? make.bottom.equalTo(self.functionView.mas_top) : make.bottom.equalTo(ws);
    }];    
}

- (void)deleteSelectedShops
{
    [self.originalArray removeObjectsInArray:self.selectedArray];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.originalArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYMineShopCollectionViewCellID:%ld%ld", (long)indexPath.section, (long)indexPath.row];
    YYMineShopCollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        WS(weakSelf);
        cell = [[YYMineShopCollectionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
        
        cell.selectShopBlock = ^(YYShopModel *shopModel, BOOL isSelected) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            isSelected ? [strongSelf.selectedArray addObject:shopModel] : [strongSelf.selectedArray removeObject:shopModel];
        };
    }
    cell.isEditing = _isEditing;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull YYMineShopCollectionViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    cell.shopModel = self.originalArray[indexPath.section];
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

#pragma mark - YYHistoryFunctionViewDelegate
- (void)executeDelete
{
    [self deleteSelectedShops];
}


@end
