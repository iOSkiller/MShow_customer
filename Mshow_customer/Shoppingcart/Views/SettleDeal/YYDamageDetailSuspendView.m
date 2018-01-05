//
//  YYDamageDetailSuspendView.m
//  Mshow_customer
//
//  Created by YYZ on 2018/1/3.
//  Copyright © 2018年 YYZ. All rights reserved.
//

#import "YYDamageDetailSuspendView.h"

static NSString *const cellID = @"YYDamageDetailSuspendViewCellID";
@interface YYDamageDetailSuspendView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIButton *previousButton;
@property (nonatomic, weak) UIButton *nextButton;
@property (nonatomic, weak) UILabel *infoLabel;

@end

@implementation YYDamageDetailSuspendView

{
    NSInteger _index;
    BOOL _isScroll;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0.0;
        flowLayout.minimumInteritemSpacing = 0.0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(RELATIVE_WIDTH(320), RELATIVE_WIDTH(280));
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(RELATIVE_WIDTH(320)), RELATIVE_WIDTH(280)) collectionViewLayout:flowLayout];
        [view registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
        view.delegate = self;
        view.dataSource = self;
        view.showsHorizontalScrollIndicator = NO;
        view.backgroundColor = [UIColor whiteColor];
        view.pagingEnabled = YES;
        [self addSubview:view];
        WS(ws);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(30));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(320), RELATIVE_WIDTH(280)));
            make.centerX.equalTo(ws);
        }];
        _collectionView = view;
    }
    return _collectionView;
}

- (UIButton *)previousButton {
    if (!_previousButton) {
        UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [previousButton setImage:[UIImage imageNamed:@"img_arrow_left"] forState:UIControlStateNormal];
        [previousButton addTarget:self action:@selector(previousAction) forControlEvents:UIControlEventTouchUpInside];
        previousButton.hidden = YES;
        [self addSubview:previousButton];
        WS(ws);
        [previousButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(40));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
            make.centerY.equalTo(ws);
        }];
        _previousButton = previousButton;
        _previousButton.hidden = YES;
    }
    return _previousButton;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setImage:[UIImage imageNamed:@"img_arrow_right"] forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextButton];
        WS(ws);
        [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(40));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
            make.centerY.equalTo(ws);
        }];
        _nextButton = nextButton;
    }
    return _nextButton;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = YYGrayTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        label.layer.borderWidth = RELATIVE_WIDTH(1);
        label.layer.borderColor = YYGrayTextColor.CGColor;
        label.layer.masksToBounds = YES;
        label.text = @"折损说明:袖口有轻微划痕";
        [self addSubview:label];
        WS(ws);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collectionView.mas_bottom).offset(RELATIVE_WIDTH(20));
            make.centerX.equalTo(ws);
            make.width.equalTo(self.collectionView);
            make.height.mas_equalTo(RELATIVE_WIDTH(80));
        }];
        _infoLabel = label;
    }
    return _infoLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self nextButton];
        [self previousButton];
        [self collectionView];
        [self infoLabel];
        
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    [self.collectionView reloadData];
}

- (void)previousAction
{
    if (_index > 0) {
        _isScroll = YES;
        _index --;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        self.previousButton.hidden = _index < 1;
        self.nextButton.hidden = _index == self.imageArray.count - 1;
    }
}

- (void)nextAction
{
    if (_index < self.imageArray.count - 1) {
        _isScroll = YES;
        _index ++;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_index inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
        self.previousButton.hidden = _index < 1;
        self.nextButton.hidden = _index == self.imageArray.count - 1;
    }
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(320), RELATIVE_WIDTH(280))];
    imgView.image = [UIImage clipImage:[UIImage imageNamed:self.imageArray[indexPath.item]] toRect:CGSizeMake(RELATIVE_WIDTH(320), RELATIVE_WIDTH(280))];
    [cell.contentView addSubview:imgView];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (!_isScroll) {
        CGFloat offsetX = scrollView.contentOffset.x;
        CGFloat width = RELATIVE_WIDTH(280);
        // 获取角标
        _index = (offsetX / width);
        
        self.previousButton.hidden = _index < 1;
        self.nextButton.hidden = _index == self.imageArray.count - 1;
    }
}

// 监听滚动动画是否完成
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _isScroll = NO;
    
}

@end
