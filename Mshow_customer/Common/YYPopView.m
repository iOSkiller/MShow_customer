//
//  YYPopView.m
//  DDFood
//
//  Created by YZ Y on 16/10/21.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYPopView.h"


static NSString *const cellID = @"YYPopCellID";
@interface YYPopView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;

@end

@implementation YYPopView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(10), self.mj_w, self.mj_h - RELATIVE_WIDTH(10)) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView setSeparatorColor:YYSeparatorColor];
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, RELATIVE_WIDTH(20), 0, RELATIVE_WIDTH(20))];
        [tableView setLayoutMargins:UIEdgeInsetsMake(0, RELATIVE_WIDTH(20), 0, RELATIVE_WIDTH(20))];
        tableView.backgroundColor = [UIColor clearColor];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        tableView.tableFooterView = view;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        tableView.scrollEnabled = NO;
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.type = YYArrowViewTypeBlock;
        [self tableView];
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray images:(NSArray *)imageArray
{
    _imageArray = imageArray;
    _titleArray = titleArray;
    self.frame = CGRectMake(self.mj_x, self.mj_y, self.mj_w, RELATIVE_WIDTH(84) * titleArray.count + RELATIVE_WIDTH(10));
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(32)];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSeparatorInset:UIEdgeInsetsMake(0, RELATIVE_WIDTH(20), 0, RELATIVE_WIDTH(20))];
    [cell setLayoutMargins:UIEdgeInsetsMake(0, RELATIVE_WIDTH(20), 0, RELATIVE_WIDTH(20))];
    cell.textLabel.text = self.titleArray[indexPath.row];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickItemInPopView:)]) {
        [_delegate clickItemInPopView:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(84);
}

@end
