//
//  YYMineEditeView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineAddressEditeView.h"
#import "YYMineAddressEditeViewCell.h"
#import "YYAddressModel.h"
#import "YYAddressPickerView.h"

@interface YYMineAddressEditeView () <UITableViewDelegate, UITableViewDataSource, YYAddressPickerViewDelegate>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) YYAddressPickerView *pickerView;
@end

@implementation YYMineAddressEditeView

- (YYAddressPickerView *)pickerView {
    if (!_pickerView) {
        YYAddressPickerView *pickerView = [[YYAddressPickerView alloc] initWithFrame:CGRectMake(0, self.mj_h - YYAddressPickerViewHeight, self.mj_w, YYAddressPickerViewHeight)];
        pickerView.delegate = self;
        [self addSubview:pickerView];
        _pickerView = pickerView;
    }
    return _pickerView;
}


- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *tableView = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.backgroundColor = YYSeparatorColor;
        [tableView setSeparatorColor:YYSeparatorColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(200))];
        tableView.tableFooterView.backgroundColor = mRGBToColor(0xf0f0f0);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(36)];
        button.backgroundColor = YYGlobalColor;
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(RELATIVE_WIDTH(26), RELATIVE_WIDTH(76), self.mj_w - RELATIVE_WIDTH(52), RELATIVE_WIDTH(82));
        [tableView.tableFooterView addSubview:button];
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.addressModel = [YYAddressModel new];
        [self tableView];
        [self pickerView];
    }
    return self;
}

- (void)buttonAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeFinishAction:)]) {
        [_delegate executeFinishAction:_addressModel];
    }
}

#pragma mark - YYAddressPickerViewDelegate
- (void)getCity:(NSString *)cityString showString:(NSString *)showString
{
    
}


- (void)getProvince:(NSString *)province city:(NSString *)city district:(NSString *)district
{
    _addressModel.province = province;
    _addressModel.city = city;
    _addressModel.area = district;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYMineEditeViewCell:%@%@", @(indexPath.row), @(indexPath.section)];
    YYMineAddressEditeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYMineAddressEditeViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        if (indexPath.section == 1 && indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"姓名";
                    cell.type = YYMineAddressEditeViewCellTypeName;
                    break;
                case 1:
                    cell.type = YYMineAddressEditeViewCellTypeGender;
                    break;
                case 2:
                    cell.textLabel.text = @"手机";
                    cell.type = YYMineAddressEditeViewCellTypePhone;
                    break;
                default:
                    break;
            }
        } else {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"地址";
                    if ([_addressModel.province isValid]) {
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@-%@", _addressModel.province, _addressModel.city, _addressModel.area];
                    } else {
                        cell.detailTextLabel.text = @"选择收货地址";
                    }
                    break;
                case 1:
                    cell.textLabel.text = @"门牌号";
                    cell.type = YYMineAddressEditeViewCellTypeDetailAddress;
                    break;
                default:
                    break;
            }
        }
        cell.nameBlock = ^(NSString *name) {
            
        };
        cell.phoneBlock = ^(NSString *phone) {
            
        };
        cell.detailAddressBlock = ^(NSString *detailAddress) {
            
        };
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYMineAddressEditeViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self.pickerView showPicker];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return RELATIVE_WIDTH(90);
    }
    return RELATIVE_WIDTH(120);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return RELATIVE_WIDTH(80);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(80))];
    view.backgroundColor = YYSeparatorColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(30), 0, WIN_WIDTH - RELATIVE_WIDTH(30), RELATIVE_WIDTH(80))];
    label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
    label.textColor = YYGrayTextColor;
    label.text = section == 0 ? @"联系人" : @"收货地址";
    label.backgroundColor = YYSeparatorColor;
    [view addSubview:label];
    return view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = RELATIVE_WIDTH(80);
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

@end
