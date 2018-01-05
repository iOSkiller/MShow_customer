//
//  YYHtmlHandle.m
//  DDFood
//
//  Created by YZ Y on 16/10/26.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYHtmlHandle.h"
//#import "YYGoodsModel.h"

@implementation YYHtmlHandle
//+ (NSString *)executeHtmlStringFromGoodsModel:(YYGoodsModel *)goodsModel
//{
//    NSMutableString *html = [NSMutableString string];
//    [html appendString:@"<html>"];
//    [html appendString:@"<head>"];
//    //获取本地css配置文件
//    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"HtmlDetails.css" withExtension:nil]];
//    [html appendString:@"</head>"];
//    
//    [html appendString:@"<body id=\"detailImages\">"];
//    [html appendString:[self createImageList:goodsModel]];
//    [html appendString:@"</body>"];
//    
//    [html appendString:@"</html>"];
//    return html;
//}
//
//+ (NSString *)createImageList:(YYGoodsModel *)goodsModel
//{
//    /*
//     * css方式占用内存少
//     * WIN_WIDTH*0.96 图片宽度
//     * 只要修改图片的宽度或高度，web中的图片就会进行缩放处理
//     */
//    NSMutableString *imgListStr = [NSMutableString string];
//    NSArray *imageArray = goodsModel.details;
//    if (imageArray.count > 1) {
//        for (int i = 0; i < imageArray.count; i ++) {
//            NSString *str = nil;
//            NSString *imageURL = imageArray[i];
//            if (i == 0) {
//                NSString *weight = goodsModel.min_weight == nil ? AppendString(goodsModel.weight, @"kg") : [NSString stringWithFormat:@"%@-%@kg", goodsModel.min_weight, goodsModel.max_weight];
//                //在图片右侧显示一个商品规格的列表
//                NSArray *leftInfoArray = @[@"商品名称：", @"商品品牌：", @"产品净重：", @"产地：", @"生产日期：", @"建议存储方法：",];
//                NSArray *rightInfoArray = @[goodsModel.name, goodsModel.brand, weight, @"南京", @"见包装", @"冷藏"];
//                NSMutableString *infoLeftListStr = [NSMutableString string];
//                NSMutableString *infoRightListStr = [NSMutableString string];
//                for (int j = 0; j < leftInfoArray.count; j ++) {
//                    NSString *backgroundColor = ((j + 1) % 2 == 0) ? @"rgb(239,239,239)" : @"rgb(255,255,255)";
//                    NSString *leftliStr = [NSString stringWithFormat:@"<li style=\"background-color:%@;text-align: right; font-size: %fpx;color:black;\">%@</li>", backgroundColor,RELATIVE_WIDTH(20), leftInfoArray[j]];
//                    NSString *rightliStr = [NSString stringWithFormat:@"<li style=\"background-color: %@;text-align: left;text-indent:1em;font-size: %fpx;color:black;\">%@</li>", backgroundColor, RELATIVE_WIDTH(20), rightInfoArray[j]];
//                    [infoLeftListStr appendString:leftliStr];
//                    [infoRightListStr appendString:rightliStr];
//                }
//                CGFloat ulWidth = (win_width / 2 - RELATIVE_WIDTH(24) - RELATIVE_WIDTH(8)) / 2;
//                NSString *infoUlStr = [NSString stringWithFormat:@"<ul style=\"left:%fpx;width:%fpx;top:40px;\" class=\"infoUL\">%@</ul>", win_width / 2 - RELATIVE_WIDTH(24), ulWidth, infoLeftListStr];
//                NSString *infoUlStr2 = [NSString stringWithFormat:@"<ul style=\"left:%fpx;width:%fpx;top:40px;\" class=\"infoUL\">%@</ul>", win_width / 2 - RELATIVE_WIDTH(24) + ulWidth + RELATIVE_WIDTH(8), ulWidth, infoRightListStr];
//                str = [NSString stringWithFormat:@"<li style=\"position: relative;\"><img style=\"max-width:%fpx;margin-bottom:-5px;\" src=\"%@\"/>%@%@</li>", win_width, imageURL, infoUlStr, infoUlStr2];
//            } else {
//                str = [NSString stringWithFormat:@"<li><img style=\"max-width:%fpx; margin-bottom:-5px;\" src=\"%@\"/></li>", win_width, imageURL];
//            }
//            [imgListStr appendString:str];
//        }
//    } else {
//        [imgListStr appendString:[NSString stringWithFormat:@"<li><img style=\"max-width:%fpx; margin-bottom:-5px;\" src=\"%@\"/></li>", win_width, @"https://www.u10w.com/Images/Goods_details/linshi.jpg"]];
//    }
//    NSString *body = [NSString stringWithFormat:@"<ul>%@</ul>", imgListStr];
//    return body;
//}
//
//+ (NSString *)executeImageString:(NSString *)imageURL imageWidth:(CGFloat)imageWidth
//{
//    NSMutableString *html = [NSMutableString string];
//    [html appendString:@"<html>"];
//    [html appendString:@"<head>"];
//    [html appendString:@"<body>"];
//    NSString *imageStr = [NSString stringWithFormat:@"<img style=\"max-width:%fpx;\" src=\"%@\"/>", imageWidth, imageURL];
//    [html appendString:imageStr];
//    [html appendString:@"</body>"];
//    [html appendString:@"</html>"];
//    return html;
//}

@end
