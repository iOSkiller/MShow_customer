//
//  YYMineCertifyViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/17.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineCertifyViewController.h"
#import "YYMineCertifyView.h"

@interface YYMineCertifyViewController () <YYMineCertifyViewDelegate>
@property (nonatomic, weak) YYMineCertifyView *certifyView;

@end

@implementation YYMineCertifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    self.view.backgroundColor = [UIColor whiteColor];
    YYMineCertifyView *view = [[YYMineCertifyView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight)];
    view.delegate = self;
    [self.view addSubview:view];
    _certifyView = view;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:YYHideKeyboardNotification object:nil];
}

#pragma mark - YYMineCertifyViewDelegate
- (void)executeCeritfyAction:(NSString *)name code:(NSString *)code
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
