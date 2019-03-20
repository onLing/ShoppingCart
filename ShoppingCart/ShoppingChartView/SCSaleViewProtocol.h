//
//  SCSaleViewProtocol.h
//  ShoppingCart
//
//  Created by jqq on 2019/3/20.
//  Copyright © 2019 jqq. All rights reserved.
//

#ifndef SCSaleViewProtocol_h
#define SCSaleViewProtocol_h

#import "SCViewObserver.h"

@protocol SCSaleViewProtocol <SCViewObserver>

@optional
- (void)sc_saleViewUpdatePrice:(double)price;
- (void)sc_saleViewUpdateBuyCount:(NSInteger)buyCount;
- (void)sc_saleViewUpdateSelectedStatus:(BOOL)selected;

@end

#endif /* SCSaleViewProtocol_h */
