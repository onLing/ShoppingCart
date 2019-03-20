//
//  GoodsModel.m
//  ShoppingCart
//
//  Created by jqq on 2019/3/20.
//  Copyright © 2019 jqq. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel
- (instancetype)init {
    if (self = [super init]) {
        NSInteger i = [self random];
        _name = [self nameArray][i];
        _price = [[self priceArray][i] doubleValue];
        _maxBuyCount = 3;
    }
    return self;
}
- (NSInteger)random {
    return arc4random_uniform(5);
}
- (NSArray *)nameArray {
    return @[@"商品A",
             @"商品B",
             @"商品C",
             @"商品D",
             @"商品E"];
}
- (NSArray *)priceArray {
    return @[@(100),
             @(200),
             @(300),
             @(400),
             @(500)];
}
@end
