//
//  SCGoodsModelProtocol.h
//  ShoppingCart
//
//  Created by jqq on 2019/3/20.
//  Copyright © 2019 jqq. All rights reserved.
//

#ifndef SCGoodsModelProtocol_h
#define SCGoodsModelProtocol_h

@protocol SCGoodsModelProtocol <NSObject>

@required
///get
- (NSInteger)sc_getBuyCount;
- (NSInteger)sc_getMaxBuyCount;
- (double)sc_getPrice;
- (BOOL)sc_getSected;

///set
- (void)sc_setSelected:(BOOL)selected;
///-1
- (void)sc_minusBuyCount;
///+1
- (void)sc_plusBuyCount;

@end

#endif /* SCGoodsModelProtocol_h */
