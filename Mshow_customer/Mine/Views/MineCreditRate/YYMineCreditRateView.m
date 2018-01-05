//
//  YYMineCreditRateView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineCreditRateView.h"

@interface YYMineCreditRateView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) UILabel *scoreLabel;

@end

@implementation YYMineCreditRateView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.backgroundColor = YYSeparatorColor;
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        view.delegate = self;
        view.dataSource = self;
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(390))];
        headerView.backgroundColor = YYSeparatorColor;
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(300))];
        backView.backgroundColor = YYGlobalColor;
        [headerView addSubview:backView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(30), RELATIVE_WIDTH(64), self.mj_w - RELATIVE_WIDTH(60), RELATIVE_WIDTH(36))];
        titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(36)];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"当前信用";
        titleLabel.backgroundColor = YYGlobalColor;
        [backView addSubview:titleLabel];
        
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(30), titleLabel.mj_y + titleLabel.mj_h + RELATIVE_WIDTH(46), self.mj_w - RELATIVE_WIDTH(60), RELATIVE_WIDTH(82))];
        scoreLabel.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(80)];
        scoreLabel.textColor = [UIColor whiteColor];
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        scoreLabel.backgroundColor = YYGlobalColor;
        scoreLabel.text = @"100";
        [backView addSubview:scoreLabel];
        _scoreLabel = scoreLabel;
        
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(30), backView.mj_y + backView.mj_h + RELATIVE_WIDTH(40), self.mj_w - RELATIVE_WIDTH(60), RELATIVE_WIDTH(32))];
        infoLabel.textAlignment = NSTextAlignmentCenter;
        infoLabel.textColor = YYTextColor;
        infoLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        infoLabel.text = @"以下内容有助于更好的保持您的信用";
        [headerView addSubview:infoLabel];
        
        view.tableHeaderView = headerView;
        [self addSubview:view];
        _tableView = view;
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
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYMineCreditRateViewID:%ld%ld", (long)indexPath.row, (long)indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.textColor = YYGrayTextColor;
        cell.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        cell.textLabel.text = self.infoArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = YYSeparatorColor;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(40);
}

@end
