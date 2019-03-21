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
        _imageUrl = [self imgUrlArray][i];
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
- (NSArray *)imgUrlArray {
    return @[@"http://pic3.16pic.com/00/55/42/16pic_5542988_b.jpg",
             @"http://pic2.cxtuku.com/00/15/12/b315c76458d1.jpg",
             @"http://pic99.nipic.com/file/20160528/22270635_163037218000_2.jpg",
             @"http://pic31.nipic.com/20130802/7487939_095437256000_2.jpg",
             @"http://pic35.nipic.com/20131107/7487939_014644427000_2.jpg"];
}
@end
