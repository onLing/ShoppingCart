//
//  GoodsCellModelProtocol.h
//  ShoppingCart
//
//  Created by jqq on 2019/3/20.
//  Copyright © 2019 jqq. All rights reserved.
//

#ifndef GoodsCellModelProtocol_h
#define GoodsCellModelProtocol_h

@protocol GoodsCellModelProtocol <NSObject>

@required
- (NSInteger)getBuyCount;
- (NSInteger)getMaxtBuyCount;
- (NSString *)getName;
- (NSString *)getImageUrl;
- (NSString *)getPriceString;
- (BOOL)getSected;

@end

#endif /* GoodsCellModelProtocol_h */
