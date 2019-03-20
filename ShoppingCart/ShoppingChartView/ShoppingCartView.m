//
//  ShoppingCartView.m
//  ShoppingCart
//
//  Created by jqq on 2019/3/19.
//  Copyright © 2019 jqq. All rights reserved.
//

#import "ShoppingCartView.h"
#import "SCDefaultSaleView.h"
#import "SCSaleViewProtocol.h"
#import "UIView+Extension.h"

///空数据view标签
#define SC_EMPTY_DATA_VIEW_TAG 99
///结算视图的高度，目前固定60，后期可以提供属性去自定义
#define SC_SALE_VIEW_HEIGHT 60

@interface ShoppingCartView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
///结算视图
@property (nonatomic, strong) UIView<SCSaleViewProtocol> *saleView;
@property (nonatomic, strong) UIView *saleViewContainer;
@end

@implementation ShoppingCartView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}
- (void)commonInit {
    [self addSubview:self.tableView];
    [self addSubview:self.saleViewContainer];
    [self reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - SC_SALE_VIEW_HEIGHT - self.safeAreaInsets.bottom);
    self.saleViewContainer.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.bounds.size.width, SC_SALE_VIEW_HEIGHT);
    
}

#pragma mark - 更新数据
///刷新数据
- (void)reloadData {
    ///1、刷新table view
    [self.tableView reloadData];
    ///2、根据商品数量决定显示还是隐藏结算view
    [self updateSaleView];
    ///3、根据商品商量决定隐藏还是现实empty data view
    [self updateEmptyView];
}
- (void)updateEmptyView {
    ///删除empty data view
    UIView *emptyDataView = [self viewWithTag:SC_EMPTY_DATA_VIEW_TAG];
    if (emptyDataView) {
        [emptyDataView removeFromSuperview];
    }
    if (self.goodsArray.count > 0) {
        return;
    }
    ///数据为空则add empty data view
    ///获取empty data view，若datasource有实现，则使用，否则使用默认实现
    if (self.datasource && [self.datasource respondsToSelector:@selector(sc_emptyDataView)]) {
        emptyDataView = [self.datasource sc_emptyDataView];
    }else {
        emptyDataView = [self createEmptyDataView];
    }
    [self addSubview:emptyDataView];
    [self addFullConstraintWithView:emptyDataView toView:self];
    emptyDataView.tag = SC_EMPTY_DATA_VIEW_TAG;
    [self bringSubviewToFront:emptyDataView];
}
- (void)updateSaleView {
    if (self.goodsArray.count) {
        self.saleViewContainer.hidden = NO;
        if (self.saleView) {
            [self.saleView removeFromSuperview];
            [self.saleView removeObserver];
            self.saleView = nil;
        }
        ///add
        ///获取sale view，若datasource有实现，则使用，否则使用默认实现
        if (self.datasource && [self.datasource respondsToSelector:@selector(sc_saleView)]) {
            self.saleView = [self.datasource sc_saleView];
        }else {
            self.saleView = [self createSaleView];
        }
        [self.saleViewContainer addSubview:self.saleView];
        [self addFullConstraintWithView:self.saleView toView:self.saleViewContainer];
        
        [self.saleView registerObserver:self];
        ///更新数据
        NSInteger buyCount = 0;
        double totalPrice = 0.f;
        BOOL allSelected = YES;
        for (NSObject<SCGoodsModelProtocol> *model in self.goodsArray) {
            NSInteger theCount = [model sc_getBuyCount];
            ///选中的商品才计算数量和价格
            if ([model sc_getSected]) {
                totalPrice += ([model sc_getPrice] * theCount);
                buyCount += theCount;
            }else {
                allSelected = NO;
            }
        }
        if ([self.saleView respondsToSelector:@selector(sc_saleViewUpdatePrice:)]) {
            [self.saleView sc_saleViewUpdatePrice:totalPrice];
        }
        if ([self.saleView respondsToSelector:@selector(sc_saleViewUpdateBuyCount:)]) {
            [self.saleView sc_saleViewUpdateBuyCount:buyCount];
        }
        if ([self.saleView respondsToSelector:@selector(sc_saleViewUpdateSelectedStatus:)]) {
            [self.saleView sc_saleViewUpdateSelectedStatus:allSelected];
        }
        
    }else {
        self.saleViewContainer.hidden = YES;
    }
}


#pragma mark - setter && getter

