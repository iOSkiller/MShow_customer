//
//  YYSelectReturnRecieveTypeView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/3.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectReturnRecieveTypeView.h"
#import "YYSelectReturnRecieveTypeViewCell.h"

@interface YYSelectReturnRecieveTypeView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;

@end

@implementation YYSelectReturnRecieveTypeView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.backgroundColor = [UIColor whiteColor];
        view.separatorColor = YYSeparatorColor;
        view.separatorInset = UIEdgeInsetsZero;
        view.layoutMargins = UIEdgeInsetsZero;
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
        
    }
    return self;
}

- (void)setType:(YYSelectReturnRecieveViewType)type
{
    _type = type;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"%@%@", @(indexPath.section), @(indexPath.row)];
    YYSelectReturnRecieveTypeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYSelectReturnRecieveTypeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        switch (indexPath.row) {
            case 0:
                cell.label.text = _type == YYSelectReturnRecieveViewTypeDelivery ? @"自送" : @"自取";
                break;
            case 1:
                cell.label.text = _type == YYSelectReturnRecieveViewTypeDelivery ? @"上门取件" : @"送上门";
                break;
            default:
                break;
        }
        WS(weakSelf);
        cell.selectBlock = ^(BOOL isSelected) {
            StrongSelf(strongSelf);
            strongSelf = weakSelf;
            if (isSelected) {
                if (_didSelectType) {
                    [strongSelf.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                    if (_type == YYSelectReturnRecieveViewTypeReturn) {
                        _didSelectType(indexPath.row == 0 ? YYMineFunctionTypeReturnBySelf : YYMineFunctionTypeReturn);
                    } else {
                        _didSelectType(indexPath.row == 0 ? YYMineFunctionTypeDeliveryBySelf : YYMineFunctionTypeDeliveryByPost);
                    }
                }
            }
        };
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_didSelectType) {
        if (_type == YYSelectReturnRecieveViewTypeReturn) {
            _didSelectType(indexPath.row == 0 ? YYMineFunctionTypeReturnBySelf : YYMineFunctionTypeReturn);
        } else {
            _didSelectType(indexPath.row == 0 ? YYMineFunctionTypeDeliveryBySelf : YYMineFunctionTypeDeliveryByPost);
        }
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
    return RELATIVE_WIDTH(120);
}

@end
