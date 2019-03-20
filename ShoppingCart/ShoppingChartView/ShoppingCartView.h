//
//  ShoppingCartView.h
//  ShoppingCart
//
//  Created by jqq on 2019/3/19.
//  Copyright © 2019 jqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCSaleViewProtocol.h"
#import "SCGoodsModelProtocol.h"
#import "SCViewObserver.h"
#import "SCPresenter.h"

@class ShoppingCartView;

@protocol ShoppingCartViewDatasource <NSObject>

@required
///由数据源实现自定义的cell
- (UITableViewCell<SCViewObserver> *)sc_shoppingCartView:(ShoppingCartView *)scView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)sc_shoppingCartView:(ShoppingCartView *)scView numberOfRowsInSection:(NSInteger)section;
///由数据源返回当前indexPath对应的model
- (id<SCGoodsModelProtocol>)sc_shoppingCartView:(ShoppingCartView *)scView goodsModelAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSInteger)sc_numberOfSectionsInShoppingCartView:(ShoppingCartView *)scView;
///结算视图，
- (UIView<SCSaleViewProtocol> *)sc_saleView;

///无数据视图
- (UIView *)sc_emptyDataView;

@end

@protocol ShoppingCartViewDelegate <NSObject>

@optional
/**
 * 删除商品
 * goods：商品数据模型
 * completion：完成后的回调
 */
- (void)sc_deleteGoods:(id)goods completion:(void(^)(BOOL success))completion;
///结算
- (void)sc_shoppingCartViewDidClickSale:(ShoppingCartView *)scView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingCartView : UIView <SCControlProtocol>
@property (nonatomic, strong, nullable) NSArray<SCGoodsModelProtocol> *goodsArray;
@property (nonatomic, strong, readonly) UITableView *tableView;

///数据源，可以实现该数据源的协议，实现自定义视图，未实现的协议方法，则会使用默认的视图
@property (nonatomic, weak, nullable) id<ShoppingCartViewDatasource> datasource;
///代理，事件回调
@property (nonatomic, weak, nullable) id<ShoppingCartViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
