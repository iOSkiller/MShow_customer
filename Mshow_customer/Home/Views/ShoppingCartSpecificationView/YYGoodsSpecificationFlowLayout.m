//
//  YYGoodsSpecificationFlowLayout.m
//  DDFood
//
//  Created by YZ Y on 16/11/29.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import "YYGoodsSpecificationFlowLayout.h"

@implementation YYGoodsSpecificationFlowLayout

- (instancetype)init
{
    if (self = [super init]) {
        self.maximumInteritemSpacing = 8.f;
    }
    return self;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //使用系统帮我们计算好的结果。
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    if (attributes.count == 1) {
        UICollectionViewLayoutAttributes *curAttr = [attributes lastObject];
        CGFloat originX = CGRectGetMaxX(curAttr.frame);
        if (originX > RELATIVE_WIDTH(20)) {
            CGRect frame = curAttr.frame;
            frame.origin.x = RELATIVE_WIDTH(20);
            curAttr.frame = frame;
        }
        return attributes;
    }
    for(int i = 0; i < [attributes count]; i ++) {
        if (i == 0) {
            UICollectionViewLayoutAttributes *curAttr = [attributes firstObject];
            CGRect frame = curAttr.frame;
            frame.origin.x = RELATIVE_WIDTH(20);
            curAttr.frame = frame;
        } else {
            //第0个cell没有上一个cell，所以从1开始
            //这里 UICollectionViewLayoutAttributes 的排列总是按照 indexPath的顺序来的。
            UICollectionViewLayoutAttributes *curAttr = attributes[i];
            UICollectionViewLayoutAttributes *preAttr = attributes[i - 1];
            NSInteger currentY = CGRectGetMinY(curAttr.frame);
            NSInteger origin = CGRectGetMaxX(preAttr.frame);
            //根据  maximumInteritemSpacing 计算出的新的 x 位置
            CGFloat targetX = currentY > preAttr.frame.origin.y ? RELATIVE_WIDTH(20) : origin + _maximumInteritemSpacing;
            // 只有系统计算的间距大于  maximumInteritemSpacing 时才进行调整
            if (CGRectGetMinX(curAttr.frame) > targetX) {
                // 换行时不用调整
                if (targetX + CGRectGetWidth(curAttr.frame) < self.collectionViewContentSize.width) {
                    CGRect frame = curAttr.frame;
                    frame.origin.x = targetX;
                    curAttr.frame = frame;
                }
            }
        }
    }
    return attributes;
}

@end
