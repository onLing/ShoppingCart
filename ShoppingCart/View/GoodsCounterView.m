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
@property (nonatomic, strong) UILabel *countLabel;
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
    
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:247/255.f alpha:1.f];
    countLabel.textColor = [UIColor blackColor];
    countLabel.font = [UIFont systemFontOfSize:13];
    countLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:countLabel];
    _countLabel = countLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat btnWidth = 25.f;
    self.minusButton.frame = CGRectMake(0, 0, btnWidth, self.bounds.size.height);
    self.plusButton.frame = CGRectMake(self.bounds.size.width - btnWidth, 0, btnWidth, self.bounds.size.height);
    CGFloat countLabelWidth = MAX(0, self.bounds.size.width - CGRectGetWidth(self.minusButton.frame) - CGRectGetWidth(self.plusButton.frame));
    CGFloat countLabelHeight = 20.f;
    self.countLabel.frame = CGRectMake(CGRectGetMaxX(self.minusButton.frame), CGRectGetMidY(self.minusButton.frame) - countLabelHeight / 2.f, countLabelWidth, countLabelHeight);
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

- (void)setCount:(NSInteger)count {
    _count = count;
    self.countLabel.text = [NSString stringWithFormat:@"%ld", count];
    if (count > 1) {
        self.minusButton.enabled = YES;
        [self.minusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else {
        self.minusButton.enabled = NO;
        [self.minusButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}
@end
