//
//  SCDefaultSaleView.m
//  ShoppingCart
//
//  Created by jqq on 2019/3/19.
//  Copyright © 2019 jqq. All rights reserved.
//

#import "SCDefaultSaleView.h"

@interface SCDefaultSaleView ()
@property (weak, nonatomic) IBOutlet UIButton *selButton;
@property (weak, nonatomic) IBOutlet UILabel *totalValueLabel;
@property (weak, nonatomic) IBOutlet UIButton *saleButton;

///注意这里要使用weak，可以防止在没有调用removeObserver的情况下的内存泄露。如果使用strong，要记得调用removeObserver
@property (nonatomic, weak) id<SCControlProtocol> observer;
@end

@implementation SCDefaultSaleView
- (IBAction)saleAction:(id)sender {
    if (self.observer && [self.observer respondsToSelector:@selector(sc_saleViewDidClickSaleButton)]) {
        [self.observer sc_saleViewDidClickSaleButton];
    }
}
- (IBAction)selectedAllAction:(id)sender {
    if (self.observer && [self.observer respondsToSelector:@selector(sc_saleViewDidClickAllselectButton)]) {
        [self.observer sc_saleViewDidClickAllselectButton];
    }
}


#pragma mark - SCSaleViewProtocol
- (void)sc_saleViewUpdateSelectedStatus:(BOOL)selected {
    if (selected) {
        [self.selButton setImage:[[UIImage imageNamed:@"icon_sel_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }else {
        [self.selButton setImage:[[UIImage imageNamed:@"icon_unsel_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
}
- (void)sc_saleViewUpdateBuyCount:(NSInteger)buyCount {
    [self.saleButton setTitle:[NSString stringWithFormat:@"去结算(%ld)", (long)buyCount] forState:UIControlStateNormal];
}
- (void)sc_saleViewUpdatePrice:(double)price {
    self.totalValueLabel.text = [NSString stringWithFormat:@"合计：¥%.2f", price];
}

#pragma mark - observer
- (void)registerObserver:(id<SCControlProtocol>)observer {
    self.observer = observer;
}
- (void)removeObserver {
    self.observer = nil;
}

@end
