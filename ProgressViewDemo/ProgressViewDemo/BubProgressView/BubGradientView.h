//
//  BubGradientView.h
//  ProgressViewDemo
//
//  Created by Bubble on 2019/3/7.
//  Copyright © 2019 Bubble. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BubGradientView : UIView

/// 圆角
@property (nonatomic, assign) NSInteger viewCornerRadius;

/// 渐变色
@property (nonatomic, strong) NSArray *gradientColors;

@end

NS_ASSUME_NONNULL_END
