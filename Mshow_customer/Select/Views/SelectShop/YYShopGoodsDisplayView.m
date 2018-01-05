//
//  YYShopGoodsDisplayView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShopGoodsDisplayView.h"
#import "YYShopGoodsDisplayViewCell.h"
#import "YYGoodsModel.h"

static NSString *const cellID = @"YYShopGoodsDisplayViewCellID";
@interface YYShopGoodsDisplayView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation YYShopGoodsDisplayView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = (WIN_WIDTH - RELATIVE_WIDTH(26) * 2 - RELATIVE_WIDTH(6) * 2) / 3;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth / 0.92f);
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(24), RELATIVE_WIDTH(26), RELATIVE_WIDTH(24), RELATIVE_WIDTH(26));
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(6);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(6);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, RELATIVE_WIDTH(310)) collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        view.showsHorizontalScrollIndicator = NO;
        [view registerClass:[YYShopGoodsDisplayViewCell class] forCellWithReuseIdentifier:cellID];
        view.backgroundColor = [UIColor whiteColor];
        view.showsHorizontalScrollIndicator = NO;
        [self addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self collectionView];
        WS(ws);
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
    }
    return self;
}

- (void)setGoodsArray:(NSArray *)goodsArray
{
    _goodsArray = goodsArray;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYShopGoodsDisplayViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYShopGoodsDisplayViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYGoodsModel *model = _goodsArray[indexPath.item];
    cell.imgURL = model.image;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tapActionBlock) {
        _tapActionBlock(_goodsArray[indexPath.item]);
    }
}




@end
