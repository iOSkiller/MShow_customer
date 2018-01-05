//
//  YYArrowView.m
//  DDFood
//
//  Created by YZ Y on 16/10/18.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYArrowView.h"

@implementation YYArrowView

{
    UIColor *_fillColor;
    YYArrowViewDirection _direction;
}

- (instancetype)initWithFrame:(CGRect)frame fillColor:(UIColor *)fillColor direction:(YYArrowViewDirection)direction
{
    if (self = [super initWithFrame:frame]) {
        _fillColor = fillColor;
        _direction = direction;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    [self layoutIfNeeded];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
//    [self drawArrowRectangle:rect];
    //定义画图的path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(0, 0);
    CGPoint point3 = CGPointMake(0, 0);
    
    switch (_direction) {
        case YYArrowViewDirectionUP:
        {
            point1 = CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height);
            point2 = CGPointMake(rect.origin.x, rect.origin.y);
            point3 = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
        }
            break;
        case YYArrowViewDirectionDown:
        {
            point1 = CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height);
            point2 = CGPointMake(rect.origin.x, rect.origin.y);
            point3 = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
        }
            break;
        case YYArrowViewDirectionLeft:
        {
            point1 = CGPointMake(rect.origin.x, rect.size.height / 2);
            point2 = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
            point3 = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
        }
            break;
        case YYArrowViewDirectionRight:
        {
            point1 = CGPointMake(rect.origin.x + rect.size.width, rect.size.height / 2);
            point2 = CGPointMake(rect.origin.x, rect.origin.y);
            point3 = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
        }
            break;
        default:
            break;
    }
    
    //path移动到开始画图的位置point1
    [path moveToPoint:point1];
    //从开始位置画一条直线到point2
    [path addLineToPoint:point2];
    //再从point2画一条线到point3
    [path addLineToPoint:point3];
    
    //关闭path
    [path closePath];
    
    if (_fillColor) {
        //三角形内填充颜色
        [_fillColor setFill];
        
        [path fill];
    }
    
    if (_strokeColor) {
        //设置线宽
        path.lineWidth = RELATIVE_WIDTH(2);
        //线条拐角
        path.lineCapStyle = kCGLineCapRound;
        //终点处理
        path.lineJoinStyle = kCGLineJoinRound;
        [_strokeColor setStroke];
        [path stroke];
    }
    
}

