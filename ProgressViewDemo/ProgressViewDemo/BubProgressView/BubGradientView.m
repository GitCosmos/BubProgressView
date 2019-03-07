//
//  BubGradientView.m
//  ProgressViewDemo
//
//  Created by Bubble on 2019/3/7.
//  Copyright © 2019 Bubble. All rights reserved.
//

#import "BubGradientView.h"

@interface BubGradientView ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation BubGradientView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.gradientLayer =  [CAGradientLayer layer];
    self.gradientLayer.locations = @[@0.3, @0.6, @0.9];
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1.0, 0);
    self.gradientLayer.cornerRadius = 6;

    [self.layer addSublayer:self.gradientLayer];
  }
  return self;
}

- (void)setViewCornerRadius:(NSInteger)viewCornerRadius {
  _viewCornerRadius = viewCornerRadius;

  self.gradientLayer.cornerRadius = viewCornerRadius;
}

- (void)setGradientColors:(NSArray *)gradientColors {
  _gradientColors = gradientColors;

  self.gradientLayer.colors = gradientColors;
  self.backgroundColor = UIColor.clearColor;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.gradientLayer.frame = self.bounds;
}

@end
