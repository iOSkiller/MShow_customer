//
//  YYGoodsModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYGoodsModel : NSObject
@property (nonatomic, copy) NSString *goodsID;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *brand;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *spec_notes;
@property (nonatomic, copy) NSString *spec;
@property (nonatomic, copy) NSString *stockcounts;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *currentPrice;
@property (nonatomic, copy) NSString *marketPrice;
@property (nonatomic, copy) NSString *discountPrice;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, copy) NSString *shop_name;
/**商品id*/
@property (nonatomic, copy) NSString *goodsId;
/**店铺id*/
@property (nonatomic, copy) NSString *shopId;
/**商品名*/
@property (nonatomic, copy) NSString *goodsName;
/**商品类型(0零售；1租赁)*/
@property (nonatomic, copy) NSString *goodsType;
/**商品价格*/
@property (nonatomic, copy) NSString *goodsPrice;
/**剪标费*/
@property (nonatomic, copy) NSString *cutBrandPrice;
/**二级分类id*/
@property (nonatomic, copy) NSString *classifyId;
/**简介*/
@property (nonatomic, copy) NSString *profile;
/**场合id*/
@property (nonatomic, copy) NSString *occasionId;
/**是否热门，默认0，正常，1热门*/
@property (nonatomic, copy) NSString *hotStatus;
/**库存*/
@property (nonatomic, copy) NSString *stock;
/**上下架，默认0，下架，1上架*/
@property (nonatomic, copy) NSString *putaway;
/**销量*/
@property (nonatomic, copy) NSString *salesVolume;
/**文件id*/
@property (nonatomic, copy) NSString *fileId;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) UIImage *finialImage;
@property (nonatomic, copy) NSDictionary *file;
@property (nonatomic, copy) NSString *imagePath;

+ (NSArray *)testDataArray;
+ (NSArray *)testWomanArray;
+ (NSArray *)testManArray;
+ (NSArray *)testChildArray;

@end
