//
//  GoodsModelAdapter.h
//  ShoppingCart
//
//  Created by jqq on 2019/3/20.
//  Copyright © 2019 jqq. All rights reserved.
//
//  商品适配器，拥有属性goods，可根据不同的业务替换goods。
#import <Foundation/Foundation.h>
#import "GoodsCellModelProtocol.h"
#import "SCGoodsModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class GoodsModel;
@interface GoodsModelAdapter : NSObject <SCGoodsModelProtocol, GoodsCellModelProtocol>
///购买数量
@property (nonatomic, assign) NSInteger buyCount;
///选中状态
@property (nonatomic, assign) BOOL selected;
///商品model， 根据具体业务可替换
@property (nonatomic, strong) GoodsModel *goods;

+ (instancetype)goodsModelAdapter:(GoodsModel *)model;
@end

NS_ASSUME_NONNULL_END
