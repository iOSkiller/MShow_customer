//
//  YYDealDetailViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYDealDetailViewController.h"
#import "YYDealDetailView.h"
#import "YYMineWardrobeFunctionView.h"
#import "YYDealModel.h"
#import "YYGoodsModel.h"

#import "YYAlertView.h"
#import "YYCommentDealViewController.h"
#import "YYPayDealViewController.h"
#import "YYReturnBuyGoodsViewController.h"
#import "YYMyCouponViewController.h"
#import "YYAppealViewController.h"

#import "YYDealHandle.h"

@interface YYDealDetailViewController () <YYDealDetailViewDelegate>
@property (nonatomic, weak) YYDealDetailView *detailView;
@property (nonatomic, weak) YYMineWardrobeFunctionView *functionView;

@end

@implementation YYDealDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self fetchData];
    YYDealDetailView *dealView = [[YYDealDetailView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(100) - iPhone_MARGIN_BOTTOM)];
    dealView.dealModel = self.dealModel;
    dealView.delegate = self;
    [self.view addSubview:dealView];
    _detailView = dealView;
    switch (_dealModel.statusType) {
        case YYDealStatusTypeWaitForPay:
        {
            YYMineWardrobeFunctionView *functionView = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(100) - iPhone_MARGIN_BOTTOM, WIN_WIDTH, RELATIVE_WIDTH(100)) functionArray:@[@"付款", @"取消订单"] haveDealInfo:nil];
            functionView.statusType = _dealModel.statusType;
            [self.view addSubview:functionView];
            _functionView = functionView;
            break;
        }
        case YYDealStatusTypeWaitForReturn:
        {
            YYMineWardrobeFunctionView *functionView = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(100) - iPhone_MARGIN_BOTTOM, WIN_WIDTH, RELATIVE_WIDTH(100)) functionArray:@[@"下单归还", @"自还", @"我要买",] haveDealInfo:nil];
            functionView.statusType = _dealModel.statusType;
            [self.view addSubview:functionView];
            _functionView = functionView;
            break;
        }
        case YYDealStatusTypeWaitForComment:
        {
            YYMineWardrobeFunctionView *functionView = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(100) - iPhone_MARGIN_BOTTOM, WIN_WIDTH, RELATIVE_WIDTH(100)) functionArray:@[@"评价", @"删除订单"] haveDealInfo:nil];
            functionView.statusType = _dealModel.statusType;
            [self.view addSubview:functionView];
            _functionView = functionView;
            break;
        }
        case YYDealStatusTypeWaitForRecieve:
        {
            YYMineWardrobeFunctionView *functionView = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(100) - iPhone_MARGIN_BOTTOM, WIN_WIDTH, RELATIVE_WIDTH(100)) functionArray:@[@"确认收货"] haveDealInfo:nil];
            functionView.statusType = _dealModel.statusType;
            [self.view addSubview:functionView];
            _functionView = functionView;
            break;
        }
        case YYDealStatusTypeWaitForDelivery:
        {
            YYMineWardrobeFunctionView *functionView = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(100) - iPhone_MARGIN_BOTTOM, WIN_WIDTH, RELATIVE_WIDTH(100)) functionArray:@[@"催单", @"取消订单"] haveDealInfo:nil];
            functionView.statusType = _dealModel.statusType;
            [self.view addSubview:functionView];
            _functionView = functionView;
            break;
        }
        case YYDealStatusTypeWaitForSubmit:
        {
            YYMineWardrobeFunctionView *functionView = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(100) - iPhone_MARGIN_BOTTOM, WIN_WIDTH, RELATIVE_WIDTH(100)) functionArray:@[@"确认订单", @"申诉"] haveDealInfo:nil];
            functionView.statusType = _dealModel.statusType;
            [self.view addSubview:functionView];
            _functionView = functionView;
            break;
        }
        case YYDealStatusTypeWaitForTakeOrder:
        {
            YYMineWardrobeFunctionView *functionView = [[YYMineWardrobeFunctionView alloc] initWithFrame:CGRectMake(0, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(100) - iPhone_MARGIN_BOTTOM, WIN_WIDTH, RELATIVE_WIDTH(100)) functionArray:@[@"取消订单",] haveDealInfo:nil];
            functionView.statusType = _dealModel.statusType;
            [self.view addSubview:functionView];
            _functionView = functionView;
        }
            break;
        default:
            break;
    }
    self.functionView.backgroundColor = [UIColor whiteColor];
    self.functionView.buttonActionBlock = ^(YYMineFunctionType type) {
        [self executeAction:type];
    };
}

