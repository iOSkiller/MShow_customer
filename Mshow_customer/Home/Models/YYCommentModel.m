//
//  YYCommentModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/8.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYCommentModel.h"
#import "YYGoodsModel.h"

@implementation YYCommentModel
+ (NSArray *)testShowDataArray
{
    YYCommentModel *model1 = [YYCommentModel new];
    model1.images = @[@"woman21.jpg"];
    model1.content = @"颜色正，摸起来很舒服，很修身。";
    model1.size = @"M";
    model1.height = @"165";
    model1.nickName = @"喵喵喵";
    model1.upvoteCount = @"30";
    model1.type = YYCommentTypeShow;
    
    YYCommentModel *model2 = [YYCommentModel new];
    model2.images = @[@"woman21.jpg", @"woman22.jpg"];
    model2.content = @"颜色正，摸起来很舒服，很修身。颜色正，摸起来很舒服，很修身。";
    model2.size = @"L";
    model2.height = @"168";
    model2.nickName = @"咚咚咚";
    model2.upvoteCount = @"40";
    model2.type = YYCommentTypeShow;
    
    YYCommentModel *model3 = [YYCommentModel new];
    model3.images = @[@"woman21.jpg", @"woman22.jpg", @"woman30.jpg"];
    model3.content = @"颜色正，摸起来很舒服，很修身。颜色正，摸起来很舒服，很修身。颜色正，摸起来很舒服，很修身。颜色正，摸起来很舒服，很修身。";
    model3.size = @"XL";
    model3.height = @"170";
    model3.nickName = @"咪咪咪";
    model3.upvoteCount = @"50";
    model3.type = YYCommentTypeShow;
    
    return @[model1, model2, model3];
}

+ (NSArray *)testNormalDataArray
{
    NSArray *goodsArray = [YYGoodsModel testWomanArray];
    YYCommentModel *model1 = [YYCommentModel new];
    model1.images = @[@"woman21.jpg"];
    model1.content = @"颜色正，摸起来很舒服，很修身。";
    model1.size = @"M";
    model1.height = @"165";
    model1.nickName = @"喵喵喵";
    model1.upvoteCount = @"30";
    model1.type = YYCommentTypeNormal;
    model1.goodsModel = goodsArray[1];
    
    YYCommentModel *model2 = [YYCommentModel new];
    model2.images = @[@"woman21.jpg", @"woman22.jpg"];
    model2.content = @"颜色正，摸起来很舒服，很修身。颜色正，摸起来很舒服，很修身。";
    model2.size = @"L";
    model2.height = @"168";
    model2.nickName = @"咚咚咚";
    model2.upvoteCount = @"40";
    model2.type = YYCommentTypeNormal;
    model2.goodsModel = goodsArray[2];
    
    YYCommentModel *model3 = [YYCommentModel new];
    model3.images = @[@"woman21.jpg", @"woman22.jpg", @"woman30.jpg"];
    model3.content = @"颜色正，摸起来很舒服，很修身。颜色正，摸起来很舒服，很修身。颜色正，摸起来很舒服，很修身。颜色正，摸起来很舒服，很修身。";
    model3.size = @"XL";
    model3.height = @"170";
    model3.nickName = @"咪咪咪";
    model3.upvoteCount = @"50";
    model3.type = YYCommentTypeNormal;
    model3.goodsModel = goodsArray[3];
    
    return @[model1, model2, model3];
}

- (void)setContent:(NSString *)content
{
    _content = content;
    CGFloat height = [content getStringRect:[UIFont systemFontOfSize:RELATIVE_WIDTH(22)] size:CGSizeMake(WIN_WIDTH - RELATIVE_WIDTH(150), MAXFLOAT)].size.height + RELATIVE_WIDTH(10);
    _cellHeight = _type == YYCommentTypeShow ? RELATIVE_WIDTH(400) + height : RELATIVE_WIDTH(420) + height;
    _contentHeight = height;
}

- (void)setType:(YYCommentType)type
{
    _type = type;
    
}

@end
