//
//  BubProgressView.m
//  ProgressViewDemo
//
//  Created by Bubble on 2019/3/7.
//  Copyright © 2019 Bubble. All rights reserved.
//

#import "BubProgressView.h"
#import "BubTriangleView.h"
#import "BubGradientView.h"

@interface BubProgressView ()

@property (nonatomic, strong) UIView *ovalView;
@property (nonatomic, strong) UILabel *ovalTitle;
@property (nonatomic, strong) BubTriangleView *triangleView;
@property (nonatomic, strong) BubGradientView *progressLineView;
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, assign) NSInteger progressNum;

@end

@implementation BubProgressView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.ovalView = [[UIView alloc] init];
    self.ovalView.backgroundColor = [UIColor redColor];
    self.ovalView.layer.cornerRadius = 7.5;

    self.ovalTitle = [[UILabel alloc] init];
    self.ovalTitle.font = [UIFont systemFontOfSize:10];
    self.ovalTitle.textColor = UIColor.whiteColor;

    self.triangleView = [[BubTriangleView alloc] init];

    [self addSubview:self.ovalView];
    [self.ovalView addSubview:self.ovalTitle];

    [self.ovalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.ovalView).offset(7);
      make.right.equalTo(self.ovalView).offset(-7);
      make.top.equalTo(self.ovalView).offset(2);
      make.bottom.equalTo(self.ovalView).offset(-2);
    }];

    [self addSubview:self.triangleView];

    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.layer.cornerRadius = 1.5;

    self.backgroundView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.backgroundView];

    self.progressLineView = [[BubGradientView alloc] init];
    self.progressLineView.viewCornerRadius = 1.5;
    [self.backgroundView addSubview:self.progressLineView];
    self.backgroundView.layer.masksToBounds = YES;

    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self);
      make.right.equalTo(self);
      make.height.equalTo(@3);
      make.top.equalTo(self).offset(30);
    }];

    [self.progressLineView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.backgroundView);
      make.width.equalTo(@0);
      make.top.equalTo(self.backgroundView);
      make.height.equalTo(self.backgroundView);
    }];

    [self.triangleView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.progressLineView.mas_right);
      make.bottom.equalTo(self.progressLineView.mas_top);
      make.height.equalTo(@4);
      make.width.equalTo(@8);
    }];

    [self.ovalView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(self.triangleView.mas_top);
      make.centerX.equalTo(self.triangleView);
    }];

    [self.ovalTitle sizeToFit];
    [self.ovalView sizeToFit];
  }
  return self;
}

- (void)resetProgress {
  [UIView animateWithDuration:0.3 animations:^{
    [self.progressLineView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.width.equalTo(@0);
    }];
    [self layoutIfNeeded];
  }];
}

- (void)updateAnimations {

  //    [self setNeedsUpdateConstraints];
  //    NSLog(@"%.0f", self.progressLineView.bounds.size.height);
  NSLog(@"%.0f", (self.progressNum / 80.0) * 57.0);
  NSLog(@"%.0f", (self.progressNum / 80.0) * 80.0);

  CGFloat offsetNum = (self.progressNum / 80.0) * 80.0;
  //    CGFloat offsetNum = self.number - ((self.number / 80) * (80 - 0));

  [UIView animateWithDuration:1.0 animations:^{
    [self.progressLineView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.width.equalTo(@(offsetNum));
    }];

    [self layoutIfNeeded];
  }];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.progressNum = self.backgroundView.bounds.size.width;
}

- (void)updateAnimationsWithTotal:(CGFloat)toltalSum progressNum:(CGFloat)num {
  CGFloat offsetNum = (self.progressNum / toltalSum) * num;
  [UIView animateWithDuration:0.5 animations:^{

    [self.progressLineView mas_updateConstraints:^(MASConstraintMaker *make) {
      if (offsetNum >= self.backgroundView.bounds.size.width) {
        make.width.equalTo(@(self.backgroundView.bounds.size.width));
      } else {
        make.width.equalTo(@(offsetNum));
      }
    }];

    [self layoutIfNeeded];
  }];
}

- (void)updateAnimationWithProgressNum:(CGFloat)num {
  CGFloat offsetNum = (self.progressNum / self.toltalSum) * num;
  [UIView animateWithDuration:0.5 animations:^{

    [self.progressLineView mas_updateConstraints:^(MASConstraintMaker *make) {
      if (offsetNum >= self.backgroundView.bounds.size.width) {
        make.width.equalTo(@(self.backgroundView.bounds.size.width));
      } else {
        make.width.equalTo(@(offsetNum));
      }
    }];

    [self layoutIfNeeded];
  }];
}


#pragma mark - Getter & Setter
- (void)setTitleColor:(UIColor *)titleColor {
  _titleColor = titleColor;

  self.ovalTitle.textColor = titleColor;
}

- (void)setProgressTitle:(NSString *)progressTitle {
  _progressTitle = progressTitle;

  self.ovalTitle.text = progressTitle;
}

- (void)setOvalViewColor:(UIColor *)ovalViewColor {
  _ovalViewColor = ovalViewColor;

  self.ovalView.backgroundColor = ovalViewColor;
}

- (void)setTriangleViewColor:(UIColor *)triangleViewColor {
  _triangleViewColor = triangleViewColor;

  self.triangleView.triangleColor = triangleViewColor;
}

- (void)setProgressColor:(UIColor *)progressColor {
  self.progressLineView.gradientColors = @[];
  self.progressLineView.backgroundColor = progressColor;
}

- (void)setProgressGradientColor:(NSArray *)progressGradientColor {
  self.progressLineView.gradientColors = progressGradientColor;
}

@end