- (void)fetchData
{
    WS(weakSelf);
    [YYDealHandle executeGetDealDetail:@"10" success:^(id obj) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
    } failed:^(id failed) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf showMessage:failed hud:nil duration:1.2];
    }];
}

- (void)executeAction:(YYMineFunctionType)type
{
    switch (type) {
        case YYMineFunctionTypeDeleteDeal:
        {
            UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除该订单吗？" preferredStyle:UIAlertControllerStyleAlert];
            WS(weakSelf);
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                StrongSelf(strongSelf);
                strongSelf = weakSelf;
                if (strongSelf.deleteDealBlock) {
                    strongSelf.deleteDealBlock(_dealModel);
                }
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertControl addAction:sureAction];
            [alertControl addAction:cancelAction];
            [self presentViewController:alertControl animated:YES completion:nil];
        }
            break;
        case YYMineFunctionTypeReturnBySelf:
        {
            YYReturnBuyGoodsViewController *returnGoodsVC = [YYReturnBuyGoodsViewController new];
            returnGoodsVC.dealModel = _dealModel;
            returnGoodsVC.type = YYMineFunctionTypeReturnBySelf;
            [self.navigationController pushViewController:returnGoodsVC animated:YES];
        }
            break;
        case YYMineFunctionTypeReturn:
        {
            YYReturnBuyGoodsViewController *returnGoodsVC = [YYReturnBuyGoodsViewController new];
            returnGoodsVC.dealModel = _dealModel;
            returnGoodsVC.type = YYMineFunctionTypeReturn;
            [self.navigationController pushViewController:returnGoodsVC animated:YES];
        }
            break;
        case YYMineFunctionTypeBuy:
        
            break;
        case YYMineFunctionTypeCancelDeal:
        {
            YYAlertView *alertView = [[YYAlertView alloc] initWithType:YYAlertViewTypeCancelDeal];
            WS(weakSelf);
            alertView.cancelBlock = ^(YYCancelReasonType reasonType) {
                MJExtensionLog(@"cancel deal: %ld", (long)reasonType);
                StrongSelf(strongSelf);
                strongSelf = weakSelf;
                [strongSelf.navigationController popViewControllerAnimated:YES];
            };
            [alertView show];
        }
            break;
        case YYMineFunctionTypeConformReceipt:
        {
            UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定收货吗？" preferredStyle:UIAlertControllerStyleAlert];
            WS(weakSelf);
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                StrongSelf(strongSelf);
                strongSelf = weakSelf;
                if (strongSelf.recieveDealBlock) {
                    strongSelf.recieveDealBlock(strongSelf.dealModel);
                }
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertControl addAction:sureAction];
            [alertControl addAction:cancelAction];
            [self presentViewController:alertControl animated:YES completion:nil];
        }
            break;
        case YYMineFunctionTypeComments:
        {
            YYCommentDealViewController *commentVC = [[YYCommentDealViewController alloc] init];
            WS(weakSelf);
            commentVC.didFinishCommentBlock = ^(YYDealModel *dealModel) {
                StrongSelf(strongSelf);
                strongSelf = weakSelf;
                strongSelf.dealModel = dealModel;
            };
            [self.navigationController pushViewController:commentVC animated:YES];
        }
            break;
        case YYMineFunctionTypePayDeal:
        {
            YYPayDealViewController *payVC = [[YYPayDealViewController alloc] init];
            payVC.type = YYPayDealViewControllerTypeBuy;
            [self.navigationController pushViewController:payVC animated:YES];
        }
            break;
        case YYMineFunctionTypeRemindDeal:
            
            break;
        case YYMineFunctionTypeAppeal:
        {
            YYAppealViewController *appealVC = [YYAppealViewController new];
            appealVC.dealModel = _dealModel;
            appealVC.didFinishAppealBlock = ^{
                
            };
            [self.navigationController pushViewController:appealVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - YYDealDetailViewDelegate
- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel
{
    [self showGoodsDetail:goodsModel.goodsId];
}

- (void)executeShowDealDeliveryDetail:(YYDealModel *)dealModel
{
    
}

- (void)executeSelectCoupon
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
