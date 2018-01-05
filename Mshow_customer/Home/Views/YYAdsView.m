//
//  YYAdsView.m
//  Service1.0
//
//  Created by YZ Y on 16/4/27.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYAdsView.h"
#import "SDCycleScrollView.h"
#import "YYImageModel.h"

@interface YYAdsView () <SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *scrollView;

@end

@implementation YYAdsView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        SDCycleScrollView *view = [[SDCycleScrollView alloc] initWithFrame:self.frame];
        view.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        view.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        view.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        view.delegate = self;
        view.localizationImageNamesGroup = @[@"scroll01.jpg", @"scroll02.jpg", @"scroll03.jpg"];
        [self addSubview:view];
        _scrollView = view;
    }
    return self;
}

- (void)setInfoArr:(NSArray *)infoArr
{
    _infoArr = infoArr;
}

- (void)setType:(YYAdsViewType)type
{
    _type = type;
    
    switch (_type) {
        case YYAdsViewTypeBigImage:
            _scrollView.placeholderImage = [UIImage imageNamed:@"icon_biglong_placeholder"];
            break;
        case YYAdsViewTypeSamllImage:
            _scrollView.placeholderImage = [UIImage imageNamed:@"icon_smalllong_placeholder"];
            break;
        case YYAdsViewTypeGoodsImage:
            _scrollView.placeholderImage = [UIImage imageNamed:@"icon_placeholder"];
            break;
    }
}

- (void)reloadData
{
    NSMutableArray *imgURLArr = [NSMutableArray array];
    NSMutableArray *imgArr = [NSMutableArray array];
    _scrollView.pageDotColor = [UIColor whiteColor];
    [imgURLArr addObjectsFromArray:_infoArr];
//    for (YYImageModel *model in _infoArr) {
//        switch (_type) {
//            case YYAdsViewTypeBigImage:
//            {
//                [imgURLArr addObject:model.image];
//            }
//
//                break;
//            case YYAdsViewTypeSamllImage:
//            {
//                [imgURLArr addObject:model.image];
//            }
//                break;
//            case YYAdsViewTypeGoodsImage:
//            {
//                [imgURLArr addObject:model.image];
//                _scrollView.pageDotColor = YYSeparatorColor;
//            }
//                break;
//        }
//    }
    if (imgURLArr.count) {
        _scrollView.imageURLStringsGroup = @[];
        
        _scrollView.imageURLStringsGroup = imgURLArr;
        _scrollView.pageDotColor = mRGBColor(153, 153, 153);
        _scrollView.currentPageDotColor = [UIColor whiteColor];
        
        _scrollView.autoScrollTimeInterval = _type == YYAdsViewTypeBigImage ? 3 : 5;
        _scrollView.autoScroll = _type != YYAdsViewTypeGoodsImage;
        if (imgURLArr.count == 1) {
            _scrollView.autoScroll = NO;
            _scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        }
        if (_type == YYAdsViewTypeGoodsImage) {
            self.firstImage = [UIImageView new];
            [self.firstImage sd_setImageWithURL:imgURLArr[0]];
            self.firstImage.frame = self.frame;
        }
    }
    if (imgArr.count) {
        _scrollView.localizationImageNamesGroup = @[];
        _scrollView.localizationImageNamesGroup = imgArr;
        _scrollView.currentPageDotColor = [UIColor whiteColor];
        _scrollView.pageDotColor = [UIColor yellowColor];
        _scrollView.autoScrollTimeInterval = 5;
        _scrollView.autoScroll = !(imgArr.count == 1);
        _scrollView.pageControlStyle = imgArr.count == 1 ? SDCycleScrollViewPageContolStyleNone : SDCycleScrollViewPageContolStyleClassic;
    }

}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (_delegate && [_delegate respondsToSelector:@selector(tapAds:)]) {
        YYImageModel *model = self.infoArr[index];
        [_delegate tapAds:model.code];
    }
}

@end
