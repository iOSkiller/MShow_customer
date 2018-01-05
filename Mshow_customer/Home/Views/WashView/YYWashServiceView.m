//
//  YYWashServiceView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYWashServiceView.h"
#import "YYWashServiceViewCell.h"
#import "YYWashModel.h"

@interface YYWashServiceView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation YYWashServiceView

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableview = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(1), self.mj_w, self.mj_h - RELATIVE_WIDTH(1)) style:UITableViewStylePlain];
        [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tableFooterView = [UIView new];
        [self addSubview:tableview];
        _tableView = tableview;
    }
    return _tableView;
}

- (UIView *)line {
    if (!_line) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(1))];
        view.backgroundColor = YYSeparatorColor;
        [self addSubview:view];
        _line = view;
    }
    return _line;
}


- (instancetype)initWithFrame:(CGRect)frame type:(YYWashServiceType)type
{
    if (self = [super initWithFrame:frame]) {
        [ self.dataArray addObjectsFromArray:type == YYWashServiceTypeBed ? [YYWashModel testWashBedArray] : [YYWashModel testWashCoatArray]];
        [self tableView];
        [self line];
    }
    return self;
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
    NSString *cellID = [NSString stringWithFormat:@"YYWashServiceViewCellID:%@%@", @(indexPath.row), @(indexPath.section)];
    YYWashServiceViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYWashServiceViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.washModel = self.dataArray[indexPath.section];
        WS(weakSelf);
        cell.didSelectCountBlock = ^(NSString *count, YYWashModel *model) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
        };
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYWashModel *model = self.dataArray[indexPath.section];
    return model.cellHeight;
}

@end