- (void)setGoodsArray:(NSArray<SCGoodsModelProtocol> *)goodsArray {
    _goodsArray = goodsArray;
    [self reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
- (UIView *)saleViewContainer {
    if (!_saleViewContainer) {
        _saleViewContainer = [[UIView alloc] init];
    }
    return _saleViewContainer;
}
- (UIView<SCSaleViewProtocol> *)createSaleView {
    SCDefaultSaleView *saleView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SCDefaultSaleView class]) owner:nil options:nil].lastObject;
    return saleView;
}
- (UIView *)createEmptyDataView {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"暂无数据";
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

#pragma mark - table view 数据源&&代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.datasource && [self.datasource respondsToSelector:@selector(sc_numberOfSectionsInShoppingCartView:)]) {
        return [self.datasource sc_numberOfSectionsInShoppingCartView:self];
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datasource sc_shoppingCartView:self numberOfRowsInSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell<SCViewObserver> *cell = [self.datasource sc_shoppingCartView:self cellForRowAtIndexPath:indexPath];
    [cell registerObserver:self];
    return cell;
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    id goods = self.goodsArray[indexPath.row];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(sc_deleteGoods:completion:)]) {
            [self.delegate sc_deleteGoods:goods completion:^(BOOL success) {
                if (success) {
                    NSMutableArray<SCGoodsModelProtocol> *tempArray = [self.goodsArray mutableCopy];
                    [tempArray removeObject:goods];
                    self.goodsArray = tempArray;
                }
            }];
        }
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction];
}

#pragma mark -
- (void)sc_saleViewDidClickSaleButton {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sc_shoppingCartViewDidClickSale:)]) {
        [self.delegate sc_shoppingCartViewDidClickSale:self];
    }
}
///商品全选按钮点击
- (void)sc_saleViewDidClickAllselectButton {
    BOOL isAllSelected = YES;
    for (NSObject<SCGoodsModelProtocol> *model in self.goodsArray) {
        if ([model sc_getSected] == NO) {
            isAllSelected = NO;
            break;
        }
    }
    ///如果当前是全选状态，则取消全选
    ///如果当前是未全选状态，则全选
    BOOL goodsSelected = isAllSelected ? NO : YES;
    for (NSObject<SCGoodsModelProtocol> *model in self.goodsArray) {
        [model sc_setSelected:goodsSelected];
    }
    
    ///刷新UI
    [self reloadData];
}
///单个商品点击选择框
- (void)sc_tableViewCellDidClickSelectButton:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    id<SCGoodsModelProtocol> obj = [self.datasource sc_shoppingCartView:self goodsModelAtIndexPath:indexPath];
    [obj sc_setSelected:![obj sc_getSected]];
    [self reloadData];
}
///商品+1
- (void)sc_tableViewCellDidClickPlusButton:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    id<SCGoodsModelProtocol> obj = [self.datasource sc_shoppingCartView:self goodsModelAtIndexPath:indexPath];
    if ([obj sc_getBuyCount] >= [obj sc_getMaxBuyCount]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"最多只能购买%ld件哦！", [obj sc_getMaxBuyCount]] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        [[self responseViewController] presentViewController:alert animated:YES completion:nil];
        return;
    }
    [obj sc_plusBuyCount];
    [self reloadData];
}
///商品-1
- (void)sc_tableViewCellDidClickMinusButton:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    id<SCGoodsModelProtocol> obj = [self.datasource sc_shoppingCartView:self goodsModelAtIndexPath:indexPath];
    [obj sc_minusBuyCount];
    [self reloadData];
}

#pragma mark - 添加约束
///用Masonry框架添加约束和更新约束更好
- (void)addFullConstraintWithView:(UIView *)view toView:(UIView *)toView {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topConstraint =
    [NSLayoutConstraint constraintWithItem:view
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:toView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:0];
    NSLayoutConstraint *leftConstraint =
    [NSLayoutConstraint constraintWithItem:view
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:toView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1
                                  constant:0];
    NSLayoutConstraint *bottomConstraint =
    [NSLayoutConstraint constraintWithItem:view
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:toView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1
                                  constant:0];
    NSLayoutConstraint *rightConstraint =
    [NSLayoutConstraint constraintWithItem:view
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:toView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1
                                  constant:0];
    [self addConstraints:@[topConstraint, leftConstraint, bottomConstraint, rightConstraint]];
}

@end
