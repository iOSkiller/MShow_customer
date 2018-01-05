//
//  YYHistoryTableView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/15.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHistoryTableView.h"
#import "YYHistoryTableViewCell.h"
#import "YYHistoryModel.h"
#import "YYGoodsModel.h"

@interface YYHistoryTableView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray <YYHistoryModel *> *selectArray;
@property (nonatomic, strong) NSMutableArray <YYHistoryModel *> *originalArray;

@end

@implementation YYHistoryTableView

- (NSMutableArray <YYHistoryModel *> *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (NSMutableArray <YYHistoryModel *> *)originalArray {
    if (!_originalArray) {
        _originalArray = [NSMutableArray array];
    }
    return _originalArray;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [view setSeparatorColor:YYSeparatorColor];
        [view setSeparatorInset:UIEdgeInsetsZero];
        [view setLayoutMargins:UIEdgeInsetsZero];
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
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    [self.originalArray removeAllObjects];
    [self.originalArray addObjectsFromArray:dataArray];
    [self.tableView reloadData];
}

- (void)updateSelectArray:(YYGoodsModel *)goods isSelected:(BOOL)isSelected indexPath:(NSIndexPath *)indexPath
{
    YYHistoryModel *historyModel = self.originalArray[indexPath.section];
    for (YYHistoryModel *originalHistoryModel in self.dataArray) {
        for (YYGoodsModel *originalModel in originalHistoryModel.goodsArray) {
            //更新原数据
            if ([originalModel.goodsID isEqualToString:goods.goodsID]) {
                originalModel.isSelected = isSelected;
                break;
            }
        }
    }
    if (isSelected) {
        [historyModel.selectArray addObject:goods];
    } else {
        [historyModel.selectArray removeObject:goods];
        if (historyModel.goodsArray.count == 0) {
            [self.selectArray removeObject:historyModel];
        }
    }
    
    historyModel.isSelected = historyModel.selectArray.count == historyModel.goodsArray.count;
    for (YYHistoryModel *originalModel in self.dataArray) {
        if ([originalModel.date isEqualToString:historyModel.date]) {
            originalModel.isSelected = historyModel.isSelected;
            break;
        }
    }
    
    __block BOOL isHaven = NO;
    //枚举器遍历数组
    [self.selectArray enumerateObjectsUsingBlock:^(YYHistoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //更新数据
        if ([obj.historyID isEqualToString:historyModel.historyID]) {
            [self.selectArray replaceObjectAtIndex:idx withObject:historyModel];
            isHaven = YES;
            *stop = YES;
        }
    }];
    
    if (!isHaven) {
        [self.selectArray addObject:historyModel];
    }
    [self.tableView reloadData];
}

- (void)deleteSelectedGoods
{
    for (YYHistoryModel *selectModel in self.selectArray) {
        if (selectModel.selectArray.count == selectModel.goodsArray.count) {
            [self.originalArray removeObject:selectModel];
        } else {
            //枚举器遍历数组
            [self.originalArray enumerateObjectsUsingBlock:^(YYHistoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //更新数据
                if ([obj.historyID isEqualToString:selectModel.historyID]) {
                    NSMutableArray *array = [NSMutableArray arrayWithArray:selectModel.goodsArray];
                    [array removeObjectsInArray:selectModel.selectArray];
                    [selectModel.selectArray removeAllObjects];
                    selectModel.goodsArray = array;
                    [self.originalArray replaceObjectAtIndex:idx withObject:selectModel];
                    *stop = YES;
                }
            }];
        }
    }
    
    [self.tableView reloadData];
    [self.selectArray removeAllObjects];
}

- (void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.originalArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YYHistoryModel *historyModel = self.originalArray[section];
    return historyModel.goodsArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"cellID:%@%@", @(indexPath.row), @(indexPath.section)];
    YYHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        WS(weakSelf);
        if (indexPath.row == 0) {
            cell.type = YYHistoryTableViewCellTypeFunction;
            cell.selectAllGoodsBlock = ^(BOOL isSelected) {
                StrongSelf(strongSelf);
                strongSelf = weakSelf;
                YYHistoryModel *model = strongSelf.originalArray[indexPath.section];
                model.isSelected = isSelected;
                for (YYGoodsModel *goodsModel in model.goodsArray) {
                    goodsModel.isSelected = isSelected;
                }
                if (isSelected) {
                    [model.selectArray addObjectsFromArray:model.goodsArray];
                    [strongSelf.selectArray addObject:model];
                } else {
                    [model.selectArray removeAllObjects];
                    [strongSelf.selectArray removeObject:model];
                }
                [strongSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            };
        } else {
            cell.type = YYHistoryTableViewCellTypeGoods;
            cell.showShopDetailBlock = ^(NSString *shopID) {
                if (_delegate && [_delegate respondsToSelector:@selector(tableViewShowShopDetail:)]) {
                    [_delegate tableViewShowShopDetail:shopID];
                }
            };
            
            cell.selectGoodsBlock = ^(YYGoodsModel *goodsModel) {
                StrongSelf(strongSelf);
                strongSelf = weakSelf;
                [strongSelf updateSelectArray:goodsModel isSelected:goodsModel.isSelected indexPath:indexPath];
            };
        }
        
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0 && !_isEditing) {
        if (_delegate && [_delegate respondsToSelector:@selector(tableViewShowGoodsDetail:)]) {
            YYHistoryModel *historyModel = self.originalArray[indexPath.section];
            [_delegate tableViewShowGoodsDetail:historyModel.goodsArray [indexPath.row - 1]];
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYHistoryTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    cell.isEditing = _isEditing;
    YYHistoryModel *historyModel = self.originalArray[indexPath.section];
    if (indexPath.row == 0) {
        cell.date = historyModel.date;
        cell.isAllSelected = historyModel.isSelected;
    } else {
        cell.goodsModel = historyModel.goodsArray[indexPath.row - 1];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return RELATIVE_WIDTH(60);
    }
    return RELATIVE_WIDTH(222);
}

@end
