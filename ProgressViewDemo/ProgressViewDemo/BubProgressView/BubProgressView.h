//
//  BubProgressView.h
//  ProgressViewDemo
//
//  Created by Bubble on 2019/3/7.
//  Copyright © 2019 Bubble. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BubProgressView : UIView

/// progress toltal
@property (nonatomic, assign) CGFloat toltalSum;

/// progress text
@property (nonatomic, strong) NSString *progressTitle;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *ovalViewColor;
@property (nonatomic, strong) UIColor *triangleViewColor;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, strong) NSArray *progressGradientColor;

- (void)updateAnimationsWithTotal:(CGFloat)toltalSum progressNum:(CGFloat)num;

- (void)updateAnimationWithProgressNum:(CGFloat)num;

- (void)resetProgress;

@end

NS_ASSUME_NONNULL_END
