//
//  YYSelectViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectViewController.h"
#import "YYSearchBar.h"
#import "YYSelectChildViewController.h"

@interface YYSelectViewController ()
@property (nonatomic, weak) YYSearchBar *searchBar;

@end

@implementation YYSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_searchText) {
        self.searchBar.text = _searchText;
    }
}

- (void)createUI
{
    YYSearchBar *searchBar = [[YYSearchBar alloc] init];
    searchBar.isFull = !_hideToobBar;
    searchBar.type = YYSearchBarTypeLabel;
    searchBar.frame = CGRectMake(0, 0, WIN_WIDTH - (_hideToobBar ? 88 : 0) - RELATIVE_WIDTH(40), RELATIVE_WIDTH(60));
    searchBar.backgroundColor = mRGBToColor(0xfafafa);
    searchBar.layer.cornerRadius = RELATIVE_WIDTH(30);
    searchBar.layer.borderWidth = RELATIVE_WIDTH(1);
    searchBar.layer.borderColor = mRGBToColor(0xeeeeee).CGColor;
    searchBar.layer.masksToBounds = YES;
    //搜索操作
    WS(weakSelf);
    searchBar.showSearchViewBlock = ^(void) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [strongSelf showSearchViewController];
    };
    _searchBar = searchBar;
    
    self.navigationItem.titleView.userInteractionEnabled = YES;
    self.navigationItem.titleView = _searchBar;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"img_table"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"img_collection"] forState:UIControlStateSelected];
    rightBtn.backgroundColor = [UIColor whiteColor];
    rightBtn.frame = CGRectMake(0, 0, RELATIVE_WIDTH(64), RELATIVE_WIDTH(44));
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, RELATIVE_WIDTH(20), 0, 0);
    [rightBtn addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
    
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
}


- (void)setUpAllViewController
{
    YYSelectChildViewController *womenVC = [[YYSelectChildViewController alloc] init];
    womenVC.type = YYSelectChildViewTypeWomen;
    womenVC.isFullScreen = _hideToobBar;
    womenVC.title = @"女装";
    [self addChildViewController:womenVC];
    
    YYSelectChildViewController *manVC = [[YYSelectChildViewController alloc] init];
    manVC.type = YYSelectChildViewTypeMan;
    manVC.isFullScreen = _hideToobBar;
    manVC.title = @"男装";
    [self addChildViewController:manVC];
    
    YYSelectChildViewController *childVC = [[YYSelectChildViewController alloc] init];
    childVC.type = YYSelectChildViewTypeChild;
    childVC.isFullScreen = _hideToobBar;
    childVC.title = @"童装";
    [self addChildViewController:childVC];
    
    YYSelectChildViewController *shopVC = [[YYSelectChildViewController alloc] init];
    shopVC.type = YYSelectChildViewTypeShop;
    shopVC.isFullScreen = _hideToobBar;
    shopVC.title = @"店铺";
    [self addChildViewController:shopVC];
    
//    YYSelectChildViewController *brandVC = [[YYSelectChildViewController alloc] init];
//    brandVC.type = YYSelectChildViewTypeBrand;
//    brandVC.isFullScreen = _hideToobBar;
//    brandVC.title = @"品牌";
//    [self addChildViewController:brandVC];
    
    YYSelectChildViewController *sceneVC = [[YYSelectChildViewController alloc] init];
    sceneVC.type = YYSelectChildViewTypeScene;
    sceneVC.isFullScreen = _hideToobBar;
    sceneVC.title = @"场景";
    [self addChildViewController:sceneVC];
    
}

- (void)changeType:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (self.currentIndex <= 2) {
        YYSelectChildViewController *vc = (YYSelectChildViewController *)self.childViewControllers[self.currentIndex];
        vc.isTableView = sender.isSelected;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
