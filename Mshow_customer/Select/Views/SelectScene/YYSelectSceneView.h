//
//  YYSelectSceneView.h
//  Mshow_customer
//
//  Created by YYZ on 2017/10/26.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYSceneModel;

@protocol YYSelectSceneViewDelegate <NSObject>
/**展示详情*/
- (void)executeShowScene:(YYSceneModel *)sceneModel;

@end

@interface YYSelectSceneView : UIView
@property (nonatomic, weak) id <YYSelectSceneViewDelegate> delegate;

@end
