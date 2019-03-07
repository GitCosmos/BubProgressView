//
//  BubTriangleView.m
//  ProgressViewDemo
//
//  Created by Bubble on 2019/3/7.
//  Copyright © 2019 Bubble. All rights reserved.
//

#import "BubTriangleView.h"

@implementation BubTriangleView {
  CGPoint _startPoint;
  CGPoint _middlePoint;
  CGPoint _endPoint;
  UIColor *_color;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    _startPoint = CGPointMake(0, 0);
    _middlePoint = CGPointMake(0, 0);
    _endPoint = CGPointMake(0, 0);
    _color = UIColor.redColor;
    self.backgroundColor = [UIColor clearColor];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextBeginPath(context);
  CGContextMoveToPoint(context, _startPoint.x, _startPoint.y);
  CGContextAddLineToPoint(context,_middlePoint.x, _middlePoint.y);
  CGContextAddLineToPoint(context,_endPoint.x, _endPoint.y);
  CGContextClosePath(context);
  [_color setFill];
  [_color setStroke];
  CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _endPoint.x = self.bounds.size.width;
  _middlePoint.x = self.bounds.size.width / 2;
  _middlePoint.y = self.bounds.size.height;
}

- (void)setTriangleColor:(UIColor *)triangleColor {
  _triangleColor = triangleColor;

  _color = triangleColor;
}

@end
