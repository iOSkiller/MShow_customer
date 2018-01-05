//
//  YYShoppingcartViewController.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/23.
//  Copyright © 2017年 YYZ. All rights reserved.
//


#import "YYShoppingcartViewController.h"
#import "YYShoppingCartView.h"
#import "YYCartAccountView.h"
#import "YYShoppingCartEditingBar.h"
#import "YYGoodsModel.h"
#import "YYShopModel.h"
#import "YYSettleDealViewController.h"

#define cartViewHeight RELATIVE_WIDTH(100)

@interface YYShoppingcartViewController () <YYCartAccountViewDelegate, YYShoppingCartViewDelegate>
@property (nonatomic, weak) YYShoppingCartView *contentView;
@property (nonatomic, weak) YYCartAccountView *cartView;
@property (nonatomic, weak) YYShoppingCartEditingBar *editingBar;

@property (nonatomic, strong) NSMutableArray *selectedGoodsArr;
@property (nonatomic, strong) NSMutableArray *cartGoodsArr;
/**编辑状态下，用于备份选中的商品ID的数组*/
@property (nonatomic, strong) NSMutableArray <NSString *> *editeGoodsArray;

@end

@implementation YYShoppingcartViewController

{
    UIImageView *_line;
    BOOL _isAllSelected;
    BOOL _isEditing;
}

- (NSMutableArray *)cartGoodsArr {
    if (!_cartGoodsArr) {
        _cartGoodsArr = [NSMutableArray array];
    }
    return _cartGoodsArr;
}

- (NSMutableArray *)selectedGoodsArr {
    if (!_selectedGoodsArr) {
        _selectedGoodsArr = [NSMutableArray array];
    }
    return _selectedGoodsArr;
}

- (NSMutableArray <NSString *> *)editeGoodsArray {
    if (!_editeGoodsArray) {
        _editeGoodsArray = [NSMutableArray array];
    }
    return _editeGoodsArray;
}

- (YYShoppingCartEditingBar *)editingBar {
    if (!_editingBar) {
        YYShoppingCartEditingBar *bar = [[YYShoppingCartEditingBar alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(80))];
        [self.view addSubview:bar];
        _editingBar = bar;
    }
    return _editingBar;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"衣橱";
    [self setUpRightItem:@"管理" selectedTitle:@"完成" image:@"" highImage:@"" target:self action:@selector(editeAction:)];
    
    [self editingBar];
    
    YYShoppingCartView *view = [[YYShoppingCartView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - (self.tabBarController.tabBar.hidden ? 0 : iPhone_Tabbar_Height) - cartViewHeight)];
    view.delegate = self;
    [self.view addSubview:view];
    _contentView = view;
    _contentView.dataArray = @[];
    
    YYCartAccountView *cartView = [[YYCartAccountView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, cartViewHeight)];
    cartView.delegate = self;
    [self.view addSubview:cartView];
    _cartView = cartView;
    
    _line = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    WS(ws);
    [self.cartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view).offset(self.tabBarController.tabBar.hidden ? iPhone_MARGIN_BOTTOM: -iPhone_Tabbar_Height);
        make.left.right.equalTo(ws.view);
        make.height.mas_equalTo(cartViewHeight);
    }];
    
    self.cartView.totalPrice = @"200.00";
    [self.cartGoodsArr addObjectsFromArray:[YYShopModel testDataArray]];
    self.contentView.dataArray = [YYShopModel testDataArray];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _line.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _line.hidden = NO;
}

- (void)editeAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    self.cartView.isEditing = sender.isSelected;
    self.editingBar.hidden = !sender.isSelected;
    WS(ws);
    [self.editingBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(ws.view);
        make.height.mas_equalTo(RELATIVE_WIDTH(80));
        self.editingBar.hidden ? make.bottom.equalTo(ws.view.mas_top) : make.top.equalTo(ws.view);
    }];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(self.cartView);
        make.top.equalTo(self.editingBar.mas_bottom);
    }];
}

#pragma mark - YYCartAccountViewDelegate
- (void)executeAllSelected:(BOOL)isAllSelected
{
    _isAllSelected = isAllSelected;
    for (YYShopModel *shopModel in self.cartGoodsArr) {
        shopModel.isSelected = isAllSelected;
        for (YYGoodsModel *goodsModel in shopModel.goodsArray) {
            goodsModel.isSelected = isAllSelected;
        }
    }
    self.contentView.dataArray = self.cartGoodsArr;
}

- (void)executePay
{
    YYSettleDealViewController *settleVC = [[YYSettleDealViewController alloc] init];
    [self.navigationController pushViewController:settleVC animated:YES];
}

#pragma mark - YYShoppingCartViewDelegate
- (void)shouldChangeShop:(YYShopModel *)shopModel indexPath:(NSIndexPath *)indexPath
{
    for (YYGoodsModel *model in shopModel.goodsArray) {
        model.isSelected = shopModel.isSelected;
    }
    [self.cartGoodsArr replaceObjectAtIndex:indexPath.section withObject:shopModel];
    [self.contentView reloadSection:indexPath];
}

- (void)shouldChangeGoods:(YYGoodsModel *)goodsModel indexPath:(NSIndexPath *)indexPath
{
    YYShopModel *shopModel = self.cartGoodsArr[indexPath.section];
    for (YYGoodsModel *model in shopModel.goodsArray) {
        if ([model.goodsID isEqualToString:goodsModel.goodsID]) {
            model.isSelected = goodsModel.isSelected;
            if (model.isSelected) {
                shopModel.selectedCount ++;
            } else {
                shopModel.selectedCount --;
            }
            shopModel.isSelected = shopModel.selectedCount == shopModel.goodsArray.count;
            break;
        }
    }
    
    [self.contentView reloadSection:indexPath];
}

- (void)shouldRemoveGoods:(YYGoodsModel *)goodsModel indexPath:(NSIndexPath *)indexPath
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除该商品" preferredStyle:UIAlertControllerStyleAlert];
    
    WS(weakSelf);
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        YYShopModel *shopModel = strongSelf.cartGoodsArr[indexPath.section];
        NSMutableArray *array = [NSMutableArray arrayWithArray:shopModel.goodsArray];
        [array removeObjectAtIndex:indexPath.row - 1];
        if (array.count) {
            shopModel.goodsArray = array;
            [strongSelf.cartGoodsArr replaceObjectAtIndex:indexPath.section withObject:shopModel];
            [strongSelf.contentView reloadSection:indexPath];
        } else {
            [strongSelf.cartGoodsArr removeObjectAtIndex:indexPath.section];
            strongSelf.contentView.dataArray = strongSelf.cartGoodsArr;
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)executeShowCoupons:(YYShopModel *)shopModel indexPath:(NSIndexPath *)indexPath
{
    MJExtensionLog(@"%@", shopModel);
}

- (void)executeShowShopDetail:(YYShopModel *)shopModel indexPath:(NSIndexPath *)indexPath
{
    MJExtensionLog(@"%@", shopModel);
    [self showShopDetail:shopModel.shop_id];
}

- (void)executeShowGoodsDetail:(YYGoodsModel *)goodsModel indexPath:(NSIndexPath *)indexPath
{
    MJExtensionLog(@"%@", goodsModel);
    [self showGoodsDetail:goodsModel.goodsID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