- (void)drawArrowRectangle:(CGRect)frame
{
    // 获取当前图形，视图推入堆栈的图形，相当于所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 创建一个新的空图形路径。
    CGContextBeginPath(ctx);
    
    //启始位置坐标x，y
    CGFloat origin_x = frame.origin.x;
    CGFloat origin_y = frame.origin.y;
    
    if (_type == YYArrowViewTypeBlock) {
//        CGFloat begin_x = origin_x;
//        CGFloat begin_y = origin_y + RELATIVE_WIDTH(14);
//        
//        CGFloat left_bottom_x = begin_x;
//        CGFloat left_bottom_y = frame.size.height;
//        
//        CGFloat right_bottom_x = frame.size.width;
//        CGFloat right_bottom_y = left_bottom_y;
//        
//        CGFloat right_top_x = frame.size.width;
//        CGFloat right_top_y = begin_y;
//        
//        CGFloat line1_x = frame.size.width - RELATIVE_WIDTH(26);
//        CGFloat line1_y = right_top_y;
//        
//        CGFloat arrow_x = line1_x - RELATIVE_WIDTH(14);
//        CGFloat arrow_y = origin_y;
//        
//        CGFloat end_x = arrow_x - RELATIVE_WIDTH(14);
//        CGFloat end_y = origin_y + RELATIVE_WIDTH(14);
//        
//        
//        CGContextMoveToPoint(ctx, begin_x, begin_y);
//        CGContextAddLineToPoint(ctx, left_bottom_x, left_bottom_y);
//        CGContextAddLineToPoint(ctx, right_bottom_x, right_bottom_y);
//        CGContextAddLineToPoint(ctx, right_top_x, right_top_y);
//        CGContextAddLineToPoint(ctx, line1_x, line1_y);
//        CGContextAddLineToPoint(ctx, arrow_x, arrow_y);
//        CGContextAddLineToPoint(ctx, end_x, end_y);
//        CGContextAddLineToPoint(ctx, begin_x, begin_y);
//        CGContextClosePath(ctx);
//        //填充色
//        UIColor *customColor = [UIColor orangeColor];
//        CGContextSetFillColorWithColor(ctx, customColor.CGColor);
        
        // 获取当前图形，视图推入堆栈的图形，相当于你所要绘制图形的图纸
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        // 创建一个新的空图形路径。
        CGContextBeginPath(ctx);
        //启始位置坐标x，y
        CGFloat origin_x = frame.origin.x;
        CGFloat origin_y = frame.origin.y + RELATIVE_WIDTH(16);
        //第一条线的位置坐标
        CGFloat line_1_x = frame.size.width - RELATIVE_WIDTH(48);
        CGFloat line_1_y = origin_y;
        //尖角的顶点位置坐标
        CGFloat line_2_x = line_1_x + RELATIVE_WIDTH(12);
        CGFloat line_2_y = 0.0;
        //第三条线的位置坐标
        CGFloat line_3_x = line_2_x + RELATIVE_WIDTH(12);
        CGFloat line_3_y = origin_y;
        //第四条线
        CGFloat line_4_x = frame.size.width;
        CGFloat line_4_y = origin_y;
        //第五条线位置坐标
        CGFloat line_5_x = line_4_x;
        CGFloat line_5_y = frame.size.height;
        //第六条线位置坐标
        CGFloat line_6_x = origin_x;
        CGFloat line_6_y = frame.size.height;
        
        CGContextMoveToPoint(ctx, origin_x, origin_y);
        
        CGContextAddLineToPoint(ctx, line_1_x, line_1_y);
        CGContextAddLineToPoint(ctx, line_2_x, line_2_y);
        CGContextAddLineToPoint(ctx, line_3_x, line_3_y);
        CGContextAddLineToPoint(ctx, line_4_x, line_4_y);
        CGContextAddLineToPoint(ctx, line_5_x, line_5_y);
        CGContextAddLineToPoint(ctx, line_6_x, line_6_y);
        
        CGContextClosePath(ctx);
        
        UIColor *costomColor = [UIColor colorWithWhite:0 alpha:0.8];
        CGContextSetFillColorWithColor(ctx, costomColor.CGColor);
        
        CGContextFillPath(ctx);
    
    }
    
    if (_type == YYArrowViewTypeLine) {
        
        CGFloat begin_x = origin_x + RELATIVE_WIDTH(40);
        CGFloat begin_y = origin_y + frame.size.height;
        
        CGFloat arrow1_x = begin_x + RELATIVE_WIDTH(10);
        CGFloat arrow1_y = 0.0;
        
        CGFloat arrow2_x = arrow1_x + RELATIVE_WIDTH(10);
        CGFloat arrow2_y = origin_y + frame.size.height;
        
        CGFloat end_x = origin_x + frame.size.width;
        CGFloat end_y = origin_y + frame.size.height;
        
        //移动画笔
        CGContextMoveToPoint(ctx, origin_x, begin_y);
        //画线
        CGContextAddLineToPoint(ctx, begin_x, begin_y);
        CGContextAddLineToPoint(ctx, arrow1_x, arrow1_y);
        CGContextAddLineToPoint(ctx, arrow2_x, arrow2_y);
        CGContextAddLineToPoint(ctx, end_x, end_y);
        
        
        [_borderColor set]; // 设置颜色
        CGContextSetLineWidth(ctx, RELATIVE_WIDTH(1)); // 线的宽度
        //空心不填充
        CGContextStrokePath(ctx);
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self layoutIfNeeded];
}

- (void)setType:(YYArrowViewType)type
{
    _type = type;
    [self layoutIfNeeded];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    [self layoutIfNeeded];
}

@end
