//
//  YYUserLocationAnnotation.m
//  Fastbike
//
//  Created by YZ Y on 2017/6/12.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYUserLocationAnnotation.h"

@implementation YYUserLocationAnnotation
- (instancetype)init {
    if (self = [super init]) {
        self.showsAccuracyRing = NO;
        self.enablePulseAnnimation = NO;
        self.showsHeadingIndicator = NO;
//        self.image = [UIImage imageNamed:@""];
        self.locationDotFillColor = YYGlobalColor;
        self.locationDotBgColor = [UIColor whiteColor];
        self.strokeColor = [UIColor clearColor];
        self.lineWidth = 0.5;
    }
    return self;
}
@end
