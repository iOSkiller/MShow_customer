//
//  YYWalletQuestionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/12.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYWalletQuestionView.h"

@interface YYWalletQuestionView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation YYWalletQuestionView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.separatorColor = YYSeparatorColor;
        view.delegate = self;
        view.dataSource = self;
        view.tableFooterView = [UIView new];
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _dataArray = @[@"什么是账户余额？", @"充值限制", @"提现限制", @"提现到账时间"];
        [self tableView];
    }
    return self;
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"cellID:%@%@", @(indexPath.row), @(indexPath.section)];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = YYTextColor;
        cell.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(32)];
        cell.textLabel.text = self.dataArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_showQuestionDetailBlock) {
        _showQuestionDetailBlock(indexPath.row);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(100);
}

@end
