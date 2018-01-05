//
//  YYPayDealView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYPayDealView.h"

@interface YYPayDealView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) UIButton *aliButton;
@property (nonatomic, weak) UIButton *weixinButton;
@property (nonatomic, weak) UIButton *submitButton;

@end

@implementation YYPayDealView

{
    YYPayType _payType;
    NSInteger _currentIndex;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [view setSeparatorColor:YYSeparatorColor];
        [view setSeparatorInset:UIEdgeInsetsZero];
        [view setLayoutMargins:UIEdgeInsetsZero];
        view.backgroundColor = YYSeparatorColor;
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
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(280))];
        view.backgroundColor = YYSeparatorColor;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"去支付" forState:UIControlStateNormal];
        button.backgroundColor = YYGlobalColor;
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(RELATIVE_WIDTH(100));
            make.left.equalTo(view).offset(RELATIVE_WIDTH(30));
            make.right.equalTo(view).offset(-RELATIVE_WIDTH(30));
            make.height.mas_equalTo(RELATIVE_WIDTH(80));
        }];
        _submitButton = button;
        self.tableView.tableFooterView = view;
        _currentIndex = 123;
        _payType = YYPayTypeAlipay;
    }
    return self;
}

- (void)payAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executePayDeal:)]) {
        [_delegate executePayDeal:_payType];
    }
}

- (void)selectAction:(UIButton *)button
{
    if (!button.isSelected) {
        button.selected = YES;
        if (_currentIndex && button.tag != _currentIndex) {
            UIButton *button = (UIButton *)[self viewWithTag:_currentIndex];
            button.selected = NO;
        }
        _currentIndex = button.tag;
        _payType = button.tag == 123 ? YYPayTypeAlipay : YYPayTypeWeixinPay;
    }
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYPayDealViewCellID:%ld%ld", (long)indexPath.row, (long)indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        cell.textLabel.textColor = YYTextColor;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        cell.detailTextLabel.textColor = YYGlobalColor;
        if (indexPath.section == 0) {
            cell.textLabel.text = @"订单金额";
            cell.detailTextLabel.text = @"￥626.00";
        } else {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, RELATIVE_WIDTH(44), RELATIVE_WIDTH(44));
            [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"选择支付方式";
                    break;
                case 1:
                    button.tag = 123;
                    button.selected = YES;
                    cell.accessoryView = button;
                    cell.imageView.image = [UIImage imageNamed:@"img_Alipay"];
                    cell.textLabel.text = @"支付宝支付";
                    break;
                case 2:
                    button.tag = 124;
                    cell.accessoryView = button;
                    cell.imageView.image = [UIImage imageNamed:@"img_WeixinPay"];
                    cell.textLabel.text = @"微信支付";
                    break;
                default:
                    break;
            }
        }
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
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIButton *button = (UIButton *)cell.accessoryView;
        [self selectAction:button];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row > 0) {
            return RELATIVE_WIDTH(120);
        }
    }
    return RELATIVE_WIDTH(80);
}

@end
