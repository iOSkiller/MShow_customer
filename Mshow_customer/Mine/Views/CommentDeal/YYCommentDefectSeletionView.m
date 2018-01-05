//
//  YYCommentDefectSeletionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCommentDefectSeletionView.h"
#import "YYCommentDefectSelectionViewCell.h"
#import "YYDefectModel.h"

static NSString *const cellID = @"YYCommentDefectSelectionViewCellID";

@interface YYCommentDefectSeletionView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation YYCommentDefectSeletionView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = (self.mj_w - RELATIVE_WIDTH(48) - RELATIVE_WIDTH(60)) / 2;
        flowLayout.itemSize = CGSizeMake(itemWidth, RELATIVE_WIDTH(50));
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(10), RELATIVE_WIDTH(24), RELATIVE_WIDTH(10), RELATIVE_WIDTH(24));
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(20);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(60);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        view.backgroundColor = [UIColor whiteColor];
        view.delegate = self;
        view.dataSource = self;
        view.scrollEnabled = NO;
        [view registerClass:[YYCommentDefectSelectionViewCell class] forCellWithReuseIdentifier:cellID];
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

- (void)setSelectionArray:(NSArray *)selectionArray
{
    _selectionArray = selectionArray;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYCommentDefectSelectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.defectModel = self.selectionArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYCommentDefectSelectionViewCell *cell = (YYCommentDefectSelectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.isSelected = !cell.isSelected;
}

@end
