//
//  YYMessageCenterView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMessageCenterView.h"
#import "YYMessageCenterViewCell.h"

@interface YYMessageCenterView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;

@end

@implementation YYMessageCenterView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = mRGBToColor(0xf0f0f0);
        [tableView setSeparatorColor:YYSeparatorColor];
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        [tableView setLayoutMargins:UIEdgeInsetsZero];
        tableView.tableFooterView = [UIView new];
        tableView.showsVerticalScrollIndicator = NO;
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self tableView];
    }
    return self;
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"cellID:%ld%ld", (long)indexPath.row, (long)indexPath.section];
    YYMessageCenterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYMessageCenterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYMessageCenterViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.messageModel = self.messageArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeMessageDetail:)]) {
        [_delegate executeMessageDetail:self.messageArray[indexPath.row]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(102);
}

@end
