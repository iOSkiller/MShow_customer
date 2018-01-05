//
//  YYGoodsSpecificationModel.h
//  DDFood
//
//  Created by YZ Y on 16/11/28.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, YYGoodsSpecificationType) {
    YYGoodsSpecificationTypeSpec,
    YYGoodsSpecificationTypeSize,
};

@interface YYGoodsSpecificationModel : NSObject
@property (nonatomic, copy) NSDictionary *price_info;
@property (nonatomic, copy) NSString *spec_content;
/**规格编号*/
@property (nonatomic, copy) NSString *specid;
/**规格价格*/
@property (nonatomic, copy) NSString *price;
/**原价*/
@property (nonatomic, copy) NSString *original_price;
/**规格描述*/
@property (nonatomic, copy) NSString *name;
/**价格*/
@property (nonatomic, copy) NSString *currentPrice;
/**备注*/
@property (nonatomic, copy) NSString *notes;
/**净重*/
@property (nonatomic, copy) NSString *weight;
/**单位*/
@property (nonatomic, copy) NSString *unit;
/**库存*/
@property (nonatomic, copy) NSString *stock;
/**是否是秒杀商品 2是秒杀商品*/
@property (nonatomic, assign) NSInteger prom_type;

@property (nonatomic, copy) NSString *begintime;
@property (nonatomic, copy) NSString *discounttime;
@property (nonatomic, copy) NSString *nowtime;

@property (nonatomic, assign) CGFloat spec_width;
@property (nonatomic, assign) CGFloat spec_height;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) YYGoodsSpecificationType type;

+ (NSArray *)testSpecDataArray;
+ (NSArray *)testSizeDataArray;

@end
