//
//  GoodsModel.h
//  ShoppingCart
//
//  Created by jqq on 2019/3/20.
//  Copyright © 2019 jqq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, assign) double price;
///最大购买数量
@property (nonatomic, assign) NSInteger maxBuyCount;
@end

NS_ASSUME_NONNULL_END
