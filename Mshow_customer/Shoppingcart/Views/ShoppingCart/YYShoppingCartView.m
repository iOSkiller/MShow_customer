//
//  YYShoppingCartView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShoppingCartView.h"
#import "YYShoppingCartViewCell.h"
#import "YYGussessLikeView.h"
#import "YYGoodsModel.h"
#import "YYShopModel.h"

@interface YYShoppingCartView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) YYGussessLikeView *gussessView;

@end

@implementation YYShoppingCartView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.backgroundColor = [UIColor whiteColor];
        view.delegate = self;
        view.dataSource = self;
//        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(10))];
//        headerView.backgroundColor = mRGBToColor(0xf0f0f0);
//        view.tableHeaderView = headerView;
        view.tableFooterView = self.gusessView;
        [view setLayoutMargins:UIEdgeInsetsZero];
        [view setSeparatorInset:UIEdgeInsetsZero];
        [view setSeparatorColor:mRGBToColor(0xf0f0f0)];
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}

- (YYGussessLikeView *)gusessView {
    if (!_gussessView) {
        YYGussessLikeView *view = [[YYGussessLikeView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(1080))];
        [self addSubview:view];
        _gussessView = view;
    }
    return _gussessView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self gusessView];
        [self tableView];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    self.gusessView.likeGoodsArray = [YYGoodsModel testWomanArray];
    self.gusessView.showGoodsBlock = ^(YYGoodsModel *goodsModel) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeShowGoodsDetail:indexPath:)]) {
            [_delegate executeShowGoodsDetail:goodsModel indexPath:nil];
        }
    };
    self.gusessView.mj_h = self.gusessView.collectionView.contentSize.height + RELATIVE_WIDTH(108);
    [self.tableView reloadData];

}

- (void)reloadRow:(NSIndexPath *)indexPath
{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadSection:(NSIndexPath *)indexPath
{
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YYShopModel *model = self.dataArray[section];
    return model.goodsArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"%ld%ld", (long)indexPath.row, (long)indexPath.section];
    YYShoppingCartViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYShoppingCartViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.isFirstCell = indexPath.row == 0;
        cell.showCouponBlock = ^(YYShopModel *model) {
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowCoupons:indexPath:)]) {
                [_delegate executeShowCoupons:model indexPath:indexPath];
            }
        };
        cell.didChangeGoodsBlock = ^(YYGoodsModel *goodsModel) {
            if (_delegate && [_delegate respondsToSelector:@selector(shouldChangeGoods:indexPath:)]) {
                [_delegate shouldChangeGoods:goodsModel indexPath:indexPath];
            }
        };
        
        cell.didChangeShopBlock = ^(YYShopModel *model) {
            if (_delegate && [_delegate respondsToSelector:@selector(shouldChangeShop:indexPath:)]) {
                [_delegate shouldChangeShop:model indexPath:indexPath];
            }
        };
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYShoppingCartViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    YYShopModel *model = self.dataArray[indexPath.section];
    if (indexPath.row > 0) {
        cell.goodsModel = model.goodsArray[indexPath.row - 1];
    } else {
        cell.shopModel = model;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return RELATIVE_WIDTH(80);
    }
    return RELATIVE_WIDTH(344);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == self.dataArray.count - 1) {
//        return 0.0001;
//    }
    return RELATIVE_WIDTH(10);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYShopModel *model = self.dataArray[indexPath.section];
    
    if (indexPath.row == 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeShowShopDetail:indexPath:)]) {
            [_delegate executeShowShopDetail:model indexPath:indexPath];
        }
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(executeShowGoodsDetail: indexPath:)]) {
            [_delegate executeShowGoodsDetail:model.goodsArray[indexPath.row - 1] indexPath:indexPath];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return NO;
    }
    return YES;
}

//- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    return @[];
//}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(shouldRemoveGoods:indexPath:)]) {
        YYShopModel *model = self.dataArray[indexPath.section];
        [_delegate shouldRemoveGoods:model.goodsArray[indexPath.row - 1] indexPath:indexPath];
    }
}


//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    YYShoppingCartViewCell *tableCell = [tableView cellForRowAtIndexPath:indexPath];
//    //屏蔽交互
//    for (UIView *view in [tableCell.contentView subviews])
//    {
//        if ([view isKindOfClass:[UIButton class]]) {
//            [view setUserInteractionEnabled:NO];
//        }
//    }
//}
//
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    YYShoppingCartViewCell *tableCell = [tableView cellForRowAtIndexPath:indexPath];
//    //开启交互
//    for (UIView *view in [tableCell.contentView subviews])
//    {
//        if ([view isKindOfClass:[UIButton class]]) {
//            [view setUserInteractionEnabled:YES];
//        }
//    }
//}

/**消除footer header 悬浮状态*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = RELATIVE_WIDTH(10);
    CGFloat sectionFooterHeight = RELATIVE_WIDTH(10);
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 0 && offsetY <= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    } else if (offsetY >= sectionHeaderHeight && offsetY <= scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
    } else if (offsetY >= scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight && offsetY <= scrollView.contentSize.height - scrollView.frame.size.height) {
        scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight), 0);
    }
}

@end
