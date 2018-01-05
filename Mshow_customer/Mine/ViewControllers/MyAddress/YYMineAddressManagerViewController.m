//
//  YYMineAddressManagerViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/16.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineAddressManagerViewController.h"
#import "YYMineAddressManagerView.h"
#import "YYAddressModel.h"
#import "YYMineAddressEditeViewController.h"

@interface YYMineAddressManagerViewController () <YYMineAddressManagerViewDelegate>
@property (nonatomic, weak) YYMineAddressManagerView *managerView;

@end

@implementation YYMineAddressManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址管理";
    self.view.backgroundColor = [UIColor whiteColor];
    YYMineAddressManagerView *managerView = [[YYMineAddressManagerView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    managerView.delegate = self;
    [self.view addSubview:managerView];
    _managerView = managerView;
    self.managerView.dataArray = [YYAddressModel testDataArray];
    
}

#pragma mark - YYMineAddressManagerViewDelegate
- (void)executeAddAddress
{
    YYMineAddressEditeViewController *addVC = [[YYMineAddressEditeViewController alloc] init];
    addVC.type = YYMineAddressEditeViewTypeAdd;
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)executeChageDefaultAddress:(YYAddressModel *)addressModel
{
    
}

- (void)executeDeleteAddress:(YYAddressModel *)addressModel
{
    
}

- (void)executeSelectAddress:(YYAddressModel *)addressModel
{
    if (_didSelectAddressBlock) {
        _didSelectAddressBlock(addressModel);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)executeEditeAddress:(YYAddressModel *)addressModel
{
    YYMineAddressEditeViewController *editeVC = [[YYMineAddressEditeViewController alloc] init];
    editeVC.type = YYMineAddressEditeViewTypeEdite;
    [self.navigationController pushViewController:editeVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
