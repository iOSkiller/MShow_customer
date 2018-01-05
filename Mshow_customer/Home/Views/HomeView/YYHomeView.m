//
//  YYHomeView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHomeView.h"
#import "YYBaseTableView.h"
#import "YYAdsView.h"
#import "YYHomeFunctionView.h"
#import "YYHomeCell.h"
#import "YYGoodsModel.h"
#import "YYShopModel.h"
#import "YYSegmentView.h"

@interface YYHomeView () <UITableViewDelegate, UITableViewDataSource, YYAdsViewDelegate>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) YYAdsView *adsView;
@property (nonatomic, weak) YYHomeFunctionView *functionView;
@property (nonatomic, strong) NSMutableArray *shopArray;

@end

@implementation YYHomeView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.delegate = self;
        view.dataSource = self;
        [view setSeparatorInset:UIEdgeInsetsZero];
        [view setLayoutMargins:UIEdgeInsetsZero];
        [view setSeparatorColor:YYSeparatorColor];
//        [view setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        view.backgroundColor = [UIColor whiteColor];
        view.showsVerticalScrollIndicator = NO;
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}



- (NSMutableArray *)shopArray {
    if (!_shopArray) {
        _shopArray = [NSMutableArray array];
    }
    return _shopArray;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.shopArray addObjectsFromArray:[YYShopModel testDataArray]];
        [self tableView];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, homeAdsHeight + RELATIVE_WIDTH(200) + RELATIVE_WIDTH(170))];
        headerView.backgroundColor = [UIColor whiteColor];
        
        YYAdsView *adsView = [[YYAdsView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, homeAdsHeight)];
        adsView.backgroundColor = [UIColor whiteColor];
        adsView.type = YYAdsViewTypeBigImage;
        adsView.delegate = self;
        [headerView addSubview:adsView];
        _adsView = adsView;
        
        YYHomeFunctionView *functionView = [[YYHomeFunctionView alloc] initWithFrame:CGRectMake(0, homeAdsHeight, WIN_WIDTH, RELATIVE_WIDTH(200)) titleArray:@[@"每周爆品", @"每日新品", @"完美体验", @"五星清洗"] imageArray:@[@"img_detonationproduct", @"img_newproduct", @"img_free", @"img_wash"]];
        functionView.didSelectFuctionBlock = ^(YYHomeFunctionType functionType) {
            if (_delegate && [_delegate respondsToSelector:@selector(homeViewShowHomeFunction:)]) {
                [_delegate homeViewShowHomeFunction:functionType];
            }
        };
        [headerView addSubview:functionView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, functionView.mj_y + functionView.mj_h, WIN_WIDTH, RELATIVE_WIDTH(10))];
        line.backgroundColor = YYSeparatorColor;
        [headerView addSubview:line];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(26), line.mj_h + line.mj_y, WIN_WIDTH - RELATIVE_WIDTH(52), RELATIVE_WIDTH(80))];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(36)];
        titleLabel.textColor = YYTextColor;
        titleLabel.text = @"附近店铺";
        [headerView addSubview:titleLabel];
        
        YYSegmentView *segmentView = [[YYSegmentView alloc] initWithFrame:CGRectMake(0, titleLabel.mj_h + titleLabel.mj_y, WIN_WIDTH, RELATIVE_WIDTH(80)) leftMargin:RELATIVE_WIDTH(26) magrin:0 selections:@[@"综合排序", @"销量排序", @"距离最近"]];
        [segmentView setSeparator:YYSeparatorColor height:RELATIVE_WIDTH(1)];
        [headerView addSubview:segmentView];
        
        self.tableView.tableHeaderView = headerView;
    }
    return self;
}

#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 3) {
//        return 1 + self.shopArray.count;
//    }
//    if (section == 2) {
//        return 1 + self.shopArray.count;
//    }
    return self.shopArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"homeCellID:%ld%ld", (long)indexPath.section, (long)indexPath.row];
    YYHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.type = YYHomeCellTypeShop;
        cell.shopModel = self.shopArray[indexPath.row];
//        switch (indexPath.section) {
//            case 0:
//                cell.type = YYHomeCellTypeHot;
//                cell.dataArray = [YYGoodsModel testDataArray];
//                break;
//            case 1:
//                cell.type = YYHomeCellTypeNew;
//                cell.dataArray = [YYGoodsModel testManArray];
//                break;
//            case 2:
//                cell.type = YYHomeCellTypeTried;
//                cell.dataArray = [YYGoodsModel testWomanArray];
//                break;
//            case 2:
//                if (indexPath.row == 0) {
//                    cell.type = YYHomeCellTypeLabel;
//                    cell.label.text = @"推荐店铺";
//                } else {
//                    cell.type = YYHomeCellTypeShop;
//                    cell.shopModel = self.shopArray[indexPath.row - 1];
//                }
//                break;
//        }
    }
    
    cell.selectItemBlock = ^(YYGoodsModel *goodsModel, NSInteger index) {
        if (_delegate && [_delegate respondsToSelector:@selector(homeViewDidSelectItem:index:)]) {
            [_delegate homeViewDidSelectItem:goodsModel index:index];
        }
    };
    cell.showMorBlock = ^(YYHomeCellType type) {
        if (_delegate && [_delegate respondsToSelector:@selector(homeViewShowMoreInfo:)]) {
            [_delegate homeViewShowMoreInfo:type];
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    switch (indexPath.section) {
//        case 0:
//        case 1:
////        case 2:
//            return homeFirstCellHeight;
//            break;
//        case 2:
//            if (indexPath.row == 0) {
//                return 35;
//            }
//            return RELATIVE_WIDTH(130);
//            break;
//    }
    return RELATIVE_WIDTH(390);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 2) {
//        if (indexPath.row > 0) {
//            if (_delegate && [_delegate respondsToSelector:@selector(homeViewDidSelectShop:)]) {
//                [_delegate homeViewDidSelectShop:self.shopArray[indexPath.row - 1]];
//            }
//        }
//    }
    if (_delegate && [_delegate respondsToSelector:@selector(homeViewDidSelectShop:)]) {
        [_delegate homeViewDidSelectShop:self.shopArray[indexPath.row]];
    }
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_delegate && [_delegate respondsToSelector:@selector(homeViewDidScroll:)]) {
        [_delegate homeViewDidScroll:scrollView.contentOffset];
    }
}

#pragma mark - YYAdsViewDelegate
- (void)tapAds:(NSString *)adsID
{
    if (_delegate && [_delegate respondsToSelector:@selector(showAdsDetail:)]) {
        [_delegate showAdsDetail:adsID];
    }
}

@end
