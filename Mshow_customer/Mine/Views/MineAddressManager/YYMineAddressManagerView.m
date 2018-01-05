//
//  YYMineAddressManagerView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/16.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineAddressManagerView.h"
#import "YYMineAddressManagerViewCell.h"
#import "YYAddressModel.h"

@interface YYMineAddressManagerView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) UIView *functionView;
@property (nonatomic, strong) NSMutableArray <YYAddressModel *> *array;

@end

@implementation YYMineAddressManagerView

{
    NSString *_defaultAddressID;
    NSUInteger _defaultIndex;
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}


- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.delegate = self;
        view.dataSource = self;
        [view setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        view.backgroundColor = YYSeparatorColor;
        view.showsVerticalScrollIndicator = NO;
        view.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(30))];
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}

- (UIView *)functionView {
    if (!_functionView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(100))];
        view.backgroundColor = [UIColor whiteColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"新增地址" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = YYGlobalColor;
        button.layer.cornerRadius = CommonCornerRadius;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        button.center = view.center;
        button.bounds = CGRectMake(0, 0, RELATIVE_WIDTH(200), RELATIVE_WIDTH(60));
        [view addSubview:button];
        [self addSubview:view];
        _functionView = view;
    }
    return _functionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self tableView];
        [self functionView];
        WS(ws);
        [self.functionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(ws);
            make.bottom.equalTo(ws).offset(-iPhone_MARGIN_BOTTOM);
            make.height.mas_equalTo(RELATIVE_WIDTH(100));
        }];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.functionView.mas_top);
            make.left.right.top.equalTo(ws);
        }];
    }
    return self;
}

- (void)addAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeAddAddress)]) {
        [_delegate executeAddAddress];
    }
}

- (void)changeDefaultAddress:(YYAddressModel *)addressModel index:(NSUInteger)index
{
//    if (![addressModel.addressID isEqualToString:_defaultAddressID]) {
//        addressModel.isDefault = YES;
//        _defaultAddressID = addressModel.addressID;
//        [self.array replaceObjectAtIndex:index withObject:addressModel];
//
//        YYAddressModel *model = [self.array firstObject];
//        model.isDefault = NO;
//        [self.array replaceObjectAtIndex:0 withObject:model];
//        [self.array removeObjectAtIndex:index];
//        [self.array insertObject:model atIndex:1];
////        [self.tableView beginUpdates];
////        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
////        [self.tableView endUpdates];
////        [self.tableView moveSection:index toSection:0];
//        [self.tableView reloadData];
//    }
    if (self.array.count) {
        [self.array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YYAddressModel *originalmodel = (YYAddressModel *)obj;
            if ([originalmodel.addressID isEqualToString:_defaultAddressID]) {
                *stop = YES;
                originalmodel.isDefault = NO;
            }
            if (*stop == YES) {
                [self.tableView endUpdates];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:idx] withRowAnimation:UITableViewRowAnimationNone];
                [self.tableView endUpdates];
            }
        }];
    }
    
    [self.array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YYAddressModel *originalmodel = (YYAddressModel *)obj;
        if ([originalmodel.addressID isEqualToString:addressModel.addressID]) {
            *stop = YES;
            originalmodel.isDefault = YES;
            _defaultAddressID = originalmodel.addressID;
        }
        if (*stop == YES) {
            [self.tableView endUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:idx] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }
    }];
}

- (void)deleteAddress:(YYAddressModel *)addressModel index:(NSUInteger)index
{
    [self.array enumerateObjectsUsingBlock:^(YYAddressModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.addressID isEqualToString:addressModel.addressID]) {
            *stop = YES;
        }
        if (*stop == YES) {
            [self.array removeObject:obj];
            if (self.array.count > 0) {
                //如果删除了默认地址，更新userDefault
                if (obj.isDefault) {
                    YYAddressModel *defaultModel = [self.array firstObject];
                    defaultModel.isDefault = YES;
                    [self.array replaceObjectAtIndex:0 withObject:defaultModel];
//                    if ([addressModel.province isEqualToString:addressModel.city]) {
//                        (mAppDelegate).defaultAddress = [NSString stringWithFormat:@"%@%@%@", model.province, model.district, model.address];
//                    } else {
//                        (mAppDelegate).defaultAddress = [NSString stringWithFormat:@"%@%@%@%@", model.province, model.city, model.district, model.address];
//                    }
                    
//                    (mAppDelegate).defaultPhone = model.mobile;
//                    (mAppDelegate).defaultConsignee = model.consignee;
//                    [self setAddress:defaultModel indexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//                    [self updateUserDefault];
                }
                [self.tableView beginUpdates];
                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:idx] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView endUpdates];
                
            } else {
//                (mAppDelegate).defaultAddress = @"";
//                (mAppDelegate).defaultPhone = @"";
//                (mAppDelegate).defaultConsignee = @"";
//                [self updateUserDefault];
                [self.tableView reloadData];
            }
            
        }
    }];
    
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.array removeAllObjects];
    [self.array addObjectsFromArray:dataArray];
    YYAddressModel *model = [self.array firstObject];
    _defaultAddressID = model.addressID;
    _defaultIndex = 0;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYMineCommentViewCell:%ld%ld", (long)indexPath.section, (long)indexPath.row];
    YYMineAddressManagerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYMineAddressManagerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    WS(weakSelf);
    cell.deleteActionBlock = ^(YYAddressModel *addressModel) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeDeleteAddress:)]) {
            [_delegate executeDeleteAddress:addressModel];
        }
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf deleteAddress:addressModel index:indexPath.section];
    };
    
    cell.editeActionBlock = ^(YYAddressModel *addressModel) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeEditeAddress:)]) {
            [_delegate executeEditeAddress:addressModel];
        }
    };
    
    cell.changeDefaultBlock = ^(YYAddressModel *addressModel) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeChageDefaultAddress:)]) {
            [_delegate executeChageDefaultAddress:addressModel];
        }
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf changeDefaultAddress:addressModel index:indexPath.section];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RELATIVE_WIDTH(250);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYMineAddressManagerViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.addressModel = self.array[indexPath.section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeSelectAddress:)]) {
        [_delegate executeSelectAddress:self.array[indexPath.section]];
    }
}


@end
