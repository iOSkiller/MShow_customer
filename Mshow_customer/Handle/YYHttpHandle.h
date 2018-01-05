//
//  YYHttpHandle.h
//  DDFood
//
//  Created by YZ Y on 16/6/4.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYBaseHandle.h"

#define UserUrl @""
//#define BaseURL @"http://192.168.1.191:8080/mshow_mobile/"
//#define BaseURL @"http://192.168.1.188:8080/mshow_mobile/"
//#define BaseURL @"http://192.168.1.169:8080/mshow_mobile/"
#define BaseURL @"http://101.132.67.18:80/mshow_mobile/"

#define Md5Sign @""
#define AdsImgUrl @""
#define SmallAdsImgUrl @""

#pragma mark 首页接口
/**首页轮播*/
#define homeBanner @"home/index"
/**每周爆品*/
#define weekyHotGoods @"home/hot/goods"
/**每周新品*/
#define weekyNewGoods @"home/new/goods"

#pragma mark 用户账号相关接口
/**登录接口*/
#define login @"login/accessLogin"
/**用户注册*/
#define certifyPhone @"registeruser/save"
/**注册手机验证码*/
#define registerPhoneCode @"registeruser/verifyCode"
/**充值密码手机验证码*/
#define resetPasswordPhoneCode @"login/newPwdByVerifyCode"
/**注册接口*/
#define registerAccount @"registeruser/save"
/**重置密码*/
#define resetPassword @"login/saveNewPwd"
/**完善个人信息*/

#pragma mark 结算中心
/**结算*/
#define settleDeal @"buyer/clearing/center"
/**生成订单*/
#define makeDeal @"order/make/totalOrder"

#pragma mark 订单相关
/**获取订单列表*/
#define getDeal @"order/order/type"
/**修改订单状态*/
#define changeDeal @"order/modify/type"
/**确认订单*/
#define submitDeal @"buyer/affirmOrder"
/**订单详情*/
#define dealDeatil @"order/getorder/shopId"

#pragma mark 地址相关接口
/**收货地址列表*/
#define addressGuery @"address/query"
/**保存收货地址*/
#define addressSave @"address/save"
/**编辑收货地址*/
#define addressEdite @"address/edit"
/**移除收货地址*/
#define addressRemove @"address/remove"


#pragma mark 店铺相关接口
/**店铺收藏列表*/
#define shopCollectQuery @"shop/collect/query"
/**收藏店铺*/
#define shopCollect @"shop/collect/save"
/**取消店铺收藏*/
#define shopRemove @"shop/collect/remove"
/**店铺首页*/
#define shopInfo @"shop/homepage"

#pragma mark 商品相关接口
/**商品收藏列表*/
#define goodsCollectQuery @"goods/collect/query"
/**收藏商品*/
#define goodsCollect @"goods/collect/save"
/**取消商品收藏*/
#define goodsRemove @"goods/collect/remove"
/**商品详情*/
#define goodsDetail @"goods/detail"

#pragma mark 支付相关接口
/**支付宝订单接口*/
#define alipayOrder @"pay/pay"
/**支付宝成功接口*/
#define alipaySuccess @"pay/getPaySuccess"

typedef void (^RequestSuccess)(id json);
typedef void (^RequestFailure)(int statusCode, int errorCode);
typedef void (^NekworkStatus)(NSString *nekworkStatus);

typedef void (^HTTPRequestV2SuccessBlock)(id responseObject);
typedef void (^HTTPRequestV2FailedBlock)(NSError *error);

@interface YYHttpHandle : YYBaseHandle
+ (NSURLSessionDataTask *)GET:(NSString *)url params:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;

+ (NSURLSessionDataTask *)POST:(NSString *)url params:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;

+ (void)checkNetWorkStatus:(NekworkStatus)nekworkStatus;

+ (void)requestWithUploadPictureWithUrl:(NSString*)URLString params:(NSDictionary *)params name:(NSString *)name imageData:(NSData *)imageData successBlock:(HTTPRequestV2SuccessBlock)successReqBlock failedBlock:(HTTPRequestV2FailedBlock)failedReqBlock;

+ (void)cancelAllRequest;
+ (void)cancelSingleTask:(NSString *)key;

@end
