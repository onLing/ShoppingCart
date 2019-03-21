//
//  GoodsModelAdapter.m
//  ShoppingCart
//
//  Created by jqq on 2019/3/20.
//  Copyright © 2019 jqq. All rights reserved.
//

#import "GoodsModelAdapter.h"
#import "GoodsModel.h"

@interface GoodsModelAdapter ()

@end

@implementation GoodsModelAdapter
+ (instancetype)goodsModelAdapter:(GoodsModel *)model {
    GoodsModelAdapter *adapter = [[GoodsModelAdapter alloc] init];
    adapter.buyCount = 1;
    adapter.goods = model;
    return adapter;
}

#pragma mark - GoodsCellModelProtocol
- (NSInteger)getBuyCount {
    return self.buyCount;
}
- (NSInteger)getMaxtBuyCount {
    return self.goods.maxBuyCount;
}
- (NSString *)getName {
    return self.goods.name;
}
- (NSString *)getImageUrl {
    return self.goods.imageUrl;
}
- (NSString *)getPriceString {
    return [NSString stringWithFormat:@"¥%.2f", self.goods.price];
}
- (BOOL)getSected {
    return self.selected;
}

#pragma mark - SCGoodsModelProtocol
- (NSInteger)sc_getBuyCount {
    return [self getBuyCount];
}
- (NSInteger)sc_getMaxBuyCount {
    return self.goods.maxBuyCount;
}
- (double)sc_getPrice {
    return self.goods.price;
}
- (BOOL)sc_getSected {
    return [self getSected];
}
- (void)sc_setSelected:(BOOL)selected {
    self.selected = selected;
}
- (void)sc_minusBuyCount {
    self.buyCount--;
}
- (void)sc_plusBuyCount {
    self.buyCount++;
}
- (void)sc_setBuyCount:(NSInteger)buyCount {
    self.buyCount = buyCount;
}
@end
