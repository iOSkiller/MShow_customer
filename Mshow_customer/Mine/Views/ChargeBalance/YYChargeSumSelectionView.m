//
//  YYChargeSumSelectionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYChargeSumSelectionView.h"
#import "YYChargeSumSelectionViewCell.h"
#import "YYChargeSumModel.h"

#define margin RELATIVE_WIDTH(54)

static NSString *const cellID = @"YYChargeSumSelectionViewCellID";

@interface YYChargeSumSelectionView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *selectionView;

@end

@implementation YYChargeSumSelectionView

- (UICollectionView *)selectionView {
    if (!_selectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        CGFloat itemWidth = (self.mj_w - margin * 2 - RELATIVE_WIDTH(88)) / 2;
        CGFloat itemHeight = RELATIVE_WIDTH(70);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(88);
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(32);
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(0), RELATIVE_WIDTH(53), RELATIVE_WIDTH(0), RELATIVE_WIDTH(54));
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(260)) collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        [view setShowsVerticalScrollIndicator:NO];
        view.backgroundColor = [UIColor whiteColor];
        [view registerClass:[YYChargeSumSelectionViewCell class] forCellWithReuseIdentifier:cellID];
        [self addSubview:view];
        _selectionView = view;
    }
    return _selectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self selectionView];
    }
    return self;
}

- (void)setSelectionArray:(NSArray *)selectionArray
{
    _selectionArray = selectionArray;
    [self.selectionView reloadData];
    [self.selectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    if (_didSelectBlock) {
        _didSelectBlock(self.selectionArray[0]);
    }
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _selectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYChargeSumSelectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYChargeSumSelectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYChargeSumModel *model = self.selectionArray[indexPath.item];
    cell.sumText = model.content;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_didSelectBlock) {
        _didSelectBlock(self.selectionArray[indexPath.item]);
    }
}

@end
