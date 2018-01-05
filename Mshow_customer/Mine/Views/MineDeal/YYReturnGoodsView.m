//
//  YYReturnGoodsView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYReturnGoodsView.h"
#import "YYReturnGoodsViewCell.h"
#import "YYReturnGoodsFunctionView.h"
#import "YYGoodsModel.h"

@interface YYReturnGoodsView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYReturnGoodsFunctionView *functionView;
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray <YYGoodsModel *> *selectArray;
@property (nonatomic, strong) NSMutableArray <YYGoodsModel *> *originalArray;

@end

@implementation YYReturnGoodsView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h - RELATIVE_WIDTH(100) - iPhone_MARGIN_BOTTOM) style:UITableViewStylePlain];
        view.tableFooterView = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.separatorColor = YYSeparatorColor;
        view.separatorInset = UIEdgeInsetsZero;
        view.layoutMargins = UIEdgeInsetsZero;
        view.delegate = self;
        view.dataSource = self;
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}

- (YYReturnGoodsFunctionView *)functionView {
    if (!_functionView) {
        YYReturnGoodsFunctionView *view = [[YYReturnGoodsFunctionView alloc] initWithFrame:CGRectMake(0, self.mj_h - RELATIVE_WIDTH(100) - iPhone_MARGIN_BOTTOM, self.mj_w, RELATIVE_WIDTH(100) + iPhone_MARGIN_BOTTOM)];
        [self addSubview:view];
        _functionView = view;
    }
    return _functionView;
}

- (NSMutableArray <YYGoodsModel *> *)originalArray {
    if (!_originalArray) {
        _originalArray = [NSMutableArray array];
    }
    return _originalArray;
}

- (NSMutableArray <YYGoodsModel *> *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        WS(ws);
        self.backgroundColor = [UIColor whiteColor];
        
        [self.functionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws).offset(-iPhone_MARGIN_BOTTOM);
            make.left.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(100));
        }];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.functionView.mas_top);
            make.top.left.right.equalTo(ws);
        }];
        
        self.functionView.selectAllBlock = ^(BOOL isSelected) {
            StrongSelf(strongSelf);
            strongSelf = ws;
            for (YYGoodsModel *model in self.originalArray) {
                model.isSelected = isSelected;
            }
            isSelected ? [self.selectArray addObjectsFromArray:self.originalArray] : [self.selectArray removeAllObjects];
            [strongSelf.tableView reloadData];
        };
        
        self.functionView.sureActionBlock = ^{
            if (_delegate && [_delegate respondsToSelector:@selector(executeSureAction:)]) {
                [_delegate executeSureAction:self.selectArray];
            }
        };
        
    }
    return self;
}

- (void)setGoodsArray:(NSArray *)goodsArray
{
    _goodsArray = goodsArray;
    [self.originalArray addObjectsFromArray:goodsArray];
    for (YYGoodsModel *goodsModel in self.originalArray) {
        goodsModel.isSelected = NO;
    }
    [self.tableView reloadData];
}

- (void)updateSelectGoods:(YYGoodsModel *)goodsModel
{
    if (goodsModel.isSelected) {
        [self.selectArray addObject:goodsModel];
    } else {
        [self.selectArray removeObject:goodsModel];
    }
    self.functionView.haveSelectdGoods = self.selectArray.count > 0;
    self.functionView.isAllSelected = self.selectArray.count == self.originalArray.count;
    [self.originalArray enumerateObjectsUsingBlock:^(YYGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([goodsModel.goodsID isEqualToString:obj.goodsID]) {
            *stop = YES;
            [self.originalArray replaceObjectAtIndex:idx withObject:goodsModel];
        }
    }];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.originalArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"cellid:%@%@", @(indexPath.row), @(indexPath.section)];
    YYReturnGoodsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYReturnGoodsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        WS(weakSelf);
        cell.selectBlock = ^(YYGoodsModel *goodsModel) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            [strongSelf updateSelectGoods:goodsModel];
        };
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYReturnGoodsViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    cell.goodsModel = self.originalArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYGoodsModel *goodsModel = self.originalArray[indexPath.row];
    goodsModel.isSelected = !goodsModel.isSelected;
    [self updateSelectGoods:goodsModel];
    YYReturnGoodsViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.goodsModel = goodsModel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(236);
}


@end
