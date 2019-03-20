//
//  GoodsTableViewCell.h
//  ShoppingCart
//
//  Created by jqq on 2019/3/19.
//  Copyright © 2019 jqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsCellModelProtocol.h"
#import "SCViewObserver.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoodsTableViewCell : UITableViewCell <SCViewObserver>

- (void)updateData:(id<GoodsCellModelProtocol>)model;

@end

NS_ASSUME_NONNULL_END
