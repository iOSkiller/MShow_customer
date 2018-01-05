//
//  YYChangeReturnFlowView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/11.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYChangeReturnFlowView.h"
#import "YYChangeReturnFlowViewCell.h"
#import "YYDotLineView.h"

static NSString *const cellID = @"YYChangeReturnFlowViewCellID";
@interface YYChangeReturnFlowView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) YYDotLineView *dotLineView;

@end

@implementation YYChangeReturnFlowView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(WIN_WIDTH / 3, RELATIVE_WIDTH(66));
        flowLayout.minimumLineSpacing = 0.0;
        flowLayout.minimumInteritemSpacing = 0.0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(50), WIN_WIDTH, RELATIVE_WIDTH(66)) collectionViewLayout:flowLayout];
        view.backgroundColor = mRGBToColor(0xf4f4f4);
        view.delegate = self;
        view.dataSource = self;
        view.scrollEnabled = NO;
        [view registerClass:[YYChangeReturnFlowViewCell class] forCellWithReuseIdentifier:cellID];
        [self addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}

- (YYDotLineView *)dotLineView {
    if (!_dotLineView) {
        YYDotLineView *view = [[YYDotLineView alloc] initWithFrame:CGRectMake(RELATIVE_WIDTH(112), RELATIVE_WIDTH(20), WIN_WIDTH - RELATIVE_WIDTH(112) - RELATIVE_WIDTH(100), RELATIVE_WIDTH(36)) dotCount:3];
        [self addSubview:view];
        _dotLineView = view;
    }
    return _dotLineView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = mRGBToColor(0xf4f4f4);
        [self collectionView];
        [self dotLineView];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYChangeReturnFlowViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    switch (indexPath.item) {
        case 0:
            cell.statusLabel.text = @"申请已提交";
            cell.dateLabel.text = @"2017-12-10 10:10";
            break;
        case 1:
            cell.statusLabel.text = @"卖家受理";
            cell.dateLabel.text = @"2017-12-10 10:15";
            break;
        case 2:
            cell.statusLabel.text = @"退款成功";
            cell.dateLabel.text = @"2017-12-10 10:20";
            break;
        default:
            break;
    }
    return cell;
}



@end
