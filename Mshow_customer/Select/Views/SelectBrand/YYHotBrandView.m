//
//  YYHotBrandView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHotBrandView.h"
#import "YYHotBrandViewCell.h"
#import "YYBrandModel.h"

static NSString *const cellID = @"YYHotBrandViewCellID";
@interface YYHotBrandView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation YYHotBrandView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat itemWidth = (WIN_WIDTH - RELATIVE_WIDTH(10) * 3 - RELATIVE_WIDTH(24) * 2) / 4;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth * 0.875);
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(10);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(10);
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(20), RELATIVE_WIDTH(24), RELATIVE_WIDTH(20), RELATIVE_WIDTH(24));
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = [UIColor whiteColor];
        [view registerClass:[YYHotBrandViewCell class] forCellWithReuseIdentifier:cellID];
        view.scrollEnabled = NO;
        [self addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self collectionView];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYHotBrandViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYHotBrandViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.model = nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_showHotBrandBlock) {
        _showHotBrandBlock([YYBrandModel new]);
    }
}

@end
