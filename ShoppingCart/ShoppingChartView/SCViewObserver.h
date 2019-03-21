//
//  SCViewObserver.h
//  ShoppingCart
//
//  Created by jqq on 2019/3/20.
//  Copyright © 2019 jqq. All rights reserved.
//

#ifndef SCViewObserver_h
#define SCViewObserver_h

#import "SCPresenter.h"

@protocol SCViewObserver <NSObject>

@required
- (void)registerObserver:(id<SCControlProtocol>)observer;
- (void)removeObserver;

@end
#endif /* SCViewObserver_h */
