//
//  YYMineView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineView.h"
#import "YYMineHeaderView.h"
#import "YYMineViewCell.h"
#import "YYUserModel.h"

#define InvateRow 1
#define AddressManagerRow 2
#define CreditRow 3
#define CommentRow 4
#define CertifyRow 5
#define CustomerServiceRow 6


@interface YYMineView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, weak) YYMineHeaderView *infoView;
@property (nonatomic, copy) NSArray *nameArray;
@property (nonatomic, copy) NSArray *imageArray;

@end

@implementation YYMineView

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        view.backgroundColor = mRGBToColor(0xf0f0f0);
        view.delegate = self;
        view.dataSource = self;
        [view setLayoutMargins:UIEdgeInsetsZero];
        [view setSeparatorInset:UIEdgeInsetsZero];
//        view.contentInset = UIEdgeInsetsMake(64, 0, iPhone_Tabbar_Height, 0);
        view.tableFooterView = [UIView new];
        [self addSubview:view];
        _tableView = view;
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(378))];
        headerView.backgroundColor = YYSeparatorColor;
        self.tableView.tableHeaderView = headerView;
        
        YYMineHeaderView *infoView = [[YYMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(378))];
        [headerView addSubview:infoView];
        infoView.functionActionBlock = ^(YYMineFunctionType type) {
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowFunctionDetail:)]) {
                [_delegate executeShowFunctionDetail:type];
            }
        };
        _infoView = infoView;
        
        self.infoView.tapActionBlock = ^{
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowInfoDetail)]) {
                [_delegate executeShowInfoDetail];
            }
        };
        self.infoView.setActionBlock = ^{
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowSetting)]) {
                [_delegate executeShowSetting];
            }
        };
        self.infoView.messageActionBlock = ^{
            if (_delegate && [_delegate respondsToSelector:@selector(executeShowMessage)]) {
                [_delegate executeShowMessage];
            }
        };
    
        self.nameArray = @[@"邀请有礼", @"地址管理", @"我的信用", @"我的评价", @"实名认证", @"客服中心"];
        self.imageArray = @[@"mine_img_friend", @"mine_img_address", @"mine_img_fitting", @"show_img_appraise", @"mine_img_identity", @"img_service"];
    }
    return self;
}

- (void)reloadCustomerInfo:(YYUserModel *)userModel
{
    self.infoView.userModel = userModel;
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    return self.nameArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"mineviewcellID%ld%ld", (long)indexPath.section, (long)indexPath.row];
    YYMineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYMineViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        if (indexPath.row == 0) {
            cell.backgroundColor = YYSectionFooterColor;
        }
        cell.fuctionBlock = ^(NSUInteger index) {
            YYDealStatusType type = YYDealStatusTypeWaitForPay;
            if (indexPath.row == 2) {
                switch (index) {
                    case 0:
                        break;
                    case 1:
                        type = YYDealStatusTypeWaitForDelivery;
                        break;
                    case 2:
                        type = YYDealStatusTypeWaitForRecieve;
                        break;
                    case 3:
                        type = YYDealStatusTypeWaitForReturn;
                        break;
                }
                if (_delegate && [_delegate respondsToSelector:@selector(executeShowDealDetail:)]) {
                    [_delegate executeShowDealDetail:type];
                }
                
            } else {
                switch (index) {
                    case 0:
                        type = YYDealStatusTypeWaitForComment;
                        break;
                    case 2:
                        type = YYDealStatusTypeWaitForSubmit;
                        break;
                    default:
                        break;
                }
                if (index == 1) {
                    if (_delegate && [_delegate respondsToSelector:@selector(executeShowFunctionDetail:)]) {
                        [_delegate executeShowFunctionDetail:YYMineFunctionTypeChange];
                    }
                } else {
                    if (_delegate && [_delegate respondsToSelector:@selector(executeShowDealDetail:)]) {
                        [_delegate executeShowDealDetail:type];
                    }
                }
            }
            
        };
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYMineFunctionType type = YYMineFunctionTypeCoupon;
    if (indexPath.section == 0 && indexPath.row == 1) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeShowAllDeal)]) {
            [_delegate executeShowAllDeal];
        }
    } else {
        switch (indexPath.row) {
            case InvateRow:
                type = YYMineFunctionTypeInvite;
                break;
            case AddressManagerRow:
                type = YYMineFunctionTypeAddress;
                break;
            case CreditRow:
                type = YYMineFunctionTypeCreditRate;
                break;
            case CommentRow:
                type = YYMineFunctionTypeComments;
                break;
            case CertifyRow:
                type = YYMineFunctionTypeCertify;
                break;
            case CustomerServiceRow:
                type = YYMineFunctionTypeCustomerServer;
                break;
        }
        if (_delegate && [_delegate respondsToSelector:@selector(executeShowFunctionDetail:)]) {
            [_delegate executeShowFunctionDetail:type];
        }
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYMineViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 1:
                cell.textLabel.text = @"我的订单";
                cell.detailTextLabel.text = @"查看全部";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 2:
            {
                [cell setImageArray:@[@"mine_img_payment", @"mine_img_shipping", @"mine_img_recieve", @"mine_img_restitution",] titleArray:@[@"待付款", @"待发货", @"待收货", @"待归还"]];
            }
                break;
            case 3:
            {
                [cell setImageArray:@[@"show_img_appraise", @"img_return", @"img_sure",] titleArray:@[@"待评价", @"退换/售后", @"待确认"]];
            }
                break;
        }
    } else {
        if (indexPath.row > 0) {
            cell.textLabel.text = self.nameArray[indexPath.row - 1];
            cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row - 1]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return RELATIVE_WIDTH(10);
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 2 || indexPath.row == 3) {
            return RELATIVE_WIDTH(150);
        }
    }
    return RELATIVE_WIDTH(82);
}

@end
