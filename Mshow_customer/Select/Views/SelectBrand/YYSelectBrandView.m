//
//  YYSelectBrandView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectBrandView.h"
#import "YYSelectBrandViewCell.h"
#import "YYHotBrandView.h"
#import "YYSelectTitleView.h"
#import "YYBrandModel.h"
#import "YYSectionIndexView.h"

@interface YYSelectBrandView () <UITableViewDelegate, UITableViewDataSource, YYSectionIndexViewDelegate>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *line;
@property (nonatomic, weak) YYHotBrandView *brandView;
@property (nonatomic, weak) YYSelectTitleView *titleView;
@property (nonatomic, weak) YYSectionIndexView *indexView;
@property (nonatomic, copy) NSArray *titleArray;

@end

@implementation YYSelectBrandView

{
    BOOL _isSelectIndex;
    NSInteger _currentIndex;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.delegate = self;
        view.dataSource = self;
        [view setSeparatorInset:UIEdgeInsetsZero];
        [view setLayoutMargins:UIEdgeInsetsZero];
        view.backgroundColor = [UIColor whiteColor];
        view.showsVerticalScrollIndicator = NO;
//        //设置默认时，索引的背景颜色
//        view.sectionIndexBackgroundColor = [UIColor whiteColor];
//        //设置选中时，索引背景颜色
//        view.sectionIndexTrackingBackgroundColor = [UIColor whiteColor];
//        //设置默认时索引值颜色
//        view.sectionIndexColor = YYGrayTextColor;
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(820))];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _headerView = view;
    }
    return _headerView;
}

- (YYSelectTitleView *)titleView {
    if (!_titleView) {
        YYSelectTitleView *view = [[YYSelectTitleView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(80))];
        [self.headerView addSubview:view];
        _titleView = view;
    }
    return _titleView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.text = @"全部品牌";
        [self.headerView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)line {
    if (!_line) {
        UILabel *label = [UILabel new];
        label.backgroundColor = mRGBToColor(0xf0f0f0);
        [self.headerView addSubview:label];
        _line = label;
    }
    return _line;
}


- (YYHotBrandView *)brandView {
    if (!_brandView) {
        YYHotBrandView *view = [[YYHotBrandView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(650))];
        [self.headerView addSubview:view];
        _brandView = view;
    }
    return _brandView;
}

- (YYSectionIndexView *)indexView {
    if (!_indexView) {
        YYSectionIndexView *view = [[YYSectionIndexView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(30), RELATIVE_WIDTH(44) * self.titleArray.count) sectionArray:self.titleArray];
        view.delegate = self;
        view.hidden = YES;
        [self addSubview:view];
        _indexView = view;
    }
    return _indexView;
}


- (instancetype)initWithFrame:(CGRect)frame indexArray:(NSArray *)indexArray
{
    if (self = [super initWithFrame:frame]) {
        _titleArray = indexArray;
        [self headerView];
        [self titleLabel];
        [self tableView];
        [self brandView];
        [self titleView];
        [self line];
        self.brandView.showHotBrandBlock = ^(YYBrandModel *model) {
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowHotBrandDetail:)]) {
                [_delegate executeShowHotBrandDetail:[YYBrandModel new]];
            }
        };
        self.tableView.tableHeaderView = self.headerView;
        self.titleArray = @[@"A", @"B", @"C", @"D", @"E"];
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(20))];
        [self indexView];
        
        WS(ws);
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
        
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.headerView);
            make.height.mas_equalTo(RELATIVE_WIDTH(80));
        }];
        
        [self.brandView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleView.mas_bottom);
            make.left.right.equalTo(self.headerView);
            make.height.mas_equalTo(RELATIVE_WIDTH(650));
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.brandView.mas_bottom);
            make.left.right.equalTo(self.headerView);
            make.height.mas_equalTo(RELATIVE_WIDTH(10));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line.mas_bottom);
            make.right.equalTo(self.headerView);
            make.left.equalTo(self.headerView).offset(RELATIVE_WIDTH(24));
            make.height.mas_equalTo(RELATIVE_WIDTH(80));
        }];
        
        [self.indexView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(ws);
            make.right.equalTo(ws).offset(RELATIVE_WIDTH(-RELATIVE_WIDTH(8)));
            make.width.mas_equalTo(RELATIVE_WIDTH(30));
            make.height.mas_equalTo(RELATIVE_WIDTH(44) * self.titleArray.count);
        }];
    }
    return self;
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"   %@", self.titleArray[section]];
}

//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    return self.titleArray;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"%ld%ld", (long)indexPath.section, (long)indexPath.row];
    YYSelectBrandViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYSelectBrandViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull YYSelectBrandViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    cell.model = nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeShowBrandDetail:)]) {
        [_delegate executeShowBrandDetail:[YYBrandModel new]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(104);
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [self.indexView scrolltoIndex:index];
    return index;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSIndexPath *path = [self.tableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
    
    if (scrollView.contentOffset.y > RELATIVE_WIDTH(820)) {
        self.indexView.hidden = NO;
    } else {
        self.indexView.hidden = YES;
    }
    _currentIndex = path.section;
    if (!_isSelectIndex) {
        [self.indexView scrolltoIndex:path.section];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _isSelectIndex = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _isSelectIndex = NO;
}

#pragma mark - YYSectionIndexViewDelegate
//- (void)sectionIndexView:(YYSectionIndexView *)sectionIndexView didSelectedIndex:(NSInteger)index
//{
//    _isSelectIndex = YES;
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionNone animated:YES];
//}



@end
