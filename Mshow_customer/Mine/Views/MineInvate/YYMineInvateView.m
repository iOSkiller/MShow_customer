//
//  YYMineInvateView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineInvateView.h"
#import "YYMineInvateViewCell.h"
#import "YYMineInvateShareView.h"

@interface YYMineInvateView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;

@property (nonatomic ,copy) NSArray *infoArray;

@end

@implementation YYMineInvateView

- (NSArray *)infoArray {
    if (!_infoArray) {
        _infoArray = @[@"1.没成功邀请1位，可获100积分，若好友成功下首单，可再获100积分。", @"2.计算时积分可当现金抵扣。", @"3.邀请好友奖励可累计，多邀多得，不设上限。", @"4.积分可进入“首页>签到”查看。"];
    }
    return _infoArray;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.backgroundColor = [UIColor whiteColor];
        [tableView setSeparatorColor:YYSeparatorColor];
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        [tableView setLayoutMargins:UIEdgeInsetsZero];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(30))];
        tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self tableView];
        UILabel *infoLabel = [UILabel new];
        infoLabel.textColor = YYTextColor;
        infoLabel.text = @"奖励细则";
        infoLabel.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(32)];
        infoLabel.backgroundColor = [UIColor whiteColor];
        [self.tableView.tableFooterView addSubview:infoLabel];
        
        [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tableView.tableFooterView).offset(RELATIVE_WIDTH(20));
            make.left.equalTo(self.tableView.tableFooterView).offset(RELATIVE_WIDTH(24));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(300), RELATIVE_WIDTH(32)));
        }];
        
        UIView *lastView = nil;
        for (int i = 0; i < self.infoArray.count; i ++) {
            UILabel *label = [UILabel new];
            label.textColor = YYGrayTextColor;
            label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
            label.numberOfLines = 0;
            label.text = self.infoArray[i];
            [self.tableView.tableFooterView addSubview:label];
            CGFloat height = [label.text getStringRect:label.font size:CGSizeMake(self.mj_w - RELATIVE_WIDTH(48), MAXFLOAT)].size.height + RELATIVE_WIDTH(6);
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                lastView ? make.top.equalTo(lastView.mas_bottom).offset(RELATIVE_WIDTH(10)) : make.top.equalTo(infoLabel.mas_bottom).offset(RELATIVE_WIDTH(20));
                make.left.equalTo(self.tableView.tableFooterView).offset(RELATIVE_WIDTH(24));
                make.right.equalTo(self.tableView.tableFooterView).offset(-RELATIVE_WIDTH(24));
                make.height.mas_equalTo(height);
            }];
            lastView = label;
        }
    }
    return self;
}


#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYMineCertifyViewCellID:%ld,%ld", (long)indexPath.section, (long)indexPath.row];
    YYMineInvateViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYMineInvateViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"我的邀请码";
            cell.detailTextLabel.text = @"123456";
            break;
        case 1:
            cell.textLabel.text = @"累计邀请人数(成为注册会员)";
            cell.detailTextLabel.text = @"0人";
            break;
        case 2:
            cell.textLabel.text = @"累计成功人数(成功下首单)";
            cell.detailTextLabel.text = @"0人";
            break;
        case 3:
            cell.showButton = YES;
            break;
    }
    cell.seeActionBlock = ^{
        if (_delegate && [_delegate respondsToSelector:@selector(executeShowInvateConsolation)]) {
            [_delegate executeShowInvateConsolation];
        }
    };
    cell.invateActionBlock = ^{
       YYMineInvateShareView *shareView = [[YYMineInvateShareView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT)];
        [shareView show];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYMineInvateViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        return RELATIVE_WIDTH(220);
    }
    if (indexPath.row == 4) {
        return 0.00001;
    }
    return RELATIVE_WIDTH(80);
}


@end
