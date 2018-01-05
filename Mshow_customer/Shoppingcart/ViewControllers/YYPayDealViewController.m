//
//  YYPayDealViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYPayDealViewController.h"
#import "YYPayDealView.h"
#import "YYPaySuccessViewController.h"
#import "YYSubscribeSuccessViewController.h"
#import "YYPayMentHandle.h"
#import "YYWXPayModel.h"
#import "YYWeixinPayManager.h"
#import "AliPayNeedDEF.h"
#import "YYDealModel.h"

@interface YYPayDealViewController () <YYPayDealViewDelegate>
@property (nonatomic, weak) YYPayDealView *payView;

@end

@implementation YYPayDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付订单";
    self.fd_interactivePopDisabled = YES;
    [self setUpLeftItem:nil selectedTitle:nil image:@"img_arrow_left" highImage:@"img_arrow_left" target:self action:@selector(backAction)];
    
    YYPayDealView *view = [[YYPayDealView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.delegate = self;
    [self.view addSubview:view];
    _payView = view;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:ALI_PAY_RESULT object:ALIPAY_SUCCESSED];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failPayment) name:ALI_PAY_RESULT object:ALIPAY_FAILED];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:WX_PAY_RESULT object:IS_SUCCESSED];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failPayment) name:WX_PAY_RESULT object:IS_FAILED];
}

- (void)failPayment
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"支付失败";
    [hud hide:YES afterDelay:1.5];
}

- (void)backAction
{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出支付？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    WS(weakSelf);
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认取消支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
    [alertControl addAction:cancelAction];
    [alertControl addAction:sureAction];
    [self presentViewController:alertControl animated:YES completion:nil];
}

- (void)paySuccess
{
    switch (_type) {
        case YYPayDealViewControllerTypeBuy:
        {
            YYPaySuccessViewController *successVC = [[YYPaySuccessViewController alloc] init];
            [self.navigationController pushViewController:successVC animated:YES];
        }
            break;
        case YYPayDealViewControllerTypeSubscribe:
        {
            YYSubscribeSuccessViewController *successVC = [YYSubscribeSuccessViewController new];
            [self.navigationController pushViewController:successVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - YYPayDealViewDelegate

- (void)executePayDeal:(YYPayType)payType
{
    
    switch (payType) {
        case YYPayTypeAlipay:
        {
            [YYPayMentHandle executePayUseAliPayWithOrderId:_dealModel.payOrderNumber totalMoney:@"0.01" payTitle:@"测试订单" Success:^(id obj) {
                
            } failed:^(id failed) {
                
            }];
            
        }
            break;
        case YYPayTypeWeixinPay:
        {
            MBProgressHUD *hud = [self showHudProgress];
            
            [YYPayMentHandle executeDeal:_dealModel.orderPayId body:@"衣服" price:@"0.01" success:^(id obj) {
                [hud hide:YES];
                YYWXPayModel *model = obj;
                [YYPayMentHandle executePayUseWeChatPayWithPrepay_id:model.prepayid nonce_str:model.noncestr Success:^(id obj) {
                    
                } failed:^(id failed) {
                    
                }];
            } failed:^(id failed) {
                [self showMessage:failed hud:hud duration:1.2];
            }];
            
        }
            break;
        default:
            break;
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
