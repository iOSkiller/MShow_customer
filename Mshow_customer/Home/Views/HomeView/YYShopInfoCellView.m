//
//  YYShopInfoCellView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/3.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShopInfoCellView.h"
#import "YYShopStarView.h"
#import "YYShopGoodsDisplayViewCell.h"
#import "YYShopModel.h"

static NSString *cellID = @"YYShopInfoCellViewCellID";
@interface YYShopInfoCellView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UIImageView *logoView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *saleLabel;
@property (nonatomic, weak) UILabel *countLabel;
@property (nonatomic, weak) UILabel *distanceLabel;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) YYShopStarView *starView;

@end

@implementation YYShopInfoCellView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(RELATIVE_WIDTH(230), RELATIVE_WIDTH(230));
        flowLayout.minimumLineSpacing = RELATIVE_WIDTH(8);
        flowLayout.minimumInteritemSpacing = RELATIVE_WIDTH(8);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, RELATIVE_WIDTH(26), 0, RELATIVE_WIDTH(26));
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(230)) collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        [view registerClass:[YYShopGoodsDisplayViewCell class] forCellWithReuseIdentifier:cellID];
        view.backgroundColor = [UIColor whiteColor];
        view.showsHorizontalScrollIndicator = NO;
        view.scrollEnabled = NO;
        [self addSubview:view];
        _collectionView = view;
    }
    return _collectionView;
}


- (UIImageView *)logoView {
    if (!_logoView) {
        UIImageView *view = [UIImageView new];
        view.backgroundColor = mRGBToColor(0xcccccc);
        [self addSubview:view];
        _logoView = view;
    }
    return _logoView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.textColor = YYTextColor;
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)saleLabel {
    if (!_saleLabel) {
        UILabel *label = [UILabel new];
        label.textColor = mRGBToColor(0x626262);
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"销量233";
        [self addSubview:label];
        _saleLabel = label;
    }
    return _saleLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        UILabel *label = [UILabel new];
        label.textColor = mRGBToColor(0x626262);
        label.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"共245单品";
        [self addSubview:label];
        _countLabel = label;
    }
    return _countLabel;
}

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont boldSystemFontOfSize:RELATIVE_WIDTH(20)];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = YYGrayTextColor;
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _distanceLabel = label;
    }
    return _distanceLabel;
}

- (YYShopStarView *)starView {
    if (!_starView) {
        YYShopStarView *view = [[YYShopStarView alloc] initWithFrame:CGRectMake(0, 0, RELATIVE_WIDTH(200), RELATIVE_WIDTH(32))];
        [view setStarsCount:5 starImage:[UIImage imageNamed:@"img_star"]];
        [self addSubview:view];
        _starView = view;
    }
    return _starView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        WS(ws);
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(ws);
            make.bottom.equalTo(ws.mas_bottom).offset(-RELATIVE_WIDTH(20));
            make.height.mas_equalTo(RELATIVE_WIDTH(230));
        }];
        
        [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws).offset(-RELATIVE_WIDTH(26));
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(30));
            make.width.greaterThanOrEqualTo(@0);
            make.height.mas_equalTo(RELATIVE_WIDTH(22));
        }];
        
        [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws).offset(RELATIVE_WIDTH(26));
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(20));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(100), RELATIVE_WIDTH(100)));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.logoView.mas_right).offset(RELATIVE_WIDTH(20));
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(30));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(190), RELATIVE_WIDTH(32)));
        }];
        
        [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.logoView.mas_right).offset(RELATIVE_WIDTH(20));
            make.top.equalTo(self.nameLabel.mas_bottom).offset(RELATIVE_WIDTH(10));
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(160), RELATIVE_WIDTH(32)));
        }];
        
        [self.saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(RELATIVE_WIDTH(130), RELATIVE_WIDTH(32)));
            make.left.equalTo(self.starView.mas_right).offset(RELATIVE_WIDTH(10));
            make.centerY.equalTo(self.starView);
            
        }];
        
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.height.equalTo(self.saleLabel);
            make.left.equalTo(self.saleLabel.mas_right).offset(RELATIVE_WIDTH(20));
            make.width.mas_equalTo(RELATIVE_WIDTH(180));
        }];
        
    }
    return self;
}

- (void)setShopModel:(YYShopModel *)shopModel
{
    _shopModel = shopModel;
    _shopModel.imageArray = @[@"shop01.jpg", @"shop02.jpg", @"shop03.jpg"];
    self.logoView.image = [UIImage clipImage:[UIImage imageNamed:@"shop01.jpg"] toRect:CGSizeMake(RELATIVE_WIDTH(100), RELATIVE_WIDTH(100))];
    self.nameLabel.text = shopModel.shopName;
    self.saleLabel.text = [NSString stringWithFormat:@"销量%@", shopModel.saleCount];
    self.countLabel.text = [NSString stringWithFormat:@"共%@单品", shopModel.goodsCount];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@千米|%@分钟", shopModel.distance, shopModel.delivery_duration];
}

#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _shopModel.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYShopGoodsDisplayViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.imgURL = _shopModel.imageArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
