//
//  YYPaySuccessView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYPaySuccessView.h"
#import "YYGussessLikeView.h"
#import "YYPaySuccessViewCell.h"
#import "YYGoodsModel.h"

@interface YYPaySuccessView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) YYGussessLikeView *likeView;

@end

@implementation YYPaySuccessView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.backgroundColor = [UIColor whiteColor];
        [view setSeparatorColor:YYSeparatorColor];
        [view setSeparatorInset:UIEdgeInsetsZero];
        [view setLayoutMargins:UIEdgeInsetsZero];
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
        self.backgroundColor = [UIColor whiteColor];
        [self tableView];
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(1760))];
        footerView.backgroundColor = [UIColor whiteColor];
        YYGussessLikeView *likeView = [[YYGussessLikeView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(10), self.mj_w, RELATIVE_WIDTH(1750))];
        likeView.likeGoodsArray = [YYGoodsModel testWomanArray];
        likeView.showGoodsBlock = ^(YYGoodsModel *goodsModel) {
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowGoodsModel:)]) {
                [_delegate executeShowGoodsModel:goodsModel];
            }
        };
        [footerView addSubview:likeView];
        _likeView = likeView;
        self.tableView.tableFooterView = footerView;
    }
    return self;
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYPaySuccessViewCellID:%@%@", @(indexPath.row), @(indexPath.section)];
    YYPaySuccessViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYPaySuccessViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        if (indexPath.row == 0) {
            cell.type = YYPaySuccessViewCellTypeAddress;
            
        }
        if (indexPath.row == 1) {
            cell.type = YYPaySuccessViewCellTypePrice;
            cell.textLabel.attributedText = [NSString str1:@"实付款：" font1:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color1:YYTextColor str2:@"￥626.00" font2:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color2:YYGlobalColor];
        }
        if (indexPath.row == 2) {
            cell.type = YYPaySuccessViewCellTypeFuction;
            cell.dealActionBlock = ^{
                if (_delegate && [_delegate respondsToSelector:@selector(executeShowDeal)]) {
                    [_delegate executeShowDeal];
                }
            };
            cell.backActionBlock = ^{
                if (_delegate && [_delegate respondsToSelector:@selector(executeBackHome)]) {
                    [_delegate executeBackHome];
                }
            };
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return RELATIVE_WIDTH(120);
    }
    return RELATIVE_WIDTH(100);;
}

@end
