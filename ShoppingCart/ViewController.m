//
//  ViewController.m
//  ShoppingCart
//
//  Created by jqq on 2019/3/19.
//  Copyright © 2019 jqq. All rights reserved.
//

#import "ViewController.h"
#import "ShoppingCartView.h"
#import "GoodsTableViewCell.h"
#import "GoodsModelAdapter.h"
#import "SCGoodsModelProtocol.h"
#import "GoodsModel.h"
#import "IQKeyboardManager.h"

@interface ViewController () <ShoppingCartViewDatasource, ShoppingCartViewDelegate>
@property (nonatomic, strong) ShoppingCartView *shoppingCartView;
@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.shoppingCartView.frame = self.view.bounds;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加商品" style:UIBarButtonItemStylePlain target:self action:@selector(addGoods)];
    [self initSCView];
    [self requestData];
    
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    [IQKeyboardManager sharedManager].previousNextDisplayMode = IQPreviousNextDisplayModeAlwaysHide;
}

///初始化购物车视图
static NSString *kReusedId = @"GoodsTableViewCell";
- (void)initSCView {
    self.shoppingCartView = [[ShoppingCartView alloc] init];
    self.shoppingCartView.datasource = self;
    self.shoppingCartView.delegate = self;
    [self.view addSubview:self.shoppingCartView];
    
    ///cell
    self.shoppingCartView.tableView.rowHeight = 80;
    [self.shoppingCartView.tableView registerNib:[UINib nibWithNibName:kReusedId bundle:nil] forCellReuseIdentifier:kReusedId];
}



///请求数据
- (void)requestData {
    ///这里发起网络请求获取数据
    self.shoppingCartView.goodsArray = nil;
}
- (void)addGoods {
    NSArray *goods = @[[self createGoodsModelAdapter]];
    if (self.shoppingCartView.goodsArray.count) {
        NSMutableArray *temp = [self.shoppingCartView.goodsArray mutableCopy];
        [temp addObject:[self createGoodsModelAdapter]];
        goods = temp;
    }
    self.shoppingCartView.goodsArray = [goods copy];
}
- (GoodsModelAdapter *)createGoodsModelAdapter {
    GoodsModelAdapter *adapter = [GoodsModelAdapter goodsModelAdapter:[GoodsModel new]];
    return adapter;
}

#pragma mark - ShoppingCartViewDatasource
- (NSInteger)sc_numberOfSectionsInShoppingCartView:(ShoppingCartView *)scView {
    return 1;
}
- (NSInteger)sc_shoppingCartView:(ShoppingCartView *)scView numberOfRowsInSection:(NSInteger)section {
    return scView.goodsArray.count;
}
- (id<SCGoodsModelProtocol>)sc_shoppingCartView:(ShoppingCartView *)scView goodsModelAtIndexPath:(NSIndexPath *)indexPath {
    return scView.goodsArray[indexPath.row];
}

///cell 必须要实现
- (UITableViewCell<SCViewObserver> *)sc_shoppingCartView:(ShoppingCartView *)scView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsModelAdapter *adapter = (GoodsModelAdapter *)[self sc_shoppingCartView:scView goodsModelAtIndexPath:indexPath];
    GoodsTableViewCell *cell = [scView.tableView dequeueReusableCellWithIdentifier:kReusedId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateData:adapter];
    return cell;
}

///这写视图可以不实现，不实现会使用默认视图，可以自定义
///结算视图，
//- (UIView<SCSaleViewProtocol> *)sc_saleView{
//
//}

///无数据视图
//- (UIView *)sc_emptyDataView {
//
//}

#pragma mark - ShoppingCartViewDelegate
///删除商品
- (void)sc_deleteGoods:(id)goods completion:(void (^)(BOOL))completion {
    ///这里发起网络请求，从购物车中删除goods
    ///网络请求结束后回调completion
    ///删除成功传YES，删除失败传NO
    
    completion(YES);
}
///结算
- (void)sc_shoppingCartViewDidClickSale:(ShoppingCartView *)scView {
    NSMutableString *message = [NSMutableString stringWithString:@"购买商品\n"];
    for (GoodsModelAdapter *model in scView.goodsArray) {
        ///只有选中状态的才计入购买
        if (model.selected) {
            [message appendString:[NSString stringWithFormat:@"%@ * %ld\n", model.goods.name, model.buyCount]];
        }
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
