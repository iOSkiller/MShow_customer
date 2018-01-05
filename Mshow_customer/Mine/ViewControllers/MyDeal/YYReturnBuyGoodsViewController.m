//
//  YYReturnBuyGoodsViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/19.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYReturnBuyGoodsViewController.h"
#import "YYReturnGoodsView.h"
#import "YYDealModel.h"
#import "YYSubscribeReturnGoodsViewController.h"
#import "YYPaySuccessViewController.h"

@interface YYReturnBuyGoodsViewController () <YYReturnGoodsViewDelegate>
@property (nonatomic, weak) YYReturnGoodsView *returnGoodsView;

@end

@implementation YYReturnBuyGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (_type) {
        case YYMineFunctionTypeBuy:
            self.title = @"选择要购买的衣服";
            break;
        case YYMineFunctionTypeReturn:
        case YYMineFunctionTypeReturnBySelf:
            self.title = @"选择归还的衣服";
            break;
        default:
            break;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    YYReturnGoodsView *view = [[YYReturnGoodsView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.delegate = self;
    view.goodsArray = _dealModel.goodsArray;
    [self.view addSubview:view];
    _returnGoodsView = view;
}

#pragma mark - YYReturnGoodsViewDelegate
- (void)executeSureAction:(NSArray *)selectedGoodsArray
{
    switch (_type) {
        case YYMineFunctionTypeReturnBySelf:
        case YYMineFunctionTypeReturn:
        {
            YYSubscribeReturnGoodsViewController *subscribeVC = [YYSubscribeReturnGoodsViewController new];
            subscribeVC.type = _type;
            [self.navigationController pushViewController:subscribeVC animated:YES];
        }
            break;
        case YYMineFunctionTypeBuy:
        {
            YYPaySuccessViewController *paySuccessVC = [YYPaySuccessViewController new];
            [self.navigationController pushViewController:paySuccessVC animated:YES];
        }
            break;
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
