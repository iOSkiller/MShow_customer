//
//  YYSearchWashShopViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/2.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSearchWashShopViewController.h"
#import "YYSearchShopView.h"
#import "YYSearchBar.h"
#import "YYShowModel.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationManager.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "YYUserLocationAnnotation.h"

@interface YYSearchWashShopViewController () <YYSearchShopViewDelegate, MAMapViewDelegate, AMapLocationManagerDelegate>
@property (nonatomic, weak) YYSearchShopView *searchShopView;
@property (nonatomic, weak) YYSearchBar *searchBar;
@property (nonatomic, weak) UIButton *locateButton;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;

@end

@implementation YYSearchWashShopViewController

- (AMapLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
}

- (void)setUpView
{
    YYSearchShopView *searchShopView = [[YYSearchShopView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(500), WIN_WIDTH, WIN_HEIGHT - RELATIVE_WIDTH(500) - iPhone_ProtraitDisableViewHeight)];
    searchShopView.delegate = self;
    [self.view addSubview:searchShopView];
    _searchShopView = searchShopView;
    
    YYSearchBar *searchBar = [[YYSearchBar alloc] init];
    searchBar.isFull = YES;
    searchBar.backgroundColor = mRGBToColor(0xfafafa);
    searchBar.type = YYSearchBarTypeTextField;
    searchBar.frame = CGRectMake(0, 0, WIN_WIDTH - RELATIVE_WIDTH(40), RELATIVE_WIDTH(60));
    searchBar.layer.cornerRadius = RELATIVE_WIDTH(30);
    searchBar.layer.borderWidth = RELATIVE_WIDTH(1);
    searchBar.layer.borderColor = mRGBToColor(0xeeeeee).CGColor;
    searchBar.layer.masksToBounds = YES;
    searchBar.textField.text = @"干洗店";
    self.navigationItem.titleView = searchBar;
    _searchBar = searchBar;
    
    ///初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(500))];
    self.mapView.delegate = self;
    ///把地图添加至view
    [self.view addSubview:self.mapView];
    
    //隐藏指南针
    self.mapView.showsCompass = NO;
    //隐藏比例尺
    self.mapView.showsScale = NO;
    //关闭地图旋转功能
    self.mapView.rotateEnabled = NO;
    self.mapView.rotateCameraEnabled = NO;
    //设定地图缩放比例
    [self.mapView setZoomLevel:18 animated:YES];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    self.mapView.userInteractionEnabled = YES;
    self.mapView.logoCenter = CGPointMake(CGRectGetWidth(self.view.bounds)-55, 450);
    UIButton *locateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [locateButton setImage:[UIImage imageNamed:@"img_map"] forState:UIControlStateNormal];
    [locateButton addTarget:self action:@selector(locateAction) forControlEvents:UIControlEventTouchUpInside];
    locateButton.backgroundColor = [UIColor clearColor];
    locateButton.frame = CGRectMake(WIN_WIDTH - RELATIVE_WIDTH(70) - RELATIVE_WIDTH(42), RELATIVE_WIDTH(390), RELATIVE_WIDTH(70), RELATIVE_WIDTH(70));
    [self.mapView addSubview:locateButton];
    _locateButton = locateButton;
    
    [self locateAction];
    
    YYUserLocationAnnotation *localPoint = [[YYUserLocationAnnotation alloc] init];
    [self.mapView updateUserLocationRepresentation:localPoint];
    
    WS(ws);
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(ws.view);
        make.height.mas_equalTo(RELATIVE_WIDTH(500));
    }];
    
    [self.searchShopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(ws.view);
        make.top.equalTo(self.mapView.mas_bottom);
    }];
    
    [self.locateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.view).offset(-RELATIVE_WIDTH(42));
        make.width.height.mas_equalTo(RELATIVE_WIDTH(70));
        make.bottom.equalTo(self.searchShopView.mas_top).offset(-RELATIVE_WIDTH(36));
    }];
}

- (void)locateAction
{

}

#pragma mark - YYSearchShopViewDelegate
- (void)executeDidSelectShop:(YYShopModel *)shopModel
{
    if (_didSelectWashShopBlock) {
        _didSelectWashShopBlock(shopModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
