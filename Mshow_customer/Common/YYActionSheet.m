//
//  YYActionSheet.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/5.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYActionSheet.h"

@interface YYActionSheet () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;

@end

@implementation YYActionSheet

{
    NSString *_cancelButtonTitle;
    NSString *_destructiveButtonTitle;
    NSArray *_otherButtonTitlesArray;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(300))];
        view.delegate = self;
        view.dataSource = self;
        [view setSeparatorInset:UIEdgeInsetsZero];
        [view setSeparatorColor:YYSeparatorColor];
        [view setLayoutMargins:UIEdgeInsetsZero];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}


- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT);
        self.backgroundColor = mRGBAColor(0, 0, 0, 0.75);
        self.userInteractionEnabled = YES;
        _destructiveButtonTitle = destructiveButtonTitle;
        _cancelButtonTitle = cancelButtonTitle;
        _otherButtonTitlesArray = otherButtonTitles;
        if (title) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(100))];
            label.backgroundColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(34)];
            label.text = title;
            self.tableView.tableHeaderView = label;
        }
        self.tableView.mj_h = ((_destructiveButtonTitle ? RELATIVE_WIDTH(220) : RELATIVE_WIDTH(110)) + _otherButtonTitlesArray.count * RELATIVE_WIDTH(100)) + (title ? RELATIVE_WIDTH(100) : 0);
        self.tableView.mj_y = WIN_HEIGHT;
        UIView *tapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - self.tableView.mj_h)];
        tapView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [tapView addGestureRecognizer:tap];
        [self addSubview:tapView];
        if ((mAppDelegate).iPhoneX) {
            self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, iPhone_MARGIN_BOTTOM)];
            self.tableView.mj_h += iPhone_MARGIN_BOTTOM;
        }
    }
    return self;
}

- (void)show
{
    [(mAppDelegate).window addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.mj_y = WIN_HEIGHT - self.tableView.mj_h;
    }];
}

- (void)hide
{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:.5 animations:^{
        self.tableView.mj_y = WIN_HEIGHT;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_destructiveButtonTitle) {
        return 3;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _otherButtonTitlesArray.count + 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYActionSheetCellID:%@%@", @(indexPath.row), @(indexPath.section)];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(100))];
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = YYTextColor;
        label.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:label];
        switch (indexPath.section) {
            case 0:
                label.text = _otherButtonTitlesArray[indexPath.row];
                break;
            case 1:
                label.text = _destructiveButtonTitle ? _destructiveButtonTitle : _cancelButtonTitle;
                break;
            case 2:
                label.text = _cancelButtonTitle;
                break;
            default:
                cell.backgroundColor = YYSectionFooterColor;
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if (_otherActionBlock) {
                _otherActionBlock(indexPath.row);
            }
            break;
        case 1:
            if (_destructiveButtonTitle) {
                if (_destructiveActionBlock) {
                    _destructiveActionBlock();
                }
            } else {
                if (_cancelActionBlock) {
                    _cancelActionBlock();
                }
            }
            break;
        case 2:
            if (_cancelActionBlock) {
                _cancelActionBlock();
            }
            break;
        default:
            return;
            break;
    }
    [self hide];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == _otherButtonTitlesArray.count) {
            return RELATIVE_WIDTH(10);
        }
    }
    return RELATIVE_WIDTH(100);
}

@end
