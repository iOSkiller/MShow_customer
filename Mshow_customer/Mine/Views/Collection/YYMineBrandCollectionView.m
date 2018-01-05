//
//  YYMineBrandCollectionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/14.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineBrandCollectionView.h"
#import "YYHistoryFunctionView.h"
#import "YYMineBrandCollectionViewCell.h"
#import "YYBrandModel.h"

@interface YYMineBrandCollectionView () <YYHistoryFunctionViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) YYHistoryFunctionView *functionView;
@property (nonatomic, strong) NSMutableArray *selectedArray;
@property (nonatomic, strong) NSMutableArray *originalArray;

@end

@implementation YYMineBrandCollectionView

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
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView setLayoutMargins:UIEdgeInsetsZero];
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        [tableView setSeparatorColor:YYSeparatorColor];
        tableView.backgroundColor = YYSeparatorColor;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.tableFooterView = [UIView new];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.originalArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYMineBrandCollectionViewCellID:%@%@", @(indexPath.row), @(indexPath.section)];
    YYMineBrandCollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYMineBrandCollectionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        WS(weakSelf);
        cell.selectBrandBlock = ^(YYBrandModel *brandModel, BOOL isSelected) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            isSelected ? [strongSelf.selectedArray addObject:brandModel] : [strongSelf.selectedArray removeObject:brandModel];
        };
    }
    cell.isEditing = _isEditing;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYMineBrandCollectionViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    cell.brandModel = self.originalArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isEditing) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeShowBrandDetail:)]) {
            [_delegate executeShowBrandDetail:self.originalArray[indexPath.row]];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return !_isEditing;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.originalArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(100);
}


#pragma mark - YYHistoryFunctionViewDelegate
- (void)executeDelete
{
    [self deleteSelectedShops];
}


@end
