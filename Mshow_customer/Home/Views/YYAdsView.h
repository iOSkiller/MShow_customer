//
//  YYAdsView.h
//  Service1.0
//
//  Created by YZ Y on 16/4/27.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YYAdsViewDelegate <NSObject>

@optional
- (void)tapAds:(NSString *)adsID;
@end

@interface YYAdsView : UIView
@property (nonatomic, strong) NSArray *infoArr;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) YYAdsViewType type;
@property (nonatomic, weak) id <YYAdsViewDelegate> delegate;
@property (nonatomic, strong) UIImageView *firstImage;

/**刷新数据*/
- (void)reloadData;
@end
