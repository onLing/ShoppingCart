//
//  GoodsCounterView.m
//  ShoppingCart
//
//  Created by jqq on 2019/3/19.
//  Copyright © 2019 jqq. All rights reserved.
//

#import "GoodsCounterView.h"

@interface GoodsCounterView ()
@property (nonatomic, strong) UIButton *minusButton;
@property (nonatomic, strong) UIButton *plusButton;
@property (nonatomic, strong) UITextField *countTextField;
@end

@implementation GoodsCounterView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    UIButton *minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [minusButton setTitle:@"-" forState:UIControlStateNormal];
    minusButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [minusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [minusButton addTarget:self action:@selector(minusAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:minusButton];
    _minusButton = minusButton;
    
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusButton setTitle:@"+" forState:UIControlStateNormal];
    plusButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [plusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [plusButton addTarget:self action:@selector(plusAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:plusButton];
    _plusButton = plusButton;
    
    UITextField *countTextField = [[UITextField alloc] init];
    countTextField.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:247/255.f alpha:1.f];
    countTextField.textColor = [UIColor blackColor];
    countTextField.font = [UIFont systemFontOfSize:13];
    countTextField.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    countTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    countTextField.textAlignment = NSTextAlignmentCenter;
    countTextField.keyboardType = UIKeyboardTypeNumberPad;
    [countTextField addTarget:self action:@selector(buyCountTextFieldEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [self addSubview:countTextField];
    _countTextField = countTextField;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat btnWidth = 25.f;
    self.minusButton.frame = CGRectMake(0, 0, btnWidth, self.bounds.size.height);
    self.plusButton.frame = CGRectMake(self.bounds.size.width - btnWidth, 0, btnWidth, self.bounds.size.height);
    CGFloat countTfWidth = MAX(0, self.bounds.size.width - CGRectGetWidth(self.minusButton.frame) - CGRectGetWidth(self.plusButton.frame));
    CGFloat countTfHeight = 20.f;
    self.countTextField.frame = CGRectMake(CGRectGetMaxX(self.minusButton.frame), CGRectGetMidY(self.minusButton.frame) - countTfHeight / 2.f, countTfWidth, countTfHeight);
}

- (void)updateMinusPlusButtonStatus {
    if (self.count > 1) {
        self.minusButton.enabled = YES;
        [self.minusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else {
        self.minusButton.enabled = NO;
        [self.minusButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    if (self.maxCount > 0 && self.count >= self.maxCount) {
        self.plusButton.enabled = NO;
        [self.plusButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }else {
        self.plusButton.enabled = YES;
        [self.plusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (void)minusAction {
    if (self.minusBlock) {
        self.minusBlock();
    }
}
- (void)plusAction {
    if (self.plusBlock) {
        self.plusBlock();
    }
}
- (void)buyCountTextFieldEditingDidEnd:(UITextField *)textField {
    if (self.textEditingEndBlock) {
        self.textEditingEndBlock(textField);
    }
}

- (void)setCount:(NSInteger)count {
    _count = count;
    self.countTextField.text = [NSString stringWithFormat:@"%ld", count];
    [self updateMinusPlusButtonStatus];
}
- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
    [self updateMinusPlusButtonStatus];
}
@end
