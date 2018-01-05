//
//  YYMineCustomerCenterView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineCustomerCenterView.h"
#import "YYButton.h"

@interface YYMineCustomerCenterView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) YYButton *phoneButton;
@property (nonatomic, copy) NSArray *questionArray;

@end

@implementation YYMineCustomerCenterView

- (NSArray *)questionArray {
    if (!_questionArray) {
        _questionArray = @[@"我一次可以秀几件衣服",
                           @"我的积分",
                           @"如果衣服损坏或丢失，我该怎么办？",
                           @"押金是如何收取，如何退还？",
                           @"如何修改个人信息",
                           @"忘记支付密码？",
                           @"退货/售后申请在哪里看进度？"];
    }
    return _questionArray;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h - RELATIVE_WIDTH(100)) style:UITableViewStylePlain];
        view.backgroundColor = YYSeparatorColor;
        [view setSeparatorColor:YYSeparatorColor];
        view.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(30))];
        view.delegate = self;
        view.dataSource = self;
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}

- (YYButton *)phoneButton {
    if (!_phoneButton) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, self.mj_h - RELATIVE_WIDTH(100), self.mj_w, RELATIVE_WIDTH(100));
        button.normalColor = YYTextColor;
        [button setTopImage:[UIImage imageNamed:@"img_telephone"] selectedTopImage:nil bottomTitle:@"咨询电话" selctedBottomTitle:nil];
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _phoneButton = button;
    }
    return _phoneButton;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self tableView];
        [self phoneButton];
    }
    return self;
}

#pragma mark - buttonAction
- (void)buttonAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeCall)]) {
        [_delegate executeCall];
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
        return self.questionArray.count + 2;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYMineCustomerCenterViewCellID:%ld%ld", (long)indexPath.section, (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        cell.textLabel.textColor = YYTextColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.backgroundColor = YYSeparatorColor;
                cell.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(32)];
                cell.textLabel.textColor = YYGrayTextColor;
                cell.textLabel.text = @"常见问题";
                cell.accessoryType = UITableViewCellAccessoryNone;
            } else if (indexPath.row == self.questionArray.count + 1) {
                cell.backgroundColor = YYSectionFooterColor;
                cell.accessoryType = UITableViewCellAccessoryNone;
            } else {
                cell.textLabel.text = self.questionArray[indexPath.row - 1];
            }
            
        }
        
        if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"查看所有问题";
                    break;
                case 1:
                    cell.backgroundColor = YYSeparatorColor;
                    cell.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(32)];
                    cell.textLabel.textColor = YYGrayTextColor;
                    cell.textLabel.text = @"微信服务号";
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                case 2:
                    cell.imageView.image = [UIImage imageNamed:@"img_WeixinPay"];
                    cell.textLabel.text = @"如有更多问题可关注微信服务号“M秀”";
                    break;
                default:
                    break;
            }
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0 && indexPath.section == 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeShowQuestion:)]) {
            [_delegate executeShowQuestion:[NSString stringWithFormat:@"问题%ld", (long)indexPath.row]];
        }
    }
    
    if (indexPath.row == 0 && indexPath.section == 1) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeShowAllQuestion)]) {
            [_delegate executeShowAllQuestion];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return RELATIVE_WIDTH(80);
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == self.questionArray.count + 1) {
            return RELATIVE_WIDTH(10);
        }
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        return RELATIVE_WIDTH(80);
    }
    return RELATIVE_WIDTH(100);
}

@end
