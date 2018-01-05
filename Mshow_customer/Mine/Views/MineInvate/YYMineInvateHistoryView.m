//
//  YYMineInvateHistoryView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineInvateHistoryView.h"
#import "YYMineInvateHistoryViewCell.h"

@interface YYMineInvateHistoryView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) UILabel *scoreLabel;

@end

@implementation YYMineInvateHistoryView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.backgroundColor = YYSeparatorColor;
        [view setSeparatorColor:YYSeparatorColor];
        [view setSeparatorInset:UIEdgeInsetsZero];
        [view setLayoutMargins:UIEdgeInsetsZero];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(150))];
        headerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(24), RELATIVE_WIDTH(30), self.mj_w - RELATIVE_WIDTH(48), RELATIVE_WIDTH(32))];
        infoLabel.textColor = YYTextColor;
        infoLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        infoLabel.text = @"获得积分";
        infoLabel.textAlignment = NSTextAlignmentCenter;
        infoLabel.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:infoLabel];
        
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(24), infoLabel.mj_h + infoLabel.mj_y + RELATIVE_WIDTH(30), self.mj_w - RELATIVE_WIDTH(58), RELATIVE_WIDTH(36))];
        scoreLabel.backgroundColor = [UIColor whiteColor];
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:scoreLabel];
        _scoreLabel = scoreLabel;
        
        view.tableHeaderView = headerView;
        view.tableFooterView = [UIView new];
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
        [self tableView];
        self.scoreLabel.attributedText = [NSString str1:@"80" font1:[UIFont systemFontOfSize:RELATIVE_WIDTH(34)] color1:YYGlobalColor str2:@"分" font2:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color2:YYGlobalColor];
    }
    return self;
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYMineInvateHistoryViewCellID:%ld%ld", (long)indexPath.section, (long)indexPath.row];
    YYMineInvateHistoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYMineInvateHistoryViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        if (indexPath.row == 0) {
            cell.backgroundColor = YYSectionFooterColor;
        } else {
            cell.historyModel = self.dataArray[indexPath.row - 1];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYMineInvateHistoryViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return RELATIVE_WIDTH(10);
    }
    return RELATIVE_WIDTH(108);
}

@end
