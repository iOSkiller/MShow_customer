//
//  YYMineCollectedGoodsTableView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/15.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineCollectedGoodsTableView.h"
#import "YYMineCollectedGoodsTableViewCell.h"
#import "YYHistoryFunctionView.h"
#import "YYGoodsModel.h"

@interface YYMineCollectedGoodsTableView () <UITableViewDelegate, UITableViewDataSource, YYHistoryFunctionViewDelegate>
@property (nonatomic, weak) YYHistoryFunctionView *functionView;
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, strong) NSMutableArray *originalArray;

@end

@implementation YYMineCollectedGoodsTableView

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (NSMutableArray *)originalArray {
    if (!_originalArray) {
        _originalArray = [NSMutableArray array];
    }
    return _originalArray;
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
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.separatorInset = UIEdgeInsetsZero;
        view.separatorColor = YYSeparatorColor;
        view.layoutMargins = UIEdgeInsetsZero;
        view.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(30))];
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
        WS(ws);
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
        [self functionView];
    }
    return self;
}

- (void)updateSelectArray:(YYGoodsModel *)goodsModel isSelected:(BOOL)isSelected index:(NSUInteger)index
{
    if (isSelected) {
        [self.selectArray addObject:goodsModel];
    } else {
        [self.selectArray removeObject:goodsModel];
    }
}

- (void)deleteSelectedGoods
{
    [self.originalArray removeObjectsInArray:self.selectArray];
    [self.tableView reloadData];
}

- (void)deleteGoods:(YYGoodsModel *)goodsModel indexPath:(NSIndexPath *)indexPath
{
    [self.originalArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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

#pragma mark - YYHistoryFunctionViewDelegate
- (void)executeDelete
{
    if (_delegate && [_delegate respondsToSelector:@selector(tableViewDeleteGoods:)]) {
        [_delegate tableViewDeleteGoods:self.selectArray];
    }
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.originalArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"%@%@", @(indexPath.section), @(indexPath.row)];
    YYMineCollectedGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYMineCollectedGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.showShopDetailBlock = ^(NSString *shopID) {
            if (_delegate && [_delegate respondsToSelector:@selector(tableViewShowShopDetail:)]) {
                [_delegate tableViewShowShopDetail:shopID];
            }
        };
        WS(weakSelf);
        cell.selectGoodsBlock = ^(YYGoodsModel *goodsModel) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            [strongSelf updateSelectArray:goodsModel isSelected:goodsModel.isSelected index:indexPath.row];
        };
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYMineCollectedGoodsTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    cell.goodsModel = self.originalArray[indexPath.row];
    cell.isEditing = _isEditing;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isEditing) {
        if (_delegate && [_delegate respondsToSelector:@selector(tableViewShowGoodsDetail:)]) {
            [_delegate tableViewShowGoodsDetail:self.originalArray[indexPath.row]];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(222);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return !_isEditing;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"取消关注";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(tableViewShouldRemoveGoods:indexPath:)]) {
        [_delegate tableViewShouldRemoveGoods:self.originalArray[indexPath.row] indexPath:indexPath];
    }
}


@end
