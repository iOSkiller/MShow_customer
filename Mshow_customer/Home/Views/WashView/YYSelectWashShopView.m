//
//  YYSelectWashShopView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/2.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectWashShopView.h"
#import "YYSelectWashShopViewCell.h"
#import "YYSearchBar.h"
#import "YYButton.h"
#import "YYShopModel.h"

@interface YYSelectWashShopView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) YYSearchBar *searchBar;
@property (nonatomic, weak) YYButton *locationButton;
@property (nonatomic, strong) NSMutableArray *historyShopArray;
@property (nonatomic, strong) NSMutableArray *nearbyShopArray;

@end

@implementation YYSelectWashShopView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(120), self.mj_w, self.mj_h - RELATIVE_WIDTH(120)) style:UITableViewStylePlain];
        view.separatorColor = YYSeparatorColor;
        view.backgroundColor = YYSeparatorColor;
        view.tableFooterView = [UIView new];
        [view setSeparatorInset:UIEdgeInsetsZero];
        [view setLayoutMargins:UIEdgeInsetsZero];
        view.delegate = self;
        view.dataSource = self;
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}

- (NSMutableArray *)nearbyShopArray {
    if (!_nearbyShopArray) {
        _nearbyShopArray = [NSMutableArray array];
    }
    return _nearbyShopArray;
}

- (NSMutableArray *)historyShopArray {
    if (!_historyShopArray) {
        _historyShopArray = [NSMutableArray array];
    }
    return _historyShopArray;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.nearbyShopArray addObjectsFromArray:[YYShopModel testWashShopAarray]];
        
        [self.historyShopArray addObject:[self.nearbyShopArray firstObject]];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(120))];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        [button setRightImage:[UIImage imageNamed:@"img_arrow_down"] selectedRightImage:nil leftTitle:@"南京" selectedLeftTitle:nil];
        button.titleFont = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        button.normalColor = YYTextColor;
        [button addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(view).offset(RELATIVE_WIDTH(26));
            make.width.mas_equalTo(RELATIVE_WIDTH(100));
            make.height.mas_equalTo(RELATIVE_WIDTH(36));
        }];
        _locationButton = button;
        
        YYSearchBar *searchBar = [[YYSearchBar alloc] init];
        searchBar.isFull = YES;
        searchBar.backgroundColor = mRGBToColor(0xfafafa);
        searchBar.type = YYSearchBarTypeLabel;
        searchBar.frame = CGRectMake(0, 0, WIN_WIDTH - RELATIVE_WIDTH(40), RELATIVE_WIDTH(60));
        searchBar.text = @"干洗店";
        searchBar.layer.cornerRadius = RELATIVE_WIDTH(30);
        searchBar.layer.borderWidth = RELATIVE_WIDTH(1);
        searchBar.layer.borderColor = mRGBToColor(0xeeeeee).CGColor;
        searchBar.layer.masksToBounds = YES;
        searchBar.showSearchViewBlock = ^{
            if (_delegate && [_delegate respondsToSelector:@selector(executeSearchWashShop)]) {
                [_delegate executeSearchWashShop];
            }
        };
        [view addSubview:searchBar];
        [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button.mas_right).offset(RELATIVE_WIDTH(40));
            make.centerY.equalTo(view);
            make.height.mas_equalTo(RELATIVE_WIDTH(60));
            make.right.equalTo(view).offset(-RELATIVE_WIDTH(26));
        }];
        _searchBar = searchBar;
    }
    
    [self tableView];
    
    return self;
}

- (void)locationAction
{
    
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.historyShopArray.count;
            break;
        case 2:
            return self.nearbyShopArray.count;
            break;
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYSelectWashShopViewCellID:%@%@", @(indexPath.row), @(indexPath.section)];
    YYSelectWashShopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYSelectWashShopViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        switch (indexPath.section) {
            case 0:
            {
                cell.type = YYSelectWashShopViewCellTypeAddress;
                cell.textLabel.text = @"亚都商务大厦";
                break;
            }
            case 1:
            {
                cell.type = YYSelectWashShopViewCellTypeHistoryShop;
                cell.shopModel = self.historyShopArray[indexPath.row];
            }
                break;
            case 2:
            {
                cell.type = YYSelectWashShopViewCellTypeNearbyShop;
                YYShopModel *shopModel = self.nearbyShopArray[indexPath.row];
                cell.textLabel.text = shopModel.shopName;
                cell.detailTextLabel.text = AppendString(shopModel.distance, @"千米");
                break;
            }
            default:
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
            if (_delegate && [_delegate respondsToSelector:@selector(executeDidSelectShop:)]) {
                [_delegate executeDidSelectShop:self.historyShopArray[indexPath.row]];
            }
            break;
        case 2:
            if (_delegate && [_delegate respondsToSelector:@selector(executeDidSelectShop:)]) {
                [_delegate executeDidSelectShop:self.nearbyShopArray[indexPath.row]];
            }
            break;
            
        default:
            break;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return RELATIVE_WIDTH(90);
            break;
        case 1:
            return RELATIVE_WIDTH(120);
            break;
        case 2:
            return RELATIVE_WIDTH(90);
            break;
        default:
            return 0.000001;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return RELATIVE_WIDTH(80);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(80))];
    view.backgroundColor = YYSeparatorColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(26), 0, self.mj_w - RELATIVE_WIDTH(52), RELATIVE_WIDTH(80))];
    label.backgroundColor = YYSeparatorColor;
    label.textColor = YYGrayTextColor;
    label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
    switch (section) {
        case 0:
            label.text = @"当前位置";
            break;
        case 1:
            label.text = @"历史预约";
            break;
        case 2:
            label.text = @"附近店";
            break;
        default:
            break;
    }
    [view addSubview:label];
    
    return view;
}

@end
