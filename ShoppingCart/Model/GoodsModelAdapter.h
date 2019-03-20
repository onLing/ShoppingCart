//
//  GoodsModelAdapter.h
//  ShoppingCart
//
//  Created by jqq on 2019/3/20.
//  Copyright © 2019 jqq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsCellModelProtocol.h"
#import "SCGoodsModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class GoodsModel;
@interface GoodsModelAdapter : NSObject <SCGoodsModelProtocol, GoodsCellModelProtocol>
@property (nonatomic, assign) NSInteger buyCount;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) GoodsModel *goods;
+ (instancetype)goodsModelAdapter:(GoodsModel *)model;
@end

NS_ASSUME_NONNULL_END
