//
//  YYReturnChangeDealView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYReturnChangeDealView.h"
#import "YYReturnChangeDealViewCell.h"
#import "YYButton.h"
#import "YYDealModel.h"
#import "YYDeviceHandle.h"

#define SumSection      0
#define FlowSection     1
#define ReasonSection   2

@interface YYReturnChangeDealView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) UILabel *statusLabel;
@property (nonatomic, weak) UILabel *dateLabel;

@end

@implementation YYReturnChangeDealView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, self.mj_h - RELATIVE_WIDTH(80)) style:UITableViewStylePlain];
        [tableView setSeparatorColor:YYSeparatorColor];
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        [tableView setLayoutMargins:UIEdgeInsetsZero];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self tableView];
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, self.mj_h - RELATIVE_WIDTH(100), self.mj_w, RELATIVE_WIDTH(100));
        button.normalColor = YYTextColor;
        [button setTopImage:[UIImage imageNamed:@"img_telephone"] selectedTopImage:nil bottomTitle:@"商家电话" selctedBottomTitle:nil];
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(200))];
        headerView.backgroundColor = YYGlobalColor;
    
        UILabel *statusLabel = [UILabel new];
        statusLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(36)];
        statusLabel.textColor = [UIColor whiteColor];
        statusLabel.text = @"申请已提交";
        statusLabel.backgroundColor = YYGlobalColor;
        [headerView addSubview:statusLabel];
        
        [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).mas_offset(RELATIVE_WIDTH(26));
            make.top.equalTo(headerView).offset(RELATIVE_WIDTH(60));
            make.height.mas_equalTo(RELATIVE_WIDTH(38));
            make.width.greaterThanOrEqualTo(@0);
        }];
        _statusLabel = statusLabel;
        
        UILabel *dateLabel = [UILabel new];
        dateLabel.text = [NSString currentDate:@"yyyy年MM月dd日 HH:mm"];
        dateLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(26)];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.backgroundColor = YYGlobalColor;
        [headerView addSubview:dateLabel];
        
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).mas_equalTo(RELATIVE_WIDTH(26));
            make.bottom.equalTo(headerView).mas_equalTo(-RELATIVE_WIDTH(60));
            make.width.greaterThanOrEqualTo(@0);
            make.height.mas_equalTo(RELATIVE_WIDTH(28));
        }];
        _dateLabel = dateLabel;
        self.tableView.tableHeaderView = headerView;
    }
    return self;
}

- (void)buttonAction
{
    [YYDeviceHandle makeCall:@"18306118609"];
}

- (void)setDealModel:(YYDealModel *)dealModel
{
    _dealModel = dealModel;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case SumSection:
            return 1;
            break;
        case FlowSection:
            return 2;
            break;
        case ReasonSection:
            return 5;
            break;
        default:
            break;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"%@%@", @(indexPath.section), @(indexPath.row)];
    YYReturnChangeDealViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYReturnChangeDealViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        switch (indexPath.section) {
            case SumSection:
                cell.textLabel.text = @"退款金额";
                cell.detailTextLabel.textColor = YYGlobalColor;
                cell.detailTextLabel.text = @"￥300.00";
                break;
            case FlowSection:
                switch (indexPath.row) {
                    case 0:
                    {
                        cell.textLabel.text = @"退换流程";
                    }
                        break;
                    case 1:
                    {
                        cell.type = YYReturnChangeDealViewCellTypeFlow;
                    }
                        break;
                    default:
                        break;
                }
                break;
            case ReasonSection:
                switch (indexPath.row) {
                    case 0:
                        cell.textLabel.text = @"退换信息";
                        break;
                    case 1:
                        cell.textLabel.text = @"退换原因";
                        cell.detailTextLabel.text = @"质量问题";
                        break;
                    case 2:
                        cell.textLabel.text = @"退款金额";
                        cell.detailTextLabel.text = @"￥300.00";
                        break;
                    case 3:
                        cell.textLabel.text = @"申请时间";
                        cell.detailTextLabel.text = [NSString currentDate:@"yyyy-MM-dd HH:mm"];
                        break;
                    case 4:
                        cell.textLabel.text = @"退款编码";
                        cell.detailTextLabel.text = @"12345678901345";
                        break;
                    default:
                        break;
                }
                break;
            default:
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case SumSection:
        case ReasonSection:
            return RELATIVE_WIDTH(80);
            break;
        case FlowSection:
            if (indexPath.row == 0) {
                return RELATIVE_WIDTH(80);
            } else {
                return RELATIVE_WIDTH(138);
            }
            break;
        default:
            break;
    }
    return 0.000001;
}





@end
