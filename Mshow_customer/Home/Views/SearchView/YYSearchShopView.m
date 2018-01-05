//
//  YYSearchShopView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/2.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSearchShopView.h"
#import "YYSearchShopViewCell.h"
#import "YYShopModel.h"

@interface YYSearchShopView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YYSearchShopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObjectsFromArray:[YYShopModel testWashShopAarray]];
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.separatorColor = YYSeparatorColor;
        view.separatorInset = UIEdgeInsetsZero;
        view.layoutMargins = UIEdgeInsetsZero;
        view.backgroundColor = [UIColor whiteColor];
        view.tableFooterView = [UIView new];
        view.delegate = self;
        view.dataSource = self;
        [self addSubview:view];
        _tableView = view;
    }
    return self;
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"%@%@", @(indexPath.row), @(indexPath.section)];
    YYSearchShopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYSearchShopViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    YYShopModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.shopName;
    cell.detailTextLabel.text = model.address;
    cell.distanceLabel.text = AppendString(model.distance, @"千米");
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(140);
}

@end
