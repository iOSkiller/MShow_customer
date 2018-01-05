//
//  YYMineCertifyView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineCertifyView.h"
#import "YYMineCertifyViewCell.h"

@interface YYMineCertifyView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) UIButton *button;

@end

@implementation YYMineCertifyView
{
    NSString *_name;
    NSString *_code;
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
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(300))];
        tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"立即认证" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(36)];
        button.backgroundColor = YYDisableColor;
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(RELATIVE_WIDTH(26), RELATIVE_WIDTH(100), self.mj_w - RELATIVE_WIDTH(52), RELATIVE_WIDTH(82));
        button.enabled = NO;
        [tableView.tableFooterView addSubview:button];
        _button = button;
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

- (void)buttonAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeCeritfyAction:code:)]) {
        [_delegate executeCeritfyAction:_name code:_code];
    }
}

- (void)checkInfo
{
    self.button.enabled = ([_name isValid] && [_code isIdentifyCardNumber]);
    self.button.backgroundColor = ([_name isValid] && [_code isIdentifyCardNumber]) ? YYGlobalColor : YYDisableColor;
}

#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYMineCertifyViewCellID:%ld,%ld", (long)indexPath.section, (long)indexPath.row];
    YYMineCertifyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYMineCertifyViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    switch (indexPath.row) {
        case 0:
            cell.type = YYMineCertifyViewCellTypeInfo;
            break;
        case 1:
            cell.type = YYMineCertifyViewCellTypeName;
            break;
        case 2:
            cell.type = YYMineCertifyViewCellTypeCode;
            break;
        default:
            break;
    }
    WS(weakSelf);
    cell.nameBlock = ^(NSString *name) {
        _name = name;
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf checkInfo];
    };
    
    cell.codeBlock = ^(NSString *code) {
        _code = code;
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf checkInfo];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
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
        return 0.00001;
    }
    return RELATIVE_WIDTH(80);
}


@end
