//
//  YYGoodsModel.m
//  Mshow_customer
//
//  Created by YYZ on 2017/10/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYGoodsModel.h"
#import "YYImageFileModel.h"

@implementation YYGoodsModel
+ (NSArray *)testDataArray
{
    YYGoodsModel *model1 = [YYGoodsModel new];
    model1.brand = @"DVF";
    model1.image = @"woman01.jpg";
    model1.goodsID = @"0238";
    model1.name = @"韩版时尚卫衣";
    
    model1.discountPrice = @"100.00";
    model1.currentPrice = @"200.00";
    model1.marketPrice = @"300.00";
    model1.color = @"米色";
    model1.size = @"S";
    model1.shop_id = @"1";
    model1.shop_name = @"美丽租";
    
    YYGoodsModel *model2 = [YYGoodsModel new];
    model2.brand = @"DVF";
    model2.image = @"woman31.jpg";
    model2.goodsID = @"0232";
    model2.name = @"秋冬季呢子时尚外衣";
    
    model2.discountPrice = @"100.00";
    model2.currentPrice = @"500.00";
    model2.marketPrice = @"600.00";
    model2.color = @"黄色";
    model2.size = @"L";
    model2.shop_id = @"2";
    model2.shop_name = @"多啦衣梦";
    
    YYGoodsModel *model3 = [YYGoodsModel new];
    model3.brand = @"DVF";
    model3.image = @"woman20.jpg";
    model3.goodsID = @"0233";
    model3.name = @"线衣裙外套";
    
    model3.discountPrice = @"100.00";
    model3.currentPrice = @"300.00";
    model3.marketPrice = @"400.00";
    model3.color = @"白色";
    model3.size = @"L";
    model3.shop_id = @"3";
    model3.shop_name = @"女神派";
    
    YYGoodsModel *model4 = [YYGoodsModel new];
    model4.brand = @"DVF";
    model4.image = @"woman22.jpg";
    model4.goodsID = @"0234";
    model4.name = @"秋冬季呢子时尚外衣";
    
    model4.discountPrice = @"100.00";
    model4.currentPrice = @"300.00";
    model4.marketPrice = @"400.00";
    model4.color = @"白色";
    model4.size = @"L";
    model4.shop_id = @"5";
    model4.shop_name = @"衣二三";
    
    YYGoodsModel *model5 = [YYGoodsModel new];
    model5.brand = @"DVF";
    model5.image = @"woman27.jpg";
    model5.goodsID = @"0235";
    model5.name = @"线衣裙外套";
    
    model5.discountPrice = @"100.00";
    model5.currentPrice = @"300.00";
    model5.marketPrice = @"400.00";
    model5.color = @"白色";
    model5.size = @"L";
    model5.shop_id = @"5";
    model5.shop_name = @"衣二三";
    return @[model1, model2, model3, model4, model5];
    
}

+ (NSArray *)testWomanArray
{
    YYGoodsModel *model1 = [YYGoodsModel new];
    model1.brand = @"DVF";
    model1.image = @"woman19.jpg";
    model1.goodsID = @"0238";
    
    model1.discountPrice = @"100.00";
    model1.currentPrice = @"200.00";
    model1.marketPrice = @"300.00";
    model1.name = @"韩版时尚卫衣";
    model1.color = @"米色";
    model1.size = @"S";
    model1.shop_id = @"1";
    model1.shop_name = @"美丽租";
    
    YYGoodsModel *model2 = [YYGoodsModel new];
    model2.brand = @"DVF";
    model2.image = @"woman18.jpg";
    model2.goodsID = @"0232";
    
    model2.discountPrice = @"100.00";
    model2.currentPrice = @"500.00";
    model2.marketPrice = @"600.00";
    model2.name = @"秋冬季呢子时尚外衣";
    model2.color = @"黄色";
    model2.size = @"L";
    model2.shop_id = @"2";
    model2.shop_name = @"多啦衣梦";
    
    YYGoodsModel *model3 = [YYGoodsModel new];
    model3.brand = @"DVF";
    model3.image = @"woman37.jpg";
    model3.goodsID = @"0233";
    
    model3.discountPrice = @"100.00";
    model3.currentPrice = @"300.00";
    model3.marketPrice = @"400.00";
    model3.name = @"线衣裙外套";
    model3.color = @"白色";
    model3.size = @"L";
    model3.shop_id = @"3";
    model3.shop_name = @"女神派";
    
    YYGoodsModel *model4 = [YYGoodsModel new];
    model4.brand = @"DVF";
    model4.image = @"woman36.jpg";
    model4.goodsID = @"0234";
    
    model4.discountPrice = @"100.00";
    model4.currentPrice = @"300.00";
    model4.marketPrice = @"400.00";
    model4.name = @"秋冬季呢子时尚外衣";
    model4.color = @"白色";
    model4.size = @"L";
    model4.shop_id = @"5";
    model4.shop_name = @"衣二三";
    
    YYGoodsModel *model5 = [YYGoodsModel new];
    model5.brand = @"DVF";
    model5.image = @"woman29.jpg";
    model5.goodsID = @"0235";
    
    model5.discountPrice = @"100.00";
    model5.currentPrice = @"300.00";
    model5.marketPrice = @"400.00";
    model5.name = @"线衣裙外套";
    model5.color = @"白色";
    model5.size = @"L";
    model5.shop_id = @"5";
    model5.shop_name = @"衣二三";
    
    YYGoodsModel *model6 = [YYGoodsModel new];
    model6.brand = @"DVF";
    model6.image = @"woman28.jpg";
    model6.goodsID = @"0236";
    
    model6.discountPrice = @"100.00";
    model6.currentPrice = @"300.00";
    model6.marketPrice = @"400.00";
    model6.name = @"线衣裙外套";
    model6.color = @"白色";
    model6.size = @"L";
    model6.shop_id = @"5";
    model6.shop_name = @"衣二三";
    
    return @[model1, model2, model3, model4, model5, model6];
}

