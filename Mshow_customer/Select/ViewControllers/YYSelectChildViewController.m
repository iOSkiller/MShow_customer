//
//  YYSelectChildViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectChildViewController.h"
#import "YYSelectGenderView.h"
#import "YYSelectGenderTableView.h"
#import "YYSelectShopView.h"
#import "YYSelectSceneView.h"
#import "YYSelectBrandView.h"
#import "YYSelectTypeView.h"
#import "YYSelectTypeSelectionView.h"
#import "YYGoodsModel.h"
#import "YYBrandModel.h"
#import "YYShopModel.h"
#import "YYSceneModel.h"
#import "YYTypeSelectionModel.h"

#import "YYGoodsDetailViewController.h"
#import "YYShopDetailViewController.h"

#import "YYHomeDateHandle.h"

@interface YYSelectChildViewController () <YYSelectGenderViewDelegate, YYSelectShopViewDelegate, YYSelectSceneViewDelegate, YYSelectBrandViewDelegate, YYSelectTypeViewDelegate, YYSelectGenderTableViewDelegate>
@property (nonatomic, weak) YYSelectGenderView *genderCollectionView;
@property (nonatomic, weak) YYSelectGenderTableView *genderTableView;
@property (nonatomic, weak) YYSelectShopView *shopView;
@property (nonatomic, weak) YYSelectSceneView *sceneView;
@property (nonatomic, weak) YYSelectBrandView *brandView;
@property (nonatomic, weak) YYSelectTypeView *selectView;
@property (nonatomic, weak) YYSelectTypeSelectionView *selectionView;

@end

@implementation YYSelectChildViewController

{
    NSInteger _pageNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    _pageNum = 0;
    
    
    
}

- (void)fetchData
{
    switch (_dataType) {
        case YYSelectChildViewDataTypeHot:
        {
            [YYHomeDateHandle executeGetNewGoods:@"1" pageSize:@"10" success:^(id obj) {
                self.genderTableView.goodsArray = obj;
                self.genderCollectionView.dataArray = obj;
            } failed:^(id failed) {
                [self showMessage:@"请稍后再试" hud:nil duration:1.2];
                [self.genderCollectionView endRefresh];
                [self.genderTableView endRefresh];
            }];
        }
            break;
        case YYSelectChildViewDataTypeNew:
        {
            [YYHomeDateHandle executeGetHotGoods:@"1" pageSize:@"10" success:^(id obj) {
                self.genderTableView.goodsArray = obj;
                self.genderCollectionView.dataArray = obj;
            } failed:^(id failed) {
                [self showMessage:@"请稍后再试" hud:nil duration:1.2];
                [self.genderCollectionView endRefresh];
                [self.genderTableView endRefresh];
            }];
        }
            break;
        case YYSelectChildViewDataTypeTry:
        {
            [self.genderCollectionView endRefresh];
            [self.genderTableView endRefresh];
        }
            break;
        default:
            break;
    }
}

- (void)setIsTableView:(BOOL)isTableView
{
    self.genderTableView.hidden = !isTableView;
    self.genderCollectionView.hidden = isTableView;
}


