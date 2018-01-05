//
//  YYMineAddressEditeViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineAddressEditeViewController.h"
#import "YYAddressModel.h"
#import "YYMineAddressEditeView.h"

@interface YYMineAddressEditeViewController ()
@property (nonatomic, weak) YYMineAddressEditeView *editeView;

@end

@implementation YYMineAddressEditeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YYSeparatorColor;
    YYMineAddressEditeView *editeView = [[YYMineAddressEditeView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    [self.view addSubview:editeView];
    _editeView = editeView;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:YYHideKeyboardNotification object:nil];
}

- (void)setType:(YYMineAddressEditeViewType)type
{
    _type = type;
    if (_type == YYMineAddressEditeViewTypeEdite) {
        [self setUpRightItem:@"删除" selectedTitle:nil image:@"" highImage:@"" target:self action:@selector(deleteAction)];
        self.title = @"编辑地址";
    } else {
        self.title = @"新增地址";
    }
}

- (void)deleteAction
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
