//
//  YYShopGoodsKindView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/29.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShopGoodsKindView.h"
#import "YYShopGoodsKindViewCell.h"
#import "YYShopGoodsKindModel.h"

@interface YYShopGoodsKindView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YYShopGoodsKindView

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(20))];
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.dataArray addObjectsFromArray:[YYShopGoodsKindModel testDataArray]];
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(110))];
        UIView *line = [UIView new];;
        line.backgroundColor = YYSeparatorColor;
        [self.tableView.tableHeaderView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.tableView.tableHeaderView);
            make.height.mas_equalTo(RELATIVE_WIDTH(1));
        }];
        
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.text = @"全部商品";
        [self.tableView.tableHeaderView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.tableView.tableHeaderView);
            make.left.equalTo(self.tableView.tableHeaderView).offset(RELATIVE_WIDTH(26));
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_arrow_right"]];
        arrowView.backgroundColor = [UIColor whiteColor];
        [self.tableView.tableHeaderView addSubview:arrowView];
        [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.tableView.tableHeaderView).offset(-RELATIVE_WIDTH(26));
            make.centerY.equalTo(self.tableView.tableHeaderView);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(26));
        }];
        
        [self.tableView.tableHeaderView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAllGoodsAction)]];
    }
    return self;
}

- (void)showAllGoodsAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeShowAllGoods)]) {
        [_delegate executeShowAllGoods];
    }
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYShopGoodsKindViewCellID:%@%@", @(indexPath.row), @(indexPath.section)];
    YYShopGoodsKindViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYShopGoodsKindViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.kindModel = self.dataArray[indexPath.row];
    }
    cell.didSelectKindBlock = ^(YYShopGoodsKindModel *kindModel) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeShowKind:)]) {
            [_delegate executeShowKind:kindModel];
        }
    };
    
    cell.showAllKindsBlock = ^(YYShopGoodsKindModel *typeModel) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeShowAllKind:)]) {
            [_delegate executeShowAllKind:typeModel];
        }
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYShopGoodsKindModel *model = self.dataArray[indexPath.row];
    return model.cellHeight;
}

@end
