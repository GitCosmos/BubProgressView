//
//  ViewController.m
//  ProgressViewDemo
//
//  Created by Bubble on 2019/3/7.
//  Copyright © 2019 Bubble. All rights reserved.
//

#import "ViewController.h"
#import "BubProgressView/BubProgressView.h"
#import "BubTriangleView.h"

@interface ViewController ()

@property (nonatomic, strong) BubProgressView *progressView;
@property (nonatomic, strong) UISlider *progressSlider;
@property (nonatomic, strong) UITextField *progressNumField;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setupView];
}

- (void)setupView {
  self.progressView = [[BubProgressView alloc] init];
  self.progressView.ovalViewColor = [UIColor blueColor];
  self.progressView.triangleViewColor = [UIColor purpleColor];
  self.progressView.progressGradientColor = @[(__bridge id)UIColorFromRGB(0x12c2e9).CGColor, (__bridge id)UIColorFromRGB(0xc471ed).CGColor, (__bridge id)UIColorFromRGB(0xf64f59).CGColor];
  //    self.progressView.progressColor = [UIColor cyanColor];
  [self.view addSubview:self.progressView];

  [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view).offset(20);
    make.right.equalTo(self.view).offset(-20);
    make.top.equalTo(self.view).offset(200);
    make.height.equalTo(@60);
  }];

  UISlider *progressSlider = [[UISlider alloc] init];
  [self.view addSubview:progressSlider];
  progressSlider.maximumValue = 100;
  progressSlider.minimumValue = 0;
  progressSlider.value = 50;

  [progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view).offset(20);
    make.right.equalTo(self.view).offset(-20);
    make.top.equalTo(self.progressView.mas_bottom).offset(30);
  }];
  [progressSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
  self.progressSlider = progressSlider;

  UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
  [btn setTitle:@"回到起点" forState:UIControlStateNormal];
  [self.view addSubview:btn];
  [btn sizeToFit];

  [btn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.progressSlider.mas_bottom).offset(40);
    make.left.equalTo(self.progressSlider);
  }];

  [btn addTarget:self action:@selector(resetProgress) forControlEvents:UIControlEventTouchUpInside];

  self.progressNumField = [[UITextField alloc] init];
  self.progressNumField.placeholder = @"进度值";
  self.progressNumField.text = @"50";
  self.progressNumField.font = [UIFont systemFontOfSize:12];
  self.progressNumField.borderStyle = UITextBorderStyleRoundedRect;
  self.progressNumField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
  self.progressNumField.textAlignment = NSTextAlignmentCenter;
  self.progressNumField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.progressNumField.returnKeyType = UIReturnKeyDone;

  [self.view addSubview:self.progressNumField];
  [self.progressNumField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.equalTo(@100);
    make.height.equalTo(@30);
    make.centerX.equalTo(self.view);
    make.top.equalTo(btn);
  }];

  [self.progressNumField addTarget:self action:@selector(progressChanged:) forControlEvents:UIControlEventEditingChanged];

  UITextField *maxNumField = [[UITextField alloc] init];
  maxNumField.placeholder = @"最大值";
  maxNumField.font = [UIFont systemFontOfSize:12];
  maxNumField.text = @"100";
  maxNumField.borderStyle = UITextBorderStyleRoundedRect;
  maxNumField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
  maxNumField.textAlignment = NSTextAlignmentCenter;
  maxNumField.clearButtonMode = UITextFieldViewModeWhileEditing;
  maxNumField.returnKeyType = UIReturnKeyDone;

  [self.view addSubview:maxNumField];
  [maxNumField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.equalTo(@100);
    make.height.equalTo(btn);
    make.right.equalTo(self.view).offset(-5);
    make.top.equalTo(btn);
  }];

  [maxNumField addTarget:self action:@selector(maxNumChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)maxNumChanged:(UITextField *)maxNumField {
  if (maxNumField.text.integerValue <= 0) {
    return;
  }

  self.progressSlider.maximumValue = maxNumField.text.floatValue;
  self.progressView.toltalSum = self.progressSlider.maximumValue;
  self.progressSlider.value = self.progressNumField.text.floatValue;
  [self.progressView updateAnimationsWithTotal:self.progressSlider.maximumValue progressNum:self.progressSlider.value];
}

- (void)progressChanged:(UITextField *)maxNumField {
  self.progressSlider.value = maxNumField.text.floatValue;
  [self.progressView updateAnimationWithProgressNum:self.progressSlider.value];
  [self updateProgressTitle];
}

- (void)sliderValueChanged:(UISlider *)progressSlider {

  self.progressNumField.text = [NSString stringWithFormat:@"%.2f", progressSlider.value];
  [self.progressView updateAnimationWithProgressNum:progressSlider.value];
  [self updateProgressTitle];
}

- (void)resetProgress {
  [self.progressView resetProgress];
  self.progressView.progressTitle = @"0.00%";
  self.progressSlider.value = 0;
  self.progressNumField.text = [NSString stringWithFormat:@"%.0f", self.progressSlider.value];
}

- (void)startAnimation {
  self.progressView.toltalSum = self.progressSlider.maximumValue;
  [self.progressView updateAnimationWithProgressNum:self.progressSlider.value];
  [self updateProgressTitle];
}

- (void)updateProgressTitle {
  self.progressView.progressTitle = [NSString stringWithFormat:@"%.2f%%", self.progressSlider.value];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  [self startAnimation];
}


@end
