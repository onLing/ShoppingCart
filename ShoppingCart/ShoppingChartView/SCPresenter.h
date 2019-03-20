//
//  SCPresenter.h
//  ShoppingCart
//
//  Created by jqq on 2019/3/20.
//  Copyright © 2019 jqq. All rights reserved.
//

#ifndef SCPresenter_h
#define SCPresenter_h

@protocol SCControlProtocol <NSObject>

@optional
///结算点击
- (void)sc_saleViewDidClickSaleButton;
///全选点击
- (void)sc_saleViewDidClickAllselectButton;
///单选点击
- (void)sc_tableViewCellDidClickSelectButton:(UITableViewCell *)cell;
///商品+1
- (void)sc_tableViewCellDidClickPlusButton:(UITableViewCell *)cell;
///商品-1
- (void)sc_tableViewCellDidClickMinusButton:(UITableViewCell *)cell;

@end

#endif /* SCPresenter_h */
