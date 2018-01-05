//
//  YYDealChildViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/10.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYDealChildViewController.h"
#import "YYDealChildView.h"
#import "YYDealModel.h"
#import "YYAlertView.h"

#import "YYCommentDealViewController.h"
#import "YYPayDealViewController.h"
#import "YYDealDetailViewController.h"
#import "YYReturnBuyGoodsViewController.h"
#import "YYAppealViewController.h"

#import "YYDealHandle.h"

@interface YYDealChildViewController () <YYDealCildViewDelegate>
@property (nonatomic, weak) YYDealChildView *dealView;

@end

@implementation YYDealChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    YYDealChildView *dealView = [[YYDealChildView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(80))];
    dealView.delegate = self;
    [self.view addSubview:dealView];
    _dealView = dealView;
    [self fetchData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)fetchData
{
    WS(weakSelf);
    [YYDealHandle executeGetDeal:YYDealStatusTypeWaitForTakeOrder userID:(mAppDelegate).userID pageNum:@"1" pageSize:@"10" success:^(id obj) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
    } failed:^(id failed) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf showMessage:failed hud:nil duration:1.2];
    }];
    self.dealView.type = _statusType;
    self.dealView.dataArray = _statusType == YYDealStatusTypeWaitForReturn ? [YYDealModel testTryDataArray] : [YYDealModel testBuyDataArrary];
}

#pragma mark - YYDealCildViewDelegate
/**取消订单*/
- (void)executeCancelDeal:(YYDealModel *)dealModel;
{
    YYAlertView *alertView = [[YYAlertView alloc] initWithType:YYAlertViewTypeCancelDeal];
    WS(weakSelf);
    alertView.cancelBlock = ^(YYCancelReasonType reasonType) {
        MJExtensionLog(@"cancel deal: %ld", (long)reasonType);
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf.dealView deleteDeal:dealModel];
    };
    [alertView show];
}

/**支付订单*/
- (void)executePayDeal:(YYDealModel *)dealModel;
{
    MJExtensionLog(@"pay deal");
    YYPayDealViewController *payVC = [YYPayDealViewController new];
    [self.navigationController pushViewController:payVC animated:YES];
    WS(weakSelf);
    [YYDealHandle executeChangeDealSatus:YYDealStatusTypeWaitForTakeOrder orderID:@"" success:^(id obj) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
    } failed:^(id failed) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf showMessage:failed hud:nil duration:1.2];
    }];
}

/**催单*/
- (void)executeRemindDeal:(YYDealModel *)dealModel;
{
    MJExtensionLog(@"remind deal");
}

/**确认收货*/
- (void)executeConfirmReceipt:(YYDealModel *)dealModel;
{
    MJExtensionLog(@"confirm receipt deal");
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定收货吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        WS(weakSelf);
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf.dealView deleteDeal:dealModel];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertControl addAction:sureAction];
    [alertControl addAction:cancelAction];
    [self presentViewController:alertControl animated:YES completion:nil];
    
}

/**购买衣服*/
- (void)executeBuyGoods:(YYDealModel *)dealModel;
{
    MJExtensionLog(@"buy goods");
    YYReturnBuyGoodsViewController *returnGoodsVC = [YYReturnBuyGoodsViewController new];
    returnGoodsVC.dealModel = dealModel;
    returnGoodsVC.type = YYMineFunctionTypeBuy;
    [self.navigationController pushViewController:returnGoodsVC animated:YES];
}

/**自还*/
- (void)executeReturnBySelf:(YYDealModel *)dealModel;
{
    MJExtensionLog(@"return goods by self");
    YYReturnBuyGoodsViewController *returnGoodsVC = [YYReturnBuyGoodsViewController new];
    returnGoodsVC.dealModel = dealModel;
    returnGoodsVC.type = YYMineFunctionTypeReturnBySelf;
    [self.navigationController pushViewController:returnGoodsVC animated:YES];
}

/**下单归还*/
- (void)executeReturnGoods:(YYDealModel *)dealModel;
{
    MJExtensionLog(@"return goods");
    YYReturnBuyGoodsViewController *returnGoodsVC = [YYReturnBuyGoodsViewController new];
    returnGoodsVC.dealModel = dealModel;
    returnGoodsVC.type = YYMineFunctionTypeReturn;
    [self.navigationController pushViewController:returnGoodsVC animated:YES];
}

/**删除订单*/
- (void)executeDeletDeal:(YYDealModel *)dealModel;
{
    MJExtensionLog(@"delete deal");
    
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除该订单吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        WS(weakSelf);
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf.dealView deleteDeal:dealModel];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertControl addAction:sureAction];
    [alertControl addAction:cancelAction];
    [self presentViewController:alertControl animated:YES completion:nil];
}

/**待评价*/
- (void)executeCommentDeal:(YYDealModel *)dealModel;
{
    MJExtensionLog(@"comment deal");
    YYCommentDealViewController *commentVC = [YYCommentDealViewController new];
    commentVC.dealModel = dealModel;
    WS(weakSelf);
    commentVC.didFinishCommentBlock = ^(YYDealModel *dealModel) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf.dealView deleteDeal:dealModel];
    };
    [self.navigationController pushViewController:commentVC animated:YES];
    
}

/**申诉*/
- (void)executeAppealDeal:(YYDealModel *)dealModel
{
    YYAppealViewController *appealVC = [YYAppealViewController new];
    appealVC.dealModel = dealModel;
    WS(weakSelf);
    appealVC.didFinishAppealBlock = ^{
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        dealModel.statusType = YYDealStatusTypeInAppeal;
        [strongSelf.dealView updateDealStatus:dealModel];
    };
    [self.navigationController pushViewController:appealVC animated:YES];
}

/**订单详情*/
- (void)executeShowDealDetail:(YYDealModel *)dealModel
{
    MJExtensionLog(@"show deal detail");
    dealModel.statusType = _statusType;
    YYDealDetailViewController *dealDetailVC = [YYDealDetailViewController new];
    dealDetailVC.dealModel = dealModel;
    [self.navigationController pushViewController:dealDetailVC animated:YES];
}

/**物流详情*/
- (void)executeShowDealDelivery:(YYDealModel *)dealModel
{
    MJExtensionLog(@"show deal delivery");
}

- (void)executeSubmitDeal:(YYDealModel *)dealModel
{
    WS(weakSelf);
    [YYDealHandle exuecuteSubmitDeal:@"6" success:^(id obj) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
    } failed:^(id failed) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf showMessage:failed hud:nil duration:1.2];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
