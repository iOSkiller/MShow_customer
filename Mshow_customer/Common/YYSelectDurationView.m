//
//  YYSelectDurationView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectDurationView.h"
#import "YYSelectDurationViewCell.h"

@interface YYSelectDurationView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;

@end

@implementation YYSelectDurationView

{
    CGFloat _originalY;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.backgroundColor = [UIColor whiteColor];
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        view.showsVerticalScrollIndicator = NO;
        view.delegate = self;
        view.dataSource = self;
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self tableView];
        _originalY = frame.origin.y;
        self.mj_y = -WIN_HEIGHT;
        self.hidden = YES;
    }
    return self;
}

- (void)setSelectionArray:(NSArray *)selectionArray
{
    _selectionArray = selectionArray;
    [self.tableView reloadData];
}

- (void)show
{
    self.hidden = NO;
    [UIView animateWithDuration:.5 animations:^{
        self.mj_h = _originalY;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.5 animations:^{
        self.mj_h = -WIN_HEIGHT;
        self.hidden = YES;
    }];
    
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYSelectDurationViewCell:%@%@", @(indexPath.section), @(indexPath.row)];
    YYSelectDurationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYSelectDurationViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.contentLabel.text = [NSString stringWithFormat:@"%@天", self.selectionArray[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_didSelectDurationBlock) {
        _didSelectDurationBlock([self.selectionArray[indexPath.row] integerValue]);
    }
    self.hidden = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(44);
}

@end
