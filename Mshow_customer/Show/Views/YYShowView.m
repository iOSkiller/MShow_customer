//
//  YYShowView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/31.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShowView.h"
#import "YYShowViewCell.h"
#import "YYShowModel.h"

@interface YYShowView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) UILabel *line;

@end

@implementation YYShowView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
//        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(10))];
//        headerView.backgroundColor = mRGBToColor(0xf0f0f0);
//        view.tableHeaderView = headerView;
        view.tableFooterView = [UIView new];
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}

- (UILabel *)line {
    if (!_line) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xf0f0f0);
        [self addSubview:label];
        _line = label;
    }
    return _line;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self tableView];
        [self line];
        
        WS(ws);
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(2));
        }];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(ws);
            make.bottom.equalTo(ws).offset(-RELATIVE_WIDTH(20));
            make.top.equalTo(self.line.mas_bottom);
        }];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"%ld%ld", (long)indexPath.row, (long)indexPath.section];
    YYShowViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYShowViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        WS(weakSelf);
        cell.reportBlock = ^(YYShowModel *showModel) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            [strongSelf executeFunction:showModel type:YYShowViewFunctionTypeReport];
        };
        
        cell.followBlock = ^(YYShowModel *showModel) {
            StrongSelf(strongSelf)
            strongSelf = weakSelf;
            [strongSelf executeFunction:showModel type:YYShowViewFunctionTypeFollow];
        };
        
        cell.commentBlock = ^(YYShowModel *showModel) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            [strongSelf executeFunction:showModel type:YYShowViewFunctionTypeComment];
        };
        
        cell.upvoteBlock = ^(YYShowModel *showModel) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            [strongSelf executeFunction:showModel type:YYShowViewFunctionTypeUpvote];
        };
        cell.shareBlock = ^(YYShowModel *showModel) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            [strongSelf executeFunction:showModel type:YYShowViewFunctionTypeShare];
        };
        
        cell.showImageBlock = ^(NSArray *urlArray, NSInteger index) {
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowDetailImage:index:)]) {
                [_delegate executeShowDetailImage:urlArray index:index];
            }
        };
        
        YYShowModel *showModel = self.dataArray[indexPath.section];
        [cell setItemSize:showModel.itemSize contentHeight:showModel.contentHeight imageContainerHeight:showModel.imageContainerHeight];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYShowViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.showModel = self.dataArray[indexPath.section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYShowModel *model = self.dataArray[indexPath.section];
//    MJExtensionLog(@"%.2f", model.cellHeight);
    return model.cellHeight;
}

- (void)executeFunction:(YYShowModel *)showModel type:(YYShowViewFunctionType)type
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeFunction:showModel:)]) {
        [_delegate executeFunction:type showModel:showModel];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = RELATIVE_WIDTH(10);
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

@end
