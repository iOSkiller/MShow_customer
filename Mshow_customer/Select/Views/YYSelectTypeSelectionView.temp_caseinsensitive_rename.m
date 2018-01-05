//
//  YYSelectTypeSelectionVIew.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/6.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectTypeSelectionVIew.h"
#import "YYSelectTypeSelectionViewCell.h"

static NSString *const cellID = @"YYSelectTypeSelectionViewCellID";
@interface YYSelectTypeSelectionVIew () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UIButton *resetButton;
@property (nonatomic, weak) UIButton *sureButton;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation YYSelectTypeSelectionVIew

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(140);
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(20);
        CGFloat itemWidth = (self.mj_w - RELATIVE_WIDTH(20) * 2 - RELATIVE_WIDTH(140)) / 2;
        flowLayout.itemSize = CGSizeMake(itemWidth, RELATIVE_WIDTH(36));
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        [view registerClass:[YYSelectTypeSelectionViewCell class] forCellWithReuseIdentifier:cellID];
        view.backgroundColor = [UIColor whiteColor];
        _collectionView = view;
    }
    return _collectionView;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = YYGlobalColor;
        [button addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _sureButton = button;
    }
    return _sureButton;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = mRGBToColor(0xf0f0f0);
        [button addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _resetButton = button;
    }
    return _resetButton;
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

- (void)sureAction
{
    
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYSelectTypeSelectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYSelectTypeSelectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.model = self.selectionArray[indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
