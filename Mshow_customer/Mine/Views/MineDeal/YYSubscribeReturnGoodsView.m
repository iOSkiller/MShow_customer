//
//  YYSubscribeReturnGoodsView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSubscribeReturnGoodsView.h"
#import "YYSubscribeReturnGoodsViewCell.h"
#import "YYDealModel.h"
#import "YYBottomSelectView.h"

@interface YYSubscribeReturnGoodsView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) UIButton *sureButton;

@end

@implementation YYSubscribeReturnGoodsView

{
    NSString *_date;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.separatorColor = YYSeparatorColor;
        view.separatorInset = UIEdgeInsetsZero;
        view.layoutMargins = UIEdgeInsetsZero;
        view.backgroundColor = [UIColor whiteColor];
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
        self.backgroundColor = [UIColor whiteColor];
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(280))];
        footerView.backgroundColor = [UIColor whiteColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        [button setTitle:@"确认预约" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = YYDisableColor;
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        button.enabled = NO;
        [button addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(RELATIVE_WIDTH(200), RELATIVE_WIDTH(100), WIN_WIDTH - RELATIVE_WIDTH(400), RELATIVE_WIDTH(80));
        [footerView addSubview:button];
        _sureButton = button;
        self.tableView.tableFooterView = footerView;
    }
    return self;
}

- (void)sureAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeSureAction:)]) {
        [_delegate executeSureAction:[YYDealModel new]];
    }
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"cellID:%@%@", @(indexPath.row), @(indexPath.section)];
    YYSubscribeReturnGoodsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYSubscribeReturnGoodsViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        switch (indexPath.row) {
            case 0:
                cell.type = YYSubscribeReturnGoodsViewCellTypeDate;
                break;
            case 1:
                cell.type = YYSubscribeReturnGoodsViewCellTypeAddress;
                break;
            default:
                break;
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYSubscribeReturnGoodsViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"归还时间";
            cell.detailTextLabel.text = [_date isValid] ? _date : @"请选择归还时间";
            break;
        case 1:
            cell.title = _type == YYMineFunctionTypeReturn ? @"取衣地址" : @"送衣地址";
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            YYBottomSelectView *datePicker = [[YYBottomSelectView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT) type:YYBottomSelectViewTypeReturnDateTime];
            WS(weakSelf);
            datePicker.didSelectDateAndTimeBlock = ^(NSString *date, NSString *time) {
                StrongSelf(strongSelf);
                strongSelf = weakSelf;
                _date = [NSString stringWithFormat:@"%@ %@", date, time];
                [strongSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.sureButton.enabled = YES;
                strongSelf.sureButton.backgroundColor = YYGlobalColor;
            };
            [datePicker show];
        }
            break;
        case 1:
            
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return RELATIVE_WIDTH(140);
            break;
        case 1:
            return RELATIVE_WIDTH(226);
            break;
        default:
            break;
    }
    return 0.000001;
}

@end
