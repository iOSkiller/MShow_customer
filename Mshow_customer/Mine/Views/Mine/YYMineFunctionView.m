//
//  YYMineFunctionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/30.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYMineFunctionView.h"
#import "YYMineFunctionViewCell.h"


static NSString *const cellID = @"YYMineFunctionViewCellID";
@interface YYMineFunctionView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, copy) NSArray *countArray;

@end

@implementation YYMineFunctionView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = (self.mj_w - RELATIVE_WIDTH(52) - RELATIVE_WIDTH(150)) / 4;
        flowLayout.itemSize = CGSizeMake(itemWidth, RELATIVE_WIDTH(110));
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(50);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(10);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, RELATIVE_WIDTH(26), 0, RELATIVE_WIDTH(26));
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = [UIColor clearColor];
        [view registerClass:[YYMineFunctionViewCell class] forCellWithReuseIdentifier:cellID];
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

- (void)setTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray countArray:(NSArray *)countArray
{
    _imageArray = imageArray;
    _titleArray = titleArray;
    _countArray = countArray;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYMineFunctionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.item <= self.imageArray.count - 1) {
        if (self.countArray.count == 3) {
            cell.titleLabel.textColor = [UIColor whiteColor];
        }
        [cell setImage:[UIImage imageNamed:self.imageArray[indexPath.item]] title:self.titleArray[indexPath.item]];
    } else {
        cell.titleLabel.textColor = [UIColor whiteColor];
        [cell setTitle:self.titleArray[indexPath.item] countInfo:self.countArray[indexPath.item - 1]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYMineFunctionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tapActionBlock) {
        _tapActionBlock(indexPath.item);
    }
}

@end
