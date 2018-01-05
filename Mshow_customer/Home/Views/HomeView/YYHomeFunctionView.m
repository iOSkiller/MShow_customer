//
//  YYHomeFunctionView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYHomeFunctionView.h"
#import "YYHomeFunctionViewCell.h"

static NSString *const cellID = @"YYHomeFunctionViewCellID";
@interface YYHomeFunctionView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation YYHomeFunctionView

{
    NSArray *_titleArray;
    NSArray *_imageArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = (WIN_WIDTH - RELATIVE_WIDTH(60) * 3 - RELATIVE_WIDTH(40)) / 4;
        flowLayout.itemSize = CGSizeMake(itemWidth, RELATIVE_WIDTH(200));
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(0), RELATIVE_WIDTH(20), RELATIVE_WIDTH(0), RELATIVE_WIDTH(20));
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(20);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(60);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = [UIColor whiteColor];
        view.scrollEnabled = NO;
        [view registerClass:[YYHomeFunctionViewCell class] forCellWithReuseIdentifier:cellID];
        [self addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}


- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray
{
    if (self = [super initWithFrame:frame]) {
        _titleArray = titleArray;
        _imageArray = imageArray;
        [self collectionView];
    }
    return self;
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
    YYHomeFunctionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.item]];
    cell.titleLabel.text = _titleArray[indexPath.item];
//    switch (indexPath.row) {
//        case 0:
//            cell.imageView.backgroundColor = mRGBToColor(0x78b1fe);
//            break;
//        case 1:
//            cell.imageView.backgroundColor = mRGBToColor(0x9bde54);
//            break;
//        case 2:
//            cell.imageView.backgroundColor = mRGBToColor(0xf97070);
//            break;
//        case 3:
//            cell.imageView.backgroundColor = mRGBToColor(0xfeb047);
//            break;
//        default:
//            break;
//    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYHomeFunctionType type = YYHomeFunctionTypeNone;
    switch (indexPath.item) {
        case 0:
            type = YYHomeFunctionTypeHot;
            break;
        case 1:
            type = YYHomeFunctionTypeNew;
            break;
        case 2:
            type = YYHomeFunctionTypeFree;
            break;
        case 3:
            type = YYHomeFunctionTypeWash;
            break;
        default:
            break;
    }
    if (_didSelectFuctionBlock) {
        _didSelectFuctionBlock(type);
    }
}

@end
