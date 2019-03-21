//
//  GoodsTableViewCell.m
//  ShoppingCart
//
//  Created by jqq on 2019/3/19.
//  Copyright © 2019 jqq. All rights reserved.
//

#import "GoodsTableViewCell.h"
#import "GoodsCounterView.h"
#import "UIImageView+WebCache.h"

@interface GoodsTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *selButton;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet GoodsCounterView *buyCountView;

///注意这里要使用weak，可以防止在没有调用removeObserver的情况下的内存泄露。如果使用strong，要记得调用removeObserver
@property (nonatomic, weak) id<SCControlProtocol> observer;

@end

@implementation GoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    __weak typeof(self) weakSelf = self;
    self.buyCountView.minusBlock = ^{
        if (weakSelf.observer && [weakSelf.observer respondsToSelector:@selector(sc_tableViewCellDidClickMinusButton:)]) {
            [weakSelf.observer sc_tableViewCellDidClickMinusButton:weakSelf];
        }
    };
    self.buyCountView.plusBlock = ^{
        if (weakSelf.observer && [weakSelf.observer respondsToSelector:@selector(sc_tableViewCellDidClickPlusButton:)]) {
            [weakSelf.observer sc_tableViewCellDidClickPlusButton:weakSelf];
        }
    };
}


- (IBAction)selectedAction:(id)sender {
    if (self.observer && [self.observer respondsToSelector:@selector(sc_tableViewCellDidClickSelectButton:)]) {
        [self.observer sc_tableViewCellDidClickSelectButton:self];
    }
}

- (void)updateData:(id<GoodsCellModelProtocol>)model {
    if ([model getSected]) {
        [self.selButton setImage:[[UIImage imageNamed:@"icon_sel_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }else {
        [self.selButton setImage:[[UIImage imageNamed:@"icon_unsel_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    self.nameLabel.text = [model getName];
    self.priceLabel.text = [model getPriceString];
    self.buyCountView.count = [model getBuyCount];
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[model getImageUrl]]];
}

#pragma mark -
- (void)registerObserver:(id<SCControlProtocol>)observer {
    self.observer = observer;
}
- (void)removeObserver {
    self.observer = nil;
}
@end
