//
//  UIView+Extension.m
//  ShoppingCart
//
//  Created by jqq on 2019/3/20.
//  Copyright © 2019 jqq. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (UIViewController *)responseViewController {
    UIViewController *controller = nil;
    if ([self.nextResponder isKindOfClass:[UIViewController class]]) {
        controller = (UIViewController *)self.nextResponder;
    }else {
        for (UIView *next = [self superview]; next; next = next.superview) {
            UIResponder *nextResponder = [next nextResponder];
            if ([nextResponder isKindOfClass:[UIViewController class]]) {
                controller = (UIViewController *)nextResponder;
                break;
            }
        }
    }
    if ([controller isKindOfClass:[UINavigationController class]]) {
        return ((UINavigationController *)controller).topViewController;
    }else {
        return controller;
    }
}
@end
