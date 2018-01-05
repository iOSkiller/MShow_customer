//
//  YYShopDetailView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/29.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShopDetailView.h"
#import "YYShopDetailReusableView.h"
#import "YYSelectGenderViewCell.h"
#import "YYGoodsModel.h"
#import "YYShopModel.h"

@interface YYShopDetailView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UILabel *kindLabel;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end


static NSString *const cellID = @"YYShopDetailViewCellID";
static NSString *const headerID = @"YYShopDetailViewHeaderID";
static NSString *const footerID = @"YYShopDetailViewFooterID";

@implementation YYShopDetailView

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(34);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(8);
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(20), RELATIVE_WIDTH(24), RELATIVE_WIDTH(20), RELATIVE_WIDTH(24));
        flowLayout.itemSize = CGSizeMake(RELATIVE_WIDTH(346), RELATIVE_WIDTH(520));
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        
        view.delegate = self;
        view.dataSource = self;
        [view registerClass:[YYSelectGenderViewCell class] forCellWithReuseIdentifier:cellID];
        [view registerClass:[YYShopDetailReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
        view.showsVerticalScrollIndicator = NO;
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}

- (UILabel *)kindLabel {
    if (!_kindLabel) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];;
        label.textColor = YYTextColor;
        label.text = @"商品分类";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showKindAction)];
        [label addGestureRecognizer:tap];
        label.userInteractionEnabled = YES;
        UIView *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(1))];
        line.backgroundColor = YYSeparatorColor;
        [label addSubview:line];
        [self addSubview:label];
        _kindLabel = label;
    }
    return _kindLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.dataArray addObjectsFromArray:[YYGoodsModel testWomanArray]];
        [self collectionView];
        self.backgroundColor = YYSeparatorColor;
        WS(ws);
        [self.kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(ws);
            make.bottom.equalTo(ws).offset(-iPhone_MARGIN_BOTTOM);
            make.height.mas_equalTo(RELATIVE_WIDTH(100));
        }];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(ws);
            make.bottom.equalTo(self.kindLabel.mas_top).offset(-RELATIVE_WIDTH(1));
        }];
    }
    return self;
}

- (void)showKindAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeShowAllKinds)]) {
        [_delegate executeShowAllKinds];
    }
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYSelectGenderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.goodsModel = self.dataArray[indexPath.item];
    cell.selectBlock = ^(YYGoodsModel *model, BOOL isSelected) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeFollowGoods:)]) {
            [_delegate executeFollowGoods:model];
        }
    };
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view = [UICollectionReusableView new];
    if (kind == UICollectionElementKindSectionHeader) {
        YYShopDetailReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        headerView.shopModel = [YYShopModel new];
        return headerView;
        
    }
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeShowGoodsDetail:)]) {
        [_delegate executeShowGoodsDetail:self.dataArray[indexPath.item]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section

{
    return CGSizeMake(self.mj_w, RELATIVE_WIDTH(610));
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeDidScroll:)]) {
        [_delegate executeDidScroll:scrollView.contentOffset.y];
    }
}
@end
