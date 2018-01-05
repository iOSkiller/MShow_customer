//
//  YYMineCommentView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/16.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineCommentView.h"
#import "YYMineCommentViewCell.h"
#import "YYCommentModel.h"

@interface YYMineCommentView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;

@end

@implementation YYMineCommentView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.delegate = self;
        view.dataSource = self;
        [view setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        view.backgroundColor = YYSectionFooterColor;
        view.showsVerticalScrollIndicator = NO;
        view.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(30))];
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYMineCommentViewCell:%ld%ld", (long)indexPath.section, (long)indexPath.row];
    YYMineCommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYMineCommentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        if (indexPath.row == 1) {
            cell.backgroundColor = YYSectionFooterColor;
        } else {
            YYCommentModel *commentModel = self.dataArray[indexPath.section];
            cell.contentHeight = commentModel.contentHeight;
            cell.showCommentBlock = ^(YYCommentModel *commentModel) {
                if (_delegate && [_delegate respondsToSelector:@selector(executeShowComments:)]) {
                    [_delegate executeShowComments:commentModel];
                }
            };
            
            cell.editeActionBlock = ^(YYCommentModel *commentModel) {
                if (_delegate && [_delegate respondsToSelector:@selector(executeEditeComment:)]) {
                    [_delegate executeEditeComment:commentModel];
                }
            };
        }
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return RELATIVE_WIDTH(10);
    } else {
        YYCommentModel *commentModel = self.dataArray[indexPath.section];
        return commentModel.cellHeight;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYMineCommentViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        cell.commentModel = self.dataArray[indexPath.section];
    }
}

@end
