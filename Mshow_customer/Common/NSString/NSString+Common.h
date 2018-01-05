//
//  NSString+Common.h
//  YC-ZHSQ
//
//  Created by chen on 15/11/12.
//  Copyright © 2015年 JSYC-iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

-(BOOL)isBlank;// Checking if String is Empty
-(BOOL)isValid;//Checking if String is empty or nil
- (NSString *)removeWhiteSpacesFromString;// remove white spaces from String


- (NSUInteger)countNumberOfWords;// Counts number of Words in String
- (BOOL)containsString:(NSString *)subString;
- (BOOL)isBeginsWith:(NSString *)string;
- (BOOL)isEndssWith:(NSString *)string;

- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar;
- (NSString *)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;
- (NSString *)addString:(NSString *)string;
- (NSString *)removeSubString:(NSString *)subString;

- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;
- (BOOL)isInThisarray:(NSArray*)array;

+ (NSString *)getStringFromArray:(NSArray *)array;
- (NSArray *)getArray;

+ (NSString *)getMyApplicationVersion;
+ (NSString *)getMyApplicationName;

- (NSData *)convertToData;
+ (NSString *)getStringFromData:(NSData *)data;

- (BOOL)isValidEmail;
- (BOOL)isVAlidPhoneNumber;
- (BOOL)isValidUrl;

- (CGRect)getStringRect:(UIFont*)font size:(CGSize)size;
//获取字符串宽高
- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (NSString*)paraseEmptyString;//解析空的字符串

//讲Json字符串转化为字典
- (NSDictionary *)dictionaryWithJsonString;



// 将字符串编码 NSUTF8StringEncoding
- (NSString *)addUTF8UsingEncoding;
// 将字符串反编码 NSUTF8StringEncoding
- (NSString *)replacingUTF8UsingEncoding;
// 删除字符串内的系统表情
- (NSString *)clearSystemEmotion;
// 判断字符串是否含有系统表情
- (BOOL)filterEmoji;
//数字转中文
- (NSString *)translateNumberToChinese;

/**时间戳转化 yy-MM-dd HH:mm:ss*/
+ (NSString *)dateFromTimestamp:(NSString *)timestamp;
+ (NSString *)timestampFromDate:(NSDate *)date;

/**获取当前日期 默认yyyy-MM-dd HH:mm:ss*/
+ (NSString *)currentDate:(NSString *)dateFormate;
/**将日期格式的转为 2015-12-08 24:00:00 转为20151208240000*/
- (NSString *)getDateString;

//32位md5加密
+ (NSString *)getMD5_32bitString:(NSString *)str;

/**字符串转16进制*/
+ (NSString *)hexStringFromString:(NSString *)string;

+ (NSAttributedString *)str1:(NSString *)str1 font1:(UIFont *)font1 color1:(UIColor *)color1 str2:(NSString *)str2 font2:(UIFont *)font2 color2:(UIColor *)color2;

+ (NSAttributedString *)stringsArray:(NSArray <NSString *> *)stringsArray fontsArray:(NSArray <UIFont *> *)fontsArray colorsArray:(NSArray <UIColor *> *)colorArray;

/******************************************************************************
 函数名称 : + (NSString *)base64StringFromText:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64StringFromText:(NSString *)text;

/******************************************************************************
 函数名称 : + (NSString *)textFromBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 输出参数 : N/A
 返回参数 : (NSString *)    文本
 备注信息 :
 ******************************************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64;



@end
