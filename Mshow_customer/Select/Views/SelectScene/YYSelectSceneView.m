//
//  YYSelectSceneView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectSceneView.h"
#import "YYSelectSceneViewCell.h"
#import "YYSceneModel.h"

static NSString *const cellID = @"YYSelectSceneViewCellID";
@interface YYSelectSceneView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation YYSelectSceneView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(30), RELATIVE_WIDTH(26), RELATIVE_WIDTH(26), RELATIVE_WIDTH(26));
        CGFloat itemWidth = (WIN_WIDTH - RELATIVE_WIDTH(26) * 2 - RELATIVE_WIDTH(20) * 2) / 3.0f;
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(20);
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(20);
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth * 10 / 11.0f);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        [view registerClass:[YYSelectSceneViewCell class] forCellWithReuseIdentifier:cellID];
        view.backgroundColor = [UIColor whiteColor];
        view.showsVerticalScrollIndicator = NO;
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

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYSelectSceneViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeShowScene:)]) {
        [_delegate executeShowScene:[YYSceneModel new]];
    }
}

@end
