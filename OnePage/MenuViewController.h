//
//  MenuViewController.h
//  OnePage
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController
@property (nonatomic, strong) UIViewController *centerViewController;
@property (nonatomic, strong) UIViewController *leftViewController;
@property (nonatomic, strong) UIViewController *rightViewController;

- (void)presentLeftMenu;
- (void)presentRightMenu;


@end
