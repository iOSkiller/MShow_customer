//
//  YYGoodsDetailView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/6.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYGoodsDetailView.h"
#import "YYCartBarView.h"
#import "YYAdsView.h"
#import "YYGoodsDetailViewCell.h"
#import "YYGussessLikeView.h"
#import "YYGoodsModel.h"
#import "YYCommentModel.h"

#define barHeight RELATIVE_WIDTH(110)
#define GoodsPriceSection 0
#define GoodsSpecSection 1
#define GoodsCommentSecion 2
#define GoodsDetailSection 3

@interface YYGoodsDetailView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYCartBarView *barView;
@property (nonatomic, weak) YYAdsView *adsView;
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) YYGussessLikeView *gusessLikeView;
@property (nonatomic, weak) UIButton *detailButton;

@end

@implementation YYGoodsDetailView

- (YYCartBarView *)barView {
    if (!_barView) {
        YYCartBarView *view = [[YYCartBarView alloc] initWithFrame:CGRectMake(0, self.mj_h - RELATIVE_WIDTH(110), self.mj_w, RELATIVE_WIDTH(110))];
        view.goodsCount = 3;
        [self addSubview:view];
        _barView = view;
    }
    return _barView;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h - barHeight) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorColor = YYSeparatorColor;
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        [tableView setLayoutMargins:UIEdgeInsetsZero];
        YYAdsView *view = [[YYAdsView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(600))];
        _adsView = view;
        tableView.tableHeaderView = self.adsView;
        
        YYGussessLikeView *gusessView = [[YYGussessLikeView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(10), self.mj_w, RELATIVE_WIDTH(1750))];
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(1750))];
        [footerView addSubview:gusessView];
        tableView.tableFooterView = footerView;
        
        _gusessLikeView = gusessView;
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (UIButton *)detailButton {
    if (!_detailButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_imagetext"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showDetail) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = RELATIVE_WIDTH(50);
        button.layer.masksToBounds = YES;
        [self addSubview:button];
        _detailButton = button;
    }
    return _detailButton;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self tableView];
        [self barView];
        self.gusessLikeView.likeGoodsArray = [YYGoodsModel testWomanArray];
        self.gusessLikeView.showGoodsBlock = ^(YYGoodsModel *goodsModel) {
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowGoodsDetail:)]) {
                [_delegate executeShowGoodsDetail:goodsModel];
            }
        };
        WS(weakSelf);
        self.barView.buttonBlock = ^(YYCartBarActionType actionType) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            [strongSelf executeAction:actionType];
        };
        
        [self.detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf).offset(RELATIVE_WIDTH(480));
            make.right.equalTo(weakSelf).offset(-RELATIVE_WIDTH(26));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(100));
        }];
    }
    return self;
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    self.adsView.infoArr = @[goodsModel.imagePath];
    [self.adsView reloadData];
}

- (void)updateGoodsSpec:(YYGoodsModel *)goodsModel
{
    
}

- (void)setGoodsCount:(NSInteger)goodsCount
{
    self.barView.goodsCount += 1;
}

- (void)showDetail
{
    
}

- (void)setCommentArray:(NSArray *)commentArray
{
    _commentArray = commentArray;
    [self.tableView reloadData];
}

- (void)executeAction:(YYCartBarActionType)actionType
{
    switch (actionType) {
        case YYCartBarActionTypePay:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(executePay:)]) {
                [_delegate executePay:_goodsModel];
            }
            break;
        }
        case YYCartBarActionTypeShowCart:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowShoppingCart)]) {
                [_delegate executeShowShoppingCart];
            }
            break;
        }
        case YYCartBarActionTypeShowShop:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowShop:)]) {
                [_delegate executeShowShop:_goodsModel.shop_id];
            }
            break;
        }
        case YYCartBarActionTypeShowMyshow:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowMyShow)]) {
                [_delegate executeShowMyShow];
            }
            break;
        }
        case YYCartBarActionTypeFollowGoods:
        case YYCartBarActionTypeDisFollowGoods:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(executeFollowGoods:)]) {
                [_delegate executeFollowGoods:_goodsModel];
            }
            break;
        }
    }
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case GoodsPriceSection:
            return 1;
            break;
        case GoodsSpecSection:
            return 2;
            break;
        case GoodsCommentSecion:
            return self.commentArray.count + 2;
            break;
        case GoodsDetailSection:
            return 1;
            break;
        default:
            break;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"%ld%ld", (long)indexPath.section, (long)indexPath.row];
    YYGoodsDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYGoodsDetailViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        switch (indexPath.section) {
            case GoodsPriceSection:
                cell.type = YYGoodsDetailViewCellTypeName;
                break;
            case GoodsSpecSection:
                switch (indexPath.row) {
                    case 0:
                        cell.type = YYGoodsDetailViewCellTypeSelectSizeColor;
                        cell.textLabel.text = @"请选择颜色尺寸";
                        break;
                    case 1:
                        cell.type = YYGoodsDetailViewCellTypeInfo;
                        break;
                    default:
                        break;
                }
                break;
            case GoodsCommentSecion:
                if (indexPath.row == 0) {
                    cell.type = YYGoodsDetailViewCellTypeDefault;
                } else if (indexPath.row == self.commentArray.count + 1){
                    cell.type = YYGoodsDetailViewCellTypeCenterLabel;
                    
                } else {
                    cell.type = YYGoodsDetailViewCellTypeComment;
                    YYCommentModel *model = self.commentArray[indexPath.row - 1];
                    cell.commentContentHeight = model.contentHeight;
                }
                
                break;
            default:
                break;
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYGoodsDetailViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    switch (indexPath.section) {
        case GoodsPriceSection:
            [cell setName:@"针织半裙" currentPrice:@"1200" originalPrice:@"1500"];
            break;
        case GoodsSpecSection:
            if (indexPath.row == 0) {
                cell.textLabel.text = @"请选择颜色尺寸";
            } else {
                
            }
            break;
        case GoodsCommentSecion:
            if (indexPath.row == 0) {
                cell.textLabel.text = @"优质评价(6)";
            } else if (indexPath.row == self.commentArray.count + 1){
                
            } else {
                cell.commentModel = self.commentArray[indexPath.row - 1];
            }
            
            break;
        case GoodsDetailSection:
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case GoodsPriceSection:
            
            break;
        case GoodsSpecSection:
            if (indexPath.row == 0) {
                if (_delegate && [_delegate respondsToSelector:@selector(executeSelecSpec:)]) {
                    [_delegate executeSelecSpec:_goodsModel];
                }
            }
            break;
        case GoodsCommentSecion:
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case GoodsPriceSection:
            return RELATIVE_WIDTH(150);
            break;
        case GoodsSpecSection:
        {
            switch (indexPath.row) {
                case 0:
                    return RELATIVE_WIDTH(80);
                    break;
                case 1:
                    return RELATIVE_WIDTH(140);
                    break;
//                case 2:
//                    return RELATIVE_WIDTH(178);
//                    break;
//                case 3:
//                    return RELATIVE_WIDTH(132);
//                    break;
                    
                default:
                    break;
            }
            break;
        }
        case GoodsCommentSecion:
        {
            if (indexPath.row == 0 || indexPath.row == self.commentArray.count + 1) {
                return RELATIVE_WIDTH(80);
            } else {
                YYCommentModel *model = self.commentArray[indexPath.row - 1];
                return model.cellHeight;
            }
            break;
        }
        case GoodsDetailSection:
            break;
        default:
            break;
    }
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return RELATIVE_WIDTH(10);
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
