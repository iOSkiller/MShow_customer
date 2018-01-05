//
//  YYSearchView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSearchView.h"
#import "YYSearchViewCell.h"
#import "YYSearchModel.h"

@interface YYSearchView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, weak) YYBaseTableView *tableView;

@end

@implementation YYSearchView

- (NSMutableArray *)resultArray {
    if (!_resultArray) {
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;
}

- (NSMutableArray *)historyArray {
    if (!_historyArray) {
        _historyArray = [NSMutableArray array];
    }
    return _historyArray;
}

- (NSMutableArray *)hotArray {
    if (!_hotArray) {
        _hotArray = [NSMutableArray array];
    }
    return _hotArray;
}


- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, RELATIVE_WIDTH(20), 0, RELATIVE_WIDTH(20))];
        [tableView setLayoutMargins:UIEdgeInsetsMake(0, RELATIVE_WIDTH(20), 0, RELATIVE_WIDTH(20))];
        [tableView setSeparatorColor:[UIColor whiteColor]];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(20))];
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self tableView];
        [self.resultArray addObjectsFromArray:[YYSearchModel testHotArray]];
        [self.historyArray addObjectsFromArray:[YYSearchModel testHistoryArray]];
        [self.hotArray addObjectsFromArray:[YYSearchModel testHotArray]];
    }
    return self;
}

- (void)setIsSearching:(BOOL)isSearching
{
    _isSearching = isSearching;
    [self.tableView setSeparatorColor:_isSearching ? YYSeparatorColor : [UIColor whiteColor]];
    [self.tableView reloadData];
}

- (void)deleteSearchHistory
{
    [self.historyArray removeAllObjects];
    [self.tableView beginUpdates];
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _isSearching ? 1 : (self.historyArray.count ? 2 : 1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _isSearching ? self.resultArray.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYSearchViewCellID%@%@", @(indexPath.row), @(indexPath.section)];
    YYSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYSearchViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
    if (_isSearching) {
        cell.type = YYSearchViewCellTypeDefault;
        YYSearchModel *model = self.resultArray[indexPath.row];
        cell.textLabel.text = model.content;
    } else {
        cell.type = indexPath.section == 0 ? YYSearchViewCellTypeHistorySearch : YYSearchViewCellTypeHotSearch;
        cell.dataArray = indexPath.section == 0 ? self.historyArray: self.hotArray;
        cell.didSelectSearchResultBlock = ^(YYSearchModel *searchModel) {
            if (_delegate && [_delegate respondsToSelector:@selector(executeDidSelectSearchResult:)]) {
                [_delegate executeDidSelectSearchResult:searchModel];
            }
        };
        cell.deleteHistoryBlock = ^{
            if (_delegate && [_delegate respondsToSelector:@selector(executeDeleteSearchHistory)]) {
                [_delegate executeDeleteSearchHistory];
            }
        };
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, RELATIVE_WIDTH(20), 0, RELATIVE_WIDTH(20))];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, RELATIVE_WIDTH(20), 0, RELATIVE_WIDTH(20))];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isSearching) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeDidSelectSearchResult:)]) {
            [_delegate executeDidSelectSearchResult:self.resultArray[indexPath.row]];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isSearching) {
        return 44;
    } else {
        return RELATIVE_WIDTH(300);
    }
}


@end
