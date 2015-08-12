//
//  UIViewController+MenuVC.h
//  OnePage
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;

@interface UIViewController (MenuVC)
@property(strong, readonly, nonatomic) MenuViewController *menuVC;

- (IBAction)presentLeftMenuVC:(id)sender;
- (IBAction)presentRightMenuVC:(id)sender;





@end
