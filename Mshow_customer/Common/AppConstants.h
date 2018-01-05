//
//  AppConstants.h
//  CardMaster
//
//  Created by Lyner on 13-7-9.
//  Copyright (c) 2013年 GL. All rights reserved.
//
 
#import <Foundation/Foundation.h>

#pragma mark - 功能定义区

#define ShareSDKAPPKey @"8887dee00f9c"
#define ShareSDKAPPSecret @"wx7e2142b7b4f7d2b7"
#define WeiXinID @"wx7e2142b7b4f7d2b7"
#define WeiXinScrect @"ce011a415af51f633f4859c9a56f47c4"

#define CertifyInfo @"希望您如实填写个人信息作为凭证。M秀现已与某银行征信中心合作，您如果产生长时间滞留单品等失信违约行为，可能会录入您在上述机构的个人征信记录，请珍惜您的个人信用。"

#define CommodityConsult @"1"   //商品咨询
#define InformationService @"2"   //咨询服务

/**
 *   颜色定义
 */
// tableview  cell 的底色
#define kCellBgColor  0xE6E0D4
// tableview cell 文字颜色
#define kCellTextColor 0x7D7A69
//导航栏背景色
#define kNavBarBackColor mRGBToColor(0xe74e3e)


// 数据库文件名称
#define kDefaultDBName  @"shhy_scangain_app.db"

// 检索历史的 检索来源类型,  CODE  , KEYWORD
#define kSearchType_Scan @"SCAN"
#define kSearchType_Keyword @"KEYWORD"



#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 常用的宏定义
#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
    CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define WIN_SIZE [UIScreen mainScreen].bounds.size
#define WIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define WIN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define IS_IPHONE6_LATER ((WIN_WIDTH >= 375 && WIN_HEIGHT >= 667) == YES ? YES:NO)
#define NAV_BAR_BACK_IMG @"banner"


// 把16进制的颜色转成UIColor对象 
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#pragma mark - HTTP请求定义区


// 与服务器连接超时设定
#define WSURL_TIMEOUT 60

// Frame的快捷操作
static inline CGFloat GG_X(UIView *view){ return view.frame.origin.x;}
static inline CGFloat GG_Y(UIView *view){ return view.frame.origin.y;}
static inline CGFloat GG_W(UIView *view){ return view.frame.size.width;}
static inline CGFloat GG_H(UIView *view){ return view.frame.size.height;}
static inline CGFloat GG_BOTTOM_Y(UIView *view){ return GG_Y(view) + GG_H(view);};
static inline CGFloat GG_RIGHT_X(UIView *view){ return GG_X(view) + GG_W(view);};
// 快捷方式
#define ccp(x,y) CGPointMake(x, y)
#define ccs(x,y) CGSizeMake(x, y)
#define ccr(x,y,w,h) CGRectMake(x,y,w,h)
#define AppendString(str1, str2) [NSString stringWithFormat:@"%@%@", str1, str2]

#define BASE_WIDTH  750.0
#define BASE_HEIGHT 1334.0

#define RELATIVE_WIDTH(w) WIN_WIDTH/BASE_WIDTH * w
#define RELATIVE_HEIGHT(h) WIN_HEIGHT/BASE_HEIGHT * h

//图片加载打开还是关闭
#define ISDFNetReachableViaClose @"ISDFNetReachableViaClose"

//没有昵称 统一改成 智慧社区用户
#define AppNoneUserNickname @"智慧社区业主"
#define IsDeveloping @"程序猿正在努力开发中，敬请期待..."
#define NoneNetworkCode 201601121531
#define MedicineReminderSaveLocationName @"20160114110400"

//每个小区固定的物业ID
//#define AppPropertyCode @"TEST_CODE" // 物业Code
