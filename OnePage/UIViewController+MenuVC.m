//
//  UIViewController+MenuVC.m
//  OnePage
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "UIViewController+MenuVC.h"
#import "MenuViewController.h"

@implementation UIViewController (MenuVC)
//单例方法
- (MenuViewController *)menuVC
{
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[MenuViewController class]]) {
            return (MenuViewController *)iter;
        }else if (iter.parentViewController && iter.parentViewController != iter){
            iter = iter.parentViewController;
        }else{
            iter = nil;
        }
    }
    return nil;
}

- (IBAction)presentLeftMenuVC:(id)sender {
    [self.menuVC presentLeftMenu];
    
}

- (IBAction)presentRightMenuVC:(id)sender {
    [self.menuVC presentRightMenu];
}

@end
