//
//  YYWithDrawCashView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYWithDrawCashView.h"
#import "YYPaymentViewCell.h"
#import "YYWithDrawInfoView.h"

@interface YYWithDrawCashView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) YYWithDrawInfoView *infoView;

@end

@implementation YYWithDrawCashView

{
    YYPayType _payType;
    NSString *_sum;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.delegate = self;
        view.dataSource = self;
        [view setSeparatorColor:YYSeparatorColor];
        [view setSeparatorInset:UIEdgeInsetsZero];
        [view setLayoutMargins:UIEdgeInsetsZero];
        view.showsVerticalScrollIndicator = NO;
        view.backgroundColor = YYSeparatorColor;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"两小时内到账，确认提现" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(38)];
        button.backgroundColor = YYGlobalColor;
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        button.frame = CGRectMake(RELATIVE_WIDTH(26), RELATIVE_WIDTH(60), self.mj_w - RELATIVE_WIDTH(52), RELATIVE_WIDTH(80));
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(200))];
        footerView.backgroundColor = YYSeparatorColor;
        [footerView addSubview:button];
        view.tableFooterView = footerView;
        
        YYWithDrawInfoView *infoView = [[YYWithDrawInfoView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(80), self.mj_w, RELATIVE_WIDTH(200))];
        infoView.didEndEdite = ^(NSString *sum) {
            _sum = sum;
        };
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(280))];
        headerView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:infoView];
        _infoView = infoView;
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

- (void)buttonAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeWithDrawCash:type:)]) {
        [_delegate executeWithDrawCash:_sum type:_payType];
    }
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"cellID:%ld%ld", (long)indexPath.row, (long)indexPath.section];
    YYPaymentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYPaymentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        switch (indexPath.row) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"img_Alipay"];
                cell.textLabel.text = @"支付宝支付";
                break;
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"img_WeixinPay"];
                cell.textLabel.text = @"微信支付";
                break;
            default:
                break;
        }
        WS(weakSelf);
        cell.selectBlock = ^(BOOL isSelected) {
            if (isSelected) {
                StrongSelf(strongSelf);
                strongSelf = weakSelf;
                [strongSelf.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                switch (indexPath.row) {
                    case 0:
                        _payType = YYPayTypeAlipay;
                        break;
                    case 1:
                        _payType = YYPayTypeWeixinPay;
                        break;
                    default:
                        break;
                }
            }
        };
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            _payType = YYPayTypeAlipay;
            break;
        case 1:
            _payType = YYPayTypeWeixinPay;
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(100);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return RELATIVE_WIDTH(20);
}

@end
