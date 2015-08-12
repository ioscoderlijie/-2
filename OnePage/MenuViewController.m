//
//  MenuViewController.m
//  OnePage
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "MenuViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"

#define SLIDE_TIMING 0.5
#define MENU_WIDTH 80

@interface MenuViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL showingLeftMenu;
@property (nonatomic, assign) BOOL showingRightMenu;
@property (nonatomic, assign) BOOL showPanel;
@property (nonatomic, assign) CGPoint preVelocity; //速率

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景颜色
    self.view.backgroundColor = [UIColor cyanColor];
    [self setupView];
    [self commonInit];
}

//设置主界面的初始状态
- (void)commonInit
{
    self.showingLeftMenu = NO;
    self.showingRightMenu = NO;
}

#pragma mark - Setup View
//初始显示界面
- (void)setupView
{
    self.centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenuNav"];
    
    [self.view addSubview:self.centerViewController.view];
    [self addChildViewController:self.centerViewController];
    [self.centerViewController didMoveToParentViewController:self];
    
    [self setupGestures];
}

#pragma mark - Present Menu

- (UIView *)getRightView
{
    if (_rightViewController == nil) {
        self.rightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightMenu"];
        [self.view addSubview:self.rightViewController.view];
        [self addChildViewController:self.rightViewController];
        [self.rightViewController didMoveToParentViewController:self];
        
        self.rightViewController.view.frame = CGRectMake(0, 0, self.view.viewForBaselineLayout.frame.size.width, self.view.viewForBaselineLayout.frame.size.height);
    }
    self.showingRightMenu = YES;
    return self.rightViewController.view;
}

- (void)presentRightMenu
{
    if (!self.showingRightMenu) {
        UIView *rightView = [self getRightView];
        [self.view sendSubviewToBack:rightView];
//        [self.view sendSubviewToBack:self.menuBG];
        
        [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _centerViewController.view.frame = CGRectMake(-self.view.viewForBaselineLayout.frame.size.width + MENU_WIDTH, 0, self.view.viewForBaselineLayout.frame.size.width, self.view.viewForBaselineLayout.frame.size.height);
        } completion:^(BOOL finished) {
            if (finished) {
            }
        }];
    }else{
        [self moveMenuToOriginalPosition];
    }
}

- (UIView *)getLeftView
{
    if (_leftViewController == nil) {
        self.leftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenu"];
        [self.view addSubview:self.leftViewController.view];
        [self addChildViewController:self.leftViewController];
        [self.leftViewController didMoveToParentViewController:self];
        
        self.leftViewController.view.frame = CGRectMake(0, 0, self.view.viewForBaselineLayout.frame.size.width, self.view.viewForBaselineLayout.frame.size.height);
    }
    self.showingLeftMenu = YES;
    
    return self.leftViewController.view;
}

- (void)presentLeftMenu
{
    if (!self.showingLeftMenu) {
        UIView *leftView = [self getLeftView];
        
        [self.view sendSubviewToBack:leftView];
        
        [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _centerViewController.view.frame = CGRectMake(self.view.viewForBaselineLayout.frame.size.width - MENU_WIDTH, 0, self.view.viewForBaselineLayout.frame.size.width, self.view.viewForBaselineLayout.frame.size.height);
        } completion:^(BOOL finished) {
            if (finished) {
                
            }
        }];
    }else{
        [self moveMenuToOriginalPosition];
    }
    
}

- (void)moveMenuToOriginalPosition
{
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        _centerViewController.view.frame = CGRectMake(0, 0, self.view.viewForBaselineLayout.frame.size.width, self.view.viewForBaselineLayout.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            [self resetMenu];
        }
    }];
}

- (void)resetMenu
{
    if (_leftViewController != nil) {
        [self.leftViewController.view removeFromSuperview];
        [self.leftViewController removeFromParentViewController];
        self.leftViewController = nil;
        self.showingLeftMenu = NO;
    }
    
    if (_rightViewController != nil) {
        [self.rightViewController.view removeFromSuperview];
        [self.rightViewController removeFromParentViewController];
        self.rightViewController = nil;
        self.showingRightMenu = NO;
    }
}

#pragma mark - Swipe Gesture Setup

- (void)setupGestures
{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    [_centerViewController.view addGestureRecognizer:panRecognizer];
}

- (void)movePanel:(id)sender
{
    [[[(UITapGestureRecognizer *)sender view] layer] removeAllAnimations];
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        UIView *childView = nil;
        
        if(velocity.x > 0) {
            if (!_showingRightMenu) {
                childView = [self getLeftView];
            }
        } else {
            if (!_showingLeftMenu) {
                childView = [self getRightView];
            }
            
        }
        [self.view sendSubviewToBack:childView];
        [[sender view] bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        if(velocity.x > 0) {
            // NSLog(@"gesture went right");
        } else {
            // NSLog(@"gesture went left");
        }
        
        if (!_showPanel) {
            [self moveMenuToOriginalPosition];
        } else {
            if (_showingLeftMenu) {
                _showingLeftMenu = NO;
                [self presentLeftMenu];
            }  else if (_showingRightMenu) {
                _showingRightMenu = NO;
                [self presentRightMenu];
            }
        }
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        if(velocity.x > 0) {
            // NSLog(@"gesture went right");
        } else {
            // NSLog(@"gesture went left");
        }
        
        
        _showPanel = fabs([sender view].center.x - _centerViewController.view.frame.size.width/2) > _centerViewController.view.frame.size.width/2;
        
        
        [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
        [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
        
        
        if(velocity.x*_preVelocity.x + velocity.y*_preVelocity.y > 0) {
            // NSLog(@"same direction");
        } else {
            // NSLog(@"opposite direction");
        }
        
        _preVelocity = velocity;
    }
    
}




@end