- (void)createUI
{
    switch (_type) {
        case YYSelectChildViewTypeMan:
        case YYSelectChildViewTypeWomen:
        case YYSelectChildViewTypeChild:
        {
            YYSelectGenderView *genderCollectionView = [[YYSelectGenderView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(80), WIN_WIDTH, WIN_HEIGHT - RELATIVE_WIDTH(160) - iPhone_ProtraitDisableViewHeight - (_isFullScreen ? 0 : iPhone_Tabbar_Height))];
            genderCollectionView.delegate = self;
            
            YYSelectGenderTableView *genderTableView = [[YYSelectGenderTableView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(80), WIN_WIDTH, WIN_HEIGHT - RELATIVE_WIDTH(160) - iPhone_ProtraitDisableViewHeight - (_isFullScreen ? 0 : iPhone_Tabbar_Height))];
            genderTableView.delegate = self;
            if (_type == YYSelectChildViewTypeMan) {
                
                genderCollectionView.dataArray = [YYGoodsModel testManArray];
                genderTableView.goodsArray = [YYGoodsModel testManArray];
            }
            if (_type == YYSelectChildViewTypeWomen) {
                genderCollectionView.dataArray = [YYGoodsModel testWomanArray];
                genderTableView.goodsArray = [YYGoodsModel testWomanArray];
            }
            
            if (_type == YYSelectChildViewTypeChild) {
                genderCollectionView.dataArray = [YYGoodsModel testChildArray];
                genderTableView.goodsArray = [YYGoodsModel testChildArray];
            }
            [self.view addSubview:genderCollectionView];
            [self.view addSubview:genderTableView];
            _genderCollectionView = genderCollectionView;
            _genderTableView = genderTableView;
            _genderTableView.hidden = YES;
            
            YYSelectTypeView *selectView = [[YYSelectTypeView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(84)) selections:@[@"分类", @"尺寸", @"风格", @"更多"]];
            selectView.delegate = self;
            [self.view addSubview:selectView];
            _selectView = selectView;
            
            YYSelectTypeSelectionView *view = [[YYSelectTypeSelectionView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(84), self.view.mj_w, RELATIVE_WIDTH(408))];
            view.hidden = YES;
            [self.view addSubview:view];
            _selectionView = view;
            WS(weakSelf);
            self.selectionView.sureBlock = ^(YYTypeSelectionModel *model) {
                StrongSelf(strongSelf);
                strongSelf = weakSelf;
                [strongSelf.selectView refresh];
            };
            
            self.selectionView.resetBlock = ^{
                
            };
            [self.view insertSubview:self.selectView aboveSubview:self.selectionView];
            break;
        }
            
        case YYSelectChildViewTypeShop:
        {
            YYSelectShopView *shopView = [[YYSelectShopView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - (_isFullScreen ? (iPhone_ProtraitDisableViewHeight + RELATIVE_WIDTH(80)) : (RELATIVE_WIDTH(80) + iPhone_ProtraitDisableViewHeight + iPhone_Tabbar_Height)))];
            shopView.delegate = self;
            NSMutableArray *dataArray = [NSMutableArray arrayWithArray:[YYShopModel testDataArray]];
            [dataArray addObjectsFromArray:[YYShopModel testDataArray]];
            shopView.dataArray = [dataArray copy];
            [self.view addSubview:shopView];
            _shopView = shopView;
            break;
        }
        case YYSelectChildViewTypeBrand:
        {
            YYSelectBrandView *brandView = [[YYSelectBrandView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - RELATIVE_WIDTH(80) - iPhone_ProtraitDisableViewHeight - iPhone_Tabbar_Height) indexArray:@[]];
            brandView.delegate = self;
            [self.view addSubview:brandView];
            _brandView = brandView;
            break;
        }
        case YYSelectChildViewTypeScene:
        {
            YYSelectSceneView *scenceView = [[YYSelectSceneView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - RELATIVE_WIDTH(80) - iPhone_ProtraitDisableViewHeight - iPhone_Tabbar_Height)];
            scenceView.delegate = self;
            [self.view addSubview:scenceView];
            _sceneView = scenceView;
            break;
        }
        default:
            break;
    }
}


#pragma mark - YYSelectGenderViewDelegate
- (void)executeLikeGoods:(YYGoodsModel *)goodsModel isLike:(BOOL)isLike
{
    MJExtensionLog(@"follow %@", isLike ? @"yes" : @"no");
}

- (void)collectionViewLoadMoreData
{
    _pageNum ++;
    [self fetchData];
}

- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel
{
    MJExtensionLog(@"show detail: %@", goodsModel.goodsID);
    [self showGoodsDetail:goodsModel.goodsID];
}

- (void)collectionViewDidScrollToIndex:(NSUInteger)index
{
    [self.genderTableView scrollToIndex:index];
}

#pragma mark - YYSelectGenderTableViewDelegate
- (void)selectGenderTableView:(YYSelectGenderTableView *)tableView showGoodsDetail:(YYGoodsModel *)goodsModel
{
    [self showGoodsDetail:goodsModel.goodsID];
}

- (void)selectGenderTableView:(YYSelectGenderTableView *)tableView showShopDetail:(NSString *)shopID
{
    [self showShopDetail:@""];
}

- (void)tableViewDidScrollToIndex:(NSUInteger)index
{
    [self.genderCollectionView scrollToIndex:index];
}

- (void)tableViewLoadMoreData
{
    _pageNum ++;
    [self fetchData];
}

#pragma mark - YYSelectShopViewDelegate
- (void)executeGotoShop:(YYShopModel *)shopModel
{
    MJExtensionLog(@"%@", shopModel);
    [self showShopDetail:shopModel.shop_id];
}

- (void)executeShowGoods:(YYGoodsModel *)goodsModel
{
    MJExtensionLog(@"%@", goodsModel.goodsID);
    [self showGoodsDetail:goodsModel.goodsID];
}

#pragma mark - YYSelectSceneViewDelegate
- (void)executeShowScene:(YYSceneModel *)sceneModel
{
    MJExtensionLog(@"%@", sceneModel);
}

#pragma mark - YYSelectBrandViewDelegate
- (void)executeShowBrandDetail:(YYBrandModel *)brandModel
{
    MJExtensionLog(@"%@", brandModel);
}

- (void)executeShowHotBrandDetail:(YYBrandModel *)brandModel
{
    MJExtensionLog(@"%@", brandModel);
}


#pragma mark - YYSelectTypeViewDelegate
- (void)shouldShowSelectionView:(BOOL)show index:(NSInteger)index
{
    if (show) {
        switch (index) {
            case 400:
                self.selectionView.selectionArray = [YYTypeSelectionModel testCategoryDataArray];
                break;
            case 401:
                self.selectionView.selectionArray = [YYTypeSelectionModel testSizeDataArray];
                break;
            case 402:
                self.selectionView.selectionArray = [YYTypeSelectionModel testTypeDataArray];
                break;
            case 403:
                self.selectionView.selectionArray = [YYTypeSelectionModel testMoreDataArray];
                break;
        }
    }
    show ? [self.selectionView show] : [self.selectionView hide];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
