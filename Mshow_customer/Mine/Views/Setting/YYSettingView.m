//
//  YYSettingView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSettingView.h"

@interface YYSettingView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) UIButton *logoutButton;

@end

@implementation YYSettingView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView setSeparatorColor:YYSeparatorColor];
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        [tableView setLayoutMargins:UIEdgeInsetsZero];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(200))];
        tableView.tableFooterView.backgroundColor = mRGBToColor(0xf0f0f0);
        if ((mAppDelegate).isLogin) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"退出登录" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(36)];
            button.backgroundColor = YYGlobalColor;
            button.layer.cornerRadius = CommonCornerRadius;
            button.layer.masksToBounds = YES;
            [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(RELATIVE_WIDTH(26), RELATIVE_WIDTH(76), self.mj_w - RELATIVE_WIDTH(52), RELATIVE_WIDTH(82));
            [tableView.tableFooterView addSubview:button];
            _logoutButton = button;
        }
        tableView.backgroundColor = mRGBToColor(0xf0f0f0);
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleArray = @[@"修改登录密码", @"清除缓存", @"M秀简介"];
        [self tableView];
        self.backgroundColor = mRGBToColor(0xf0f0f0);
    }
    return self;
}

- (void)logouSuccess
{
    self.logoutButton.hidden = YES;
}

- (void)buttonAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeLogout)]) {
        [_delegate executeLogout];
    }
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"cellID:%ld%ld", (long)indexPath.section, (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = YYTextColor;
        cell.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        
        cell.detailTextLabel.textColor = YYGrayTextColor;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
        cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    cell.textLabel.text = self.titleArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            if (_delegate &&[_delegate respondsToSelector:@selector(executeResetPassword)]) {
                [_delegate executeResetPassword];
            }
            break;
        }
        case 1:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(executeCleanMemmory)]) {
                [_delegate executeCleanMemmory];
            }
            break;
        }
        case 2:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowMshow)]) {
                [_delegate executeShowMshow];
            }
            break;
        }
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(102);
}

@end
