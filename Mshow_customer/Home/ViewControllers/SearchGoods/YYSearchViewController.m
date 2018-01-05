//
//  YYSearchViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSearchViewController.h"
#import "YYSearchBar.h"
#import "YYSearchChildViewController.h"
#import "YZDisplayViewHeader.h"
#import "YYSelectViewController.h"

@interface YYSearchViewController ()
@property (nonatomic, weak) YYSearchBar *searchBar;

@end

@implementation YYSearchViewController

{
    NSString *_searchText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClickSelection) name:YZDisplayViewClickOrScrollDidFinshNote object:nil];
}

- (void)didClickSelection
{
    self.searchBar.textField.text = @"";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.searchBar) {
        self.searchBar.textField.text = _searchText;
    }
}

- (void)createUI
{
    YYSearchBar *searchBar = [[YYSearchBar alloc] init];
    searchBar.isFull = YES;
    searchBar.backgroundColor = mRGBToColor(0xfafafa);
    searchBar.type = YYSearchBarTypeTextField;
    searchBar.frame = CGRectMake(0, 0, WIN_WIDTH - RELATIVE_WIDTH(40), RELATIVE_WIDTH(60));
    searchBar.layer.cornerRadius = RELATIVE_WIDTH(30);
    searchBar.layer.borderWidth = RELATIVE_WIDTH(1);
    searchBar.layer.borderColor = mRGBToColor(0xeeeeee).CGColor;
    searchBar.layer.masksToBounds = YES;
    searchBar.endEdite = ^(NSString *text) {
        _searchText = text;
        if ([text isValid]) {
            YYSelectViewController *selectVC = [YYSelectViewController new];
            selectVC.searchText = text;
            [self.navigationController pushViewController:selectVC animated:YES];
        }
    };
    searchBar.didChangeTextBlock = ^(NSString *text) {
        YYSearchChildViewController *searchVC = (YYSearchChildViewController *)self.childViewControllers[self.currentIndex];
        searchVC.text = text;
    };
    _searchBar = searchBar;
    
    self.navigationItem.titleView.userInteractionEnabled = YES;
    self.navigationItem.titleView = _searchBar;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightBtn setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(28)];
    rightBtn.backgroundColor = [UIColor whiteColor];
    rightBtn.frame = CGRectMake(0, 0, RELATIVE_WIDTH(88), RELATIVE_WIDTH(44));
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, RELATIVE_WIDTH(20), 0, 0);
    [rightBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.isfullScreen = NO;
    self.scrollEnable = NO;
    //设置选项属性
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *norColor = YYTextColor;
        *selColor = mRGBToColor(0xf46060);
        *titleFont = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        *titleHeight = RELATIVE_WIDTH(80);
    }];
    
    //设置下划线
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor, BOOL *isUnderLineEqualTitleWidth) {
        *isUnderLineDelayScroll = NO;
        *isUnderLineEqualTitleWidth = YES;
        *underLineH = RELATIVE_WIDTH(2);
        *underLineColor = YYGlobalColor;
    }];
    
    [self setUpAllViewController];
    [self.searchBar.textField becomeFirstResponder];
}

- (void)cancelAction
{
    [self.searchBar.textField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setUpAllViewController
{
    YYSearchChildViewController *goodsSearchVC = [YYSearchChildViewController new];
    goodsSearchVC.title = @"商品";
    [self addChildViewController:goodsSearchVC];

    YYSearchChildViewController *shopSearchVC = [YYSearchChildViewController new];
    shopSearchVC.title = @"店铺";
    [self addChildViewController:shopSearchVC];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YZDisplayViewClickOrScrollDidFinshNote object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