+ (NSArray *)testManArray
{
    YYGoodsModel *model1 = [YYGoodsModel new];
    model1.brand = @"DVF";
    model1.image = @"man05.jpg";
    model1.goodsID = @"0138";
    model1.name = @"男士西装黑色";
    
    model1.discountPrice = @"100.00";
    model1.currentPrice = @"200.00";
    model1.marketPrice = @"300.00";
    model1.color = @"米色";
    model1.size = @"S";
    model1.shop_id = @"1";
    model1.shop_name = @"美丽租";
    
    YYGoodsModel *model2 = [YYGoodsModel new];
    model2.brand = @"DVF";
    model2.image = @"man06.jpg";
    model2.goodsID = @"0132";
    model2.name = @"英伦风情";
    
    model2.discountPrice = @"100.00";
    model2.currentPrice = @"500.00";
    model2.marketPrice = @"600.00";
    model2.color = @"黄色";
    model2.size = @"L";
    model2.shop_id = @"2";
    model2.shop_name = @"多啦衣梦";
    
    YYGoodsModel *model3 = [YYGoodsModel new];
    model3.brand = @"DVF";
    model3.image = @"man07.jpg";
    model3.goodsID = @"0133";
    model3.name = @"男士西装白色";
    
    model3.discountPrice = @"100.00";
    model3.currentPrice = @"300.00";
    model3.marketPrice = @"400.00";
    model3.color = @"白色";
    model3.size = @"L";
    model3.shop_id = @"3";
    model3.shop_name = @"女神派";
    
    YYGoodsModel *model4 = [YYGoodsModel new];
    model4.brand = @"DVF";
    model4.image = @"man08.jpg";
    model4.goodsID = @"0134";
    model4.name = @"男士西装蓝色";
    
    model4.discountPrice = @"100.00";
    model4.currentPrice = @"300.00";
    model4.marketPrice = @"400.00";
    model4.color = @"白色";
    model4.size = @"L";
    model4.shop_id = @"5";
    model4.shop_name = @"衣二三";
    
    YYGoodsModel *model5 = [YYGoodsModel new];
    model5.brand = @"DVF";
    model5.image = @"man06.jpg";
    model5.goodsID = @"0135";
    model5.name = @"时尚男士西装";
    
    model5.discountPrice = @"100.00";
    model5.currentPrice = @"300.00";
    model5.marketPrice = @"400.00";
    model5.color = @"白色";
    model5.size = @"L";
    model5.shop_id = @"5";
    model5.shop_name = @"衣二三";
    
    YYGoodsModel *model6 = [YYGoodsModel new];
    model6.brand = @"DVF";
    model6.image = @"man08.jpg";
    model6.goodsID = @"0136";
    model6.name = @"韩版西装";
    model6.color = @"白色";
    model6.size = @"L";
    model6.shop_id = @"5";
    model6.shop_name = @"衣二三";
    model6.discountPrice = @"100.00";
    model6.currentPrice = @"300.00";
    model6.marketPrice = @"400.00";
    
    return @[model1, model2, model3, model4, model5, model6];
}

+ (NSArray *)testChildArray
{
    YYGoodsModel *model1 = [YYGoodsModel new];
    model1.brand = @"DVF";
    model1.image = @"child04.jpg";
    model1.goodsID = @"0338";
    model1.currentPrice = @"300.00";
    model1.shop_name = @"衣二三";
    model1.name = @"秋冬装";
    
    YYGoodsModel *model2 = [YYGoodsModel new];
    model2.brand = @"DVF";
    model2.image = @"child07.jpg";
    model2.goodsID = @"0332";
    model2.currentPrice = @"300.00";
    model2.shop_name = @"美丽租";
    model2.name = @"秋冬装";
    
    YYGoodsModel *model3 = [YYGoodsModel new];
    model3.brand = @"DVF";
    model3.image = @"child06.jpg";
    model3.goodsID = @"0333";
    model3.currentPrice = @"300.00";
    model3.shop_name = @"女神派";
    model3.name = @"秋冬装";
    
    YYGoodsModel *model4 = [YYGoodsModel new];
    model4.brand = @"DVF";
    model4.image = @"child08.jpg";
    model4.goodsID = @"0334";
    model4.currentPrice = @"300.00";
    model4.shop_name = @"衣二三";
    model4.name = @"秋冬装";
    
    YYGoodsModel *model5 = [YYGoodsModel new];
    model5.brand = @"DVF";
    model5.image = @"child09.jpg";
    model5.goodsID = @"0335";
    model5.currentPrice = @"300.00";
    model5.shop_name = @"衣二三";
    model5.name = @"秋冬装";
    
    YYGoodsModel *model6 = [YYGoodsModel new];
    model6.brand = @"DVF";
    model6.image = @"child10.jpg";
    model6.goodsID = @"0336";
    model6.currentPrice = @"300.00";
    model6.shop_name = @"衣二三";
    model6.name = @"秋冬装";
    
    return @[model1, model2, model3, model4, model5, model6];
}

- (void)setFile:(NSDictionary *)file
{
    _file = file;
    YYImageFileModel *model = [YYImageFileModel mj_objectWithKeyValues:file];
    _imagePath = model.filePath;
}

@end
