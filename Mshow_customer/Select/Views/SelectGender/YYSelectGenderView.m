//
//  YYSelectGenderView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectGenderView.h"
#import "YYSelectGenderViewCell.h"

static NSString *const cellID = @"YYSelectChildViewCellID";
static NSString *const footerID = @"YYSelectChildViewFooterViewID";
@interface YYSelectGenderView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *originalArray;

@end

@implementation YYSelectGenderView

- (NSMutableArray *)originalArray {
    if (!_originalArray) {
        _originalArray = [NSMutableArray array];
    }
    return _originalArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(34);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(8);
        flowLayout.sectionInset = UIEdgeInsetsMake(RELATIVE_WIDTH(20), RELATIVE_WIDTH(24), RELATIVE_WIDTH(20), RELATIVE_WIDTH(24));
        flowLayout.itemSize = CGSizeMake(RELATIVE_WIDTH(346), RELATIVE_WIDTH(520));
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, WIN_HEIGHT - iPhone_ProtraitDisableViewHeight - RELATIVE_WIDTH(160) - 49) collectionViewLayout:flowLayout];
        
        view.delegate = self;
        view.dataSource = self;
        [view registerClass:[YYSelectGenderViewCell class] forCellWithReuseIdentifier:cellID];
        [view registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID];
        view.showsVerticalScrollIndicator = NO;
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            if (_delegate && [_delegate respondsToSelector:@selector(collectionViewLoadMoreData)]) {
                [_delegate collectionViewLoadMoreData];
            }
        }];
        WS(ws);
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws);
        }];
    }
    return self;
}

- (void)endRefresh
{
    [self.collectionView.mj_footer endRefreshing];
}

- (void)setDataArray:(NSArray *)dataArray
{
    if (self.originalArray.count > 0) {
        dataArray.count < 10 ? [self.collectionView.mj_footer endRefreshingWithNoMoreData] : [self.collectionView.mj_footer endRefreshing];
    }
    _dataArray = dataArray;
    [self.originalArray addObjectsFromArray:dataArray];
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    self.collectionView.mj_footer.hidden = self.collectionView.contentSize.height < self.collectionView.mj_h;
}

- (void)scrollToIndex:(NSUInteger)index
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.originalArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYSelectGenderViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectBlock = ^(YYGoodsModel *model, BOOL isSelected) {
        if (_delegate && [_delegate respondsToSelector:@selector(executeLikeGoods:isLike:)]) {
            [_delegate executeLikeGoods:model isLike:isSelected];
        }
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYSelectGenderViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.goodsModel = self.originalArray[indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(executeShowGoodsDetail:)]) {
        [_delegate executeShowGoodsDetail:self.originalArray[indexPath.item]];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID forIndexPath:indexPath];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
    return [UICollectionReusableView new];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(WIN_WIDTH, RELATIVE_WIDTH(30));
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSIndexPath *indexPath = [[self.collectionView indexPathsForVisibleItems] firstObject];
    if (_delegate && [_delegate respondsToSelector:@selector(collectionViewDidScrollToIndex:)]) {
        [_delegate collectionViewDidScrollToIndex:indexPath.item];
    }
}


@end
