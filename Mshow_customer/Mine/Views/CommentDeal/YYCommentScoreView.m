//
//  YYCommentScoreView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCommentScoreView.h"
#import "YYCommentScoreViewCell.h"

@interface YYCommentScoreView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;

@end

@implementation YYCommentScoreView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.dataSource = self;
        view.delegate = self;
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        view.backgroundColor = [UIColor whiteColor];
        view.scrollEnabled = NO;
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

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"%ld%ld", (long)indexPath.row, (long)indexPath.section];
    YYCommentScoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYCommentScoreViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    switch (indexPath.row) {
        case 0:
            cell.scoreType = YYScoreTypeShop;
            break;
        case 1:
            cell.scoreType = YYScoreTypeDescription;
            break;
        case 2:
            cell.scoreType = YYScoreTypeDelivery;
            break;
        case 3:
            cell.scoreType = YYScoreTypeTriedExperience;
            break;
        default:
            break;
    }
    cell.didMarkBlock = ^(YYScoreType type, double score) {
        if (_didMarkBlock) {
            _didMarkBlock(type, score);
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(60);
}


@end
