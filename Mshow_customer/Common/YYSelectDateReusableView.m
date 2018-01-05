//
//  YYSelectDateReusableView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/27.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectDateReusableView.h"
#import "YYCollectionViewLayoutAttributes.h"
@implementation YYSelectDateReusableView
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[YYCollectionViewLayoutAttributes class]]) {
        YYCollectionViewLayoutAttributes *attr = (YYCollectionViewLayoutAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;
    }
}

@end
