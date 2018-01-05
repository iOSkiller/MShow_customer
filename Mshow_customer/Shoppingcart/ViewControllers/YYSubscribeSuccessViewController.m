//
//  YYSubscribeSuccessViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSubscribeSuccessViewController.h"
#import "YYSubscribeSuccessView.h"
#import "YYGussessLikeView.h"
#import "YYDealModel.h"
#import "YYGoodsModel.h"
#import "YYGoodsDetailViewController.h"
#import "YYDealDetailViewController.h"
#import "YYWashServiceViewController.h"
#import "YYMyWardrobeViewController.h"
#import "YYReturnChangeDealViewController.h"
#import "YYDealViewController.h"

@interface YYSubscribeSuccessViewController ()
@property (nonatomic, weak) YYSubscribeSuccessView *successView;
@property (nonatomic, weak) YYGussessLikeView *gussessView;
@property (nonatomic, weak) UIScrollView *containerView;

@end

@implementation YYSubscribeSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _type == YYSubscribeSuccessViewTypeChangeReturnGoods ? @"申请成功" : @"预约成功";
    self.fd_interactivePopDisabled = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    scrollView.backgroundColor = YYSeparatorColor;
    scrollView.contentSize = CGSizeMake(0, RELATIVE_WIDTH(436) + RELATIVE_WIDTH(1760));
    [self.view addSubview:scrollView];
    _containerView = scrollView;
    YYSubscribeSuccessView *successView = [[YYSubscribeSuccessView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(436)) type:_type];
    WS(weakSelf);
    successView.backActionBlock = ^{
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        strongSelf.tabBarController.selectedIndex = 0;
        [strongSelf.navigationController popToRootViewControllerAnimated:NO];
    };
    successView.dealActionBlock = ^{
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        switch (_type) {
            case YYSubscribeSuccessViewTypeWash:
            {
                YYDealDetailViewController *dealDetailVC = [YYDealDetailViewController new];
                YYDealModel *model = [YYDealModel testDeal];
                model.statusType = YYDealStatusTypeWaitForTakeOrder;
                dealDetailVC.dealModel = model;
                [strongSelf.navigationController pushViewController:dealDetailVC animated:YES];
            }
                break;
            case YYSubscribeSuccessViewTypeChangeReturnGoods:
            {
                YYReturnChangeDealViewController *returnDealVC = [YYReturnChangeDealViewController new];
                [strongSelf.navigationController pushViewController:returnDealVC animated:YES];
            }
                break;
            case YYSubscribeSuccessViewTypeReturnGoods:
                break;
            case YYSubscribeSuccessViewTypeReturnGoodsBySelf:
                break;
                break;
            default:
                break;
        }
    };
    [self.containerView addSubview:successView];
    _successView = successView;
    
    YYGussessLikeView *gussessView = [[YYGussessLikeView alloc] initWithFrame:CGRectMake(0, _successView.mj_h + _successView.mj_y + RELATIVE_WIDTH(10), WIN_WIDTH, RELATIVE_WIDTH(1750))];
    gussessView.likeGoodsArray = [YYGoodsModel testWomanArray];
    gussessView.showGoodsBlock = ^(YYGoodsModel *goodsModel) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf.navigationController pushViewController:[YYGoodsDetailViewController new] animated:YES];
    };
    [self.containerView addSubview:gussessView];
    _gussessView = gussessView;
    
    [self setUpLeftItem:nil selectedTitle:nil image:@"img_arrow_left" highImage:@"img_arrow_left" target:self action:@selector(backAction)];
    
}

- (void)backAction
{
    switch (_type) {
        case YYSubscribeSuccessViewTypeChangeReturnGoods:
        case YYSubscribeSuccessViewTypeReturnGoods:
        case YYSubscribeSuccessViewTypeReturnGoodsBySelf:
        {
            for (UIViewController *vc in self.navigationController.childViewControllers) {
                if ([vc isKindOfClass:[YYMyWardrobeViewController class]] ||
                    [vc isKindOfClass:[YYDealViewController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                    break;
                }
            }
            
        }
            
            break;
        case YYSubscribeSuccessViewTypeWash:
        {
            for (UIViewController *vc in self.navigationController.childViewControllers) {
                if ([vc isKindOfClass:[YYWashServiceViewController class]] ||
                    [vc isKindOfClass:[YYDealViewController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                    break;
                }
            }
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
