//
//  YYShopModel.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYShopModel : NSObject
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, copy) NSArray *goodsArray;
@property (nonatomic, copy) NSArray *imageArray;

@property (nonatomic, copy) NSString *saleCount;

@property (nonatomic, copy) NSString *duration;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *delivery_duration;
@property (nonatomic, copy) NSString *phone;

/**商铺id*/
@property (nonatomic, copy) NSString *shopId;
/**商铺所有人id*/
@property (nonatomic, copy) NSString *merchantId;
/**商铺名称*/
@property (nonatomic, copy) NSString *shopName;
/**商铺背景图*/
@property (nonatomic, copy) NSString *shopImgUrl;
/**商铺等级，默认为1*/
@property (nonatomic, copy) NSString *shopLevel;
/**商铺资金*/
@property (nonatomic, copy) NSString *shopCapital;
/**商铺信用积分，默认100*/
@property (nonatomic, copy) NSString *creditPoint;
/**商铺手机号码*/
@property (nonatomic, copy) NSString *shopPhone;
/**固定电话*/
@property (nonatomic, copy) NSString *shopTelephone;
/**营业执照注册号*/
@property (nonatomic, copy) NSString *shopLicenceNo;
/**营业期限起始时间*/
@property (nonatomic, copy) NSString *limitStartTime;
/**营业期限结束时间*/
@property (nonatomic, copy) NSString *limitEndTime;
/**营业执照照片URL*/
@property (nonatomic, copy) NSString *shopLicenceUrl;
/**手持身份证URL*/
@property (nonatomic, copy) NSString *handCardUrl;
/**身份证正面URL*/
@property (nonatomic, copy) NSString *frontCardUrl;
/**身份证反面URL*/
@property (nonatomic, copy) NSString *reverseCardUrl;
/**经度*/
@property (nonatomic, copy) NSString *longitude;
/**纬度*/
@property (nonatomic, copy) NSString *latitude;
/**是否停业,0停业，1开业*/
@property (nonatomic, copy) NSString *stopStatus;
/**是否推荐,默认0，0不推荐，1推荐*/
@property (nonatomic, copy) NSString *recommendStatus;
/**清洗中心id*/
@property (nonatomic, copy) NSString *cleanId;
/**店铺分类,0为第三方，1为自营*/
@property (nonatomic, copy) NSString *shopClassify;
/**代理商id*/
@property (nonatomic, copy) NSString *agentId;
/**店铺正面照*/
@property (nonatomic, copy) NSString *shopPositiveImg;
/**是否冻结,默认0冻结，1正常*/
@property (nonatomic, copy) NSString *shopIsLock;
/**是否打烊,默认0打烊，1不打烊*/
@property (nonatomic, copy) NSString *closeStatus;
/**审核状态,默认为0，0为待审核，1为审核通过，2为审核不通过*/
@property (nonatomic, copy) NSString *auditStatus;
/**记录状态*/
@property (nonatomic, copy) NSString *recordState;
/**店铺展示商品图片数组*/
@property (nonatomic, copy) NSArray *shopImgs;
/**店铺商品数量*/
@property (nonatomic, copy) NSString *goodsCount;
/**店铺收藏人数*/
@property (nonatomic, copy) NSString *collectCount;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) NSUInteger selectedCount;
@property (nonatomic, assign) BOOL isCouponed;

+ (NSArray *)testDataArray;
+ (NSArray *)testWashShopAarray;

@end
