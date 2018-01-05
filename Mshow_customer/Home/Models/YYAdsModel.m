//
//  YYAdsModel.m
//  Service1.0
//
//  Created by YZ Y on 16/4/27.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYAdsModel.h"
#import "YYImageModel.h"

@implementation YYAdsModel

- (void)setResult:(NSArray *)result
{
    NSArray *imageArr = [YYImageModel mj_objectArrayWithKeyValuesArray:result];
    _result = imageArr;
}

- (void)transformImageURL:(YYAdsViewType)type
{
    NSMutableArray *array = [NSMutableArray array];
    for (YYImageModel *model in _result) {
        NSString *imageURL = AppendString(type == YYAdsViewTypeBigImage ? AdsImgUrl : SmallAdsImgUrl, model.image);
        model.image = AppendString(BaseURL, imageURL);
        [array addObject:model];
//        [[UIImageView new] sd_setImageWithURL:[NSURL URLWithString:model.image]];
    }
    _result = array;

}

@end
