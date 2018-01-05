//
//  YYShowChildViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/1.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShowChildViewController.h"
#import "YYShowView.h"
#import "YYShowModel.h"

@interface YYShowChildViewController () <YYShowViewDelegate>
@property (nonatomic, weak) YYShowView *showView;
@end

@implementation YYShowChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YYShowView *view = [[YYShowView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_Tabbar_Height - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(60))];
    view.delegate = self;
    [self.view addSubview:view];
    _showView = view;
    
    self.showView.dataArray = [YYShowModel testArray];
}

#pragma mark - YYShowViewDelegate
- (void)executeFunction:(YYShowViewFunctionType)type showModel:(YYShowModel *)showModel
{
    MJExtensionLog(@"%ld%@", (long)type, showModel);
}

- (void)executeShowDetailImage:(NSArray *)imageURLS index:(NSInteger)index
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
