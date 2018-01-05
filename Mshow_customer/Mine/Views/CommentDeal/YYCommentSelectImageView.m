//
//  YYCommentSelectImageView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/20.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCommentSelectImageView.h"
#import "YYCommentSelectImageViewCell.h"

static NSString *const cellID = @"YYCommentSelectImageViewCellID";
@interface YYCommentSelectImageView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation YYCommentSelectImageView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(RELATIVE_WIDTH(160), RELATIVE_WIDTH(160));
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(20), RELATIVE_WIDTH(50), RELATIVE_WIDTH(20), RELATIVE_WIDTH(50));
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(20);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(85);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        [view registerClass:[YYCommentSelectImageViewCell class] forCellWithReuseIdentifier:cellID];
        view.showsHorizontalScrollIndicator = NO;
        view.scrollEnabled = NO;
        view.backgroundColor = [UIColor whiteColor];
        view.delegate = self;
        view.dataSource = self;
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

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    [self.collectionView reloadData];
}

- (void)deleteImage:(UIImage *)image
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.imageArray];
    [array removeObject:image];
    self.imageArray = array;
    if (_didChangeImage) {
        _didChangeImage(self.imageArray);
    }
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_maxImagesCount == self.imageArray.count) {
        return self.imageArray.count;
    }
    return self.imageArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYCommentSelectImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (self.imageArray.count == _maxImagesCount) {
        cell.image = self.imageArray[indexPath.item];
    } else {
        if (indexPath.item != self.imageArray.count) {
            cell.image = self.imageArray[indexPath.item];
        }
    }
    cell.isCamera = indexPath.item == self.imageArray.count;
    cell.backgroundColor = [UIColor whiteColor];
    cell.indexPath = indexPath;
    WS(weakSelf);
    cell.deleteActionBlock = ^(UIImage *image, NSIndexPath *indexPath) {
        StrongSelf(strongSelf);
        strongSelf = weakSelf;
        [self deleteImage:image];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYCommentSelectImageViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == self.imageArray.count) {
        if (_pickImageBlock) {
            _pickImageBlock(self.imageArray.count);
        }
    } else {
        if (_showImageBlock) {
            _showImageBlock(self.imageArray[indexPath.item], indexPath.item);
        }
    }
}

@end
