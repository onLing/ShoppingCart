//
//  GoodsCounterView.h
//  ShoppingCart
//
//  Created by jqq on 2019/3/19.
//  Copyright © 2019 jqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsCounterView : UIView
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic, copy) void(^minusBlock)(void);
@property (nonatomic, copy) void(^plusBlock)(void);
@property (nonatomic, copy) void(^textEditingEndBlock)(UITextField *textField);
@end

NS_ASSUME_NONNULL_END
