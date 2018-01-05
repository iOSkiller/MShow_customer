//
//  YYDealCancelView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/22.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYDealCancelView.h"
#import "YYCancelReasonModel.h"

@interface YYDealCancelView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) YYBaseTableView *tableView;
@end

@implementation YYDealCancelView

{
    NSUInteger _currentIndex;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.scrollEnabled = NO;
        [view setSeparatorColor:YYSeparatorColor];
        [view setSeparatorInset:UIEdgeInsetsZero];
        [view setLayoutMargins:UIEdgeInsetsZero];
        view.backgroundColor = [UIColor whiteColor];
        view.dataSource = self;
        view.delegate = self;
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.selectionArray = [YYCancelReasonModel dataArray];
        [self tableView];
        WS(ws);
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
    }
    return self;
}


- (void)buttonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    NSUInteger index = sender.tag - 2018;
    
    if (sender.isSelected) {
        if (_currentIndex && _currentIndex != sender.tag) {
            UIButton *button = (UIButton *)[self viewWithTag:_currentIndex];
            button.selected = NO;
        }
        _currentIndex = sender.tag;
        if (_didSelectReasonBlock) {
            YYCancelReasonModel *model = self.selectionArray[index - 1];
            _didSelectReasonBlock(model.type);
        }
    } else {
        if (_didSelectReasonBlock) {
            _didSelectReasonBlock(YYCancelReasonTypeNone);
        }
    }
    
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectionArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYDealCancelViewCellID:%ld%ld", (long)indexPath.row, (long)indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        if (indexPath.row == 0) {
            cell.textLabel.textColor = YYGrayTextColor;
            cell.backgroundColor = YYSeparatorColor;
            cell.textLabel.text = @"选择取消订单理由";
        } else {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_n"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"wardrobe_btn_choose_pre"] forState:UIControlStateSelected];
            button.tag = indexPath.row + 2018;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            button.bounds = CGRectMake(0, 0, RELATIVE_WIDTH(44), RELATIVE_WIDTH(44));
            cell.accessoryView = button;
            cell.textLabel.textColor = YYTextColor;
            YYCancelReasonModel *model = self.selectionArray[indexPath.row - 1];
            cell.textLabel.text = model.content;
        }
        
    }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIButton *button = (UIButton *)cell.accessoryView;
        [self buttonAction:button];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(100);
}


@end
