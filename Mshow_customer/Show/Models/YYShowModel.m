//
//  YYShowModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/31.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYShowModel.h"

@implementation YYShowModel
- (void)setContent:(NSString *)content
{
    _content = content;
    _contentHeight = [content getStringRect:[UIFont systemFontOfSize:RELATIVE_WIDTH(32)] size:CGSizeMake(WIN_WIDTH - RELATIVE_WIDTH(48), MAXFLOAT)].size.height + RELATIVE_WIDTH(8);
    _cellHeight += _contentHeight;
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    CGFloat itemWidth = (WIN_WIDTH - RELATIVE_WIDTH(24) * 2 - RELATIVE_WIDTH(20)) / 3;
    CGFloat itemHeight = itemWidth * 1.15;
    switch (images.count) {
            
        case 1:
        case 2:
            _imageContainerHeight = RELATIVE_WIDTH(860);
            itemWidth = (WIN_WIDTH - RELATIVE_WIDTH(24) * 2 - RELATIVE_WIDTH(20)) / 2;
            itemHeight = RELATIVE_WIDTH(600);
            break;
        default:
            if ((int)ceil(images.count / 3.0) == 1) {
                _imageContainerHeight = RELATIVE_WIDTH(530);
            }
            
            if ((int)ceil(images.count / 3.0) == 2) {
                _imageContainerHeight = RELATIVE_WIDTH(790);
            }
            
            if ((int)ceil(images.count / 3.0) == 3) {
                _imageContainerHeight = RELATIVE_WIDTH(1080);
            }
            
            break;
    }
    _cellHeight += _imageContainerHeight;
    _itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (void)setImageURLs:(NSArray *)imageURLs
{
    _imageURLs = imageURLs;
    CGFloat itemWidth = (WIN_WIDTH - RELATIVE_WIDTH(24) * 2 - RELATIVE_WIDTH(20)) / 3;
    CGFloat itemHeight = itemWidth * 1.15;
    switch (imageURLs.count) {
            
        case 1:
        case 2:
            _imageContainerHeight = RELATIVE_WIDTH(860);
            itemWidth = (WIN_WIDTH - RELATIVE_WIDTH(24) * 2 - RELATIVE_WIDTH(20)) / 2;
            itemHeight = RELATIVE_WIDTH(600);
            break;
        default:
            if ((int)ceil(imageURLs.count / 3.0) == 1) {
                _imageContainerHeight = RELATIVE_WIDTH(530);
            }
            
            if ((int)ceil(imageURLs.count / 3.0) == 2) {
                _imageContainerHeight = RELATIVE_WIDTH(790);
            }
            
            if ((int)ceil(imageURLs.count / 3.0) == 3) {
                _imageContainerHeight = RELATIVE_WIDTH(1080);
            }
            
            break;
    }
    _cellHeight += _imageContainerHeight;
    _itemSize = CGSizeMake(itemWidth, itemHeight);
}

+ (NSArray *)testArray
{
    YYShowModel *model1 = [YYShowModel new];
    model1.imageCount = 1;
    model1.images = @[@"woman30.jpg"];
    model1.content = @"颜色正，摸起来很舒服，很修身。";
    
    YYShowModel *model2 = [YYShowModel new];
    model2.imageCount = 2;
    model2.images = @[@"woman21.jpg", @"woman22.jpg"];
    model2.content = @"颜色正，摸起来很舒服，很修身。颜色正，摸起来很舒服，很修身。";
    
    YYShowModel *model3 = [YYShowModel new];
    model3.imageCount = 3;
    model3.images = @[@"woman29.jpg", @"woman30.jpg", @"woman22.jpg"];
    model3.content = @"颜色正，摸起来很舒服，很修身。";
    
    YYShowModel *model4 = [YYShowModel new];
    model4.imageCount = 4;
    model4.images = @[@"woman37.jpg", @"woman38.jpg", @"woman39.jpg", @"woman40.jpg"];
    model4.content = @"颜色正，摸起来很舒服，很修身。颜色正，摸起来很舒服，很修身。";
    
    YYShowModel *model5 = [YYShowModel new];
    model5.imageCount = 9;
    model5.images = @[@"woman20.jpg", @"woman21.jpg", @"woman23.jpg", @"woman25.jpg", @"woman26.jpg", @"woman33.jpg", @"woman18.jpg", @"woman19.jpg", @"woman24.jpg"];
    model5.content = @"颜色正，摸起来很舒服，很修身。";

    return @[model1, model2, model3, model4, model5];
}

@end
