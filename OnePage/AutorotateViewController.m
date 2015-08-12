//
//  AutorotateViewController.m
//  OnePage
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "AutorotateViewController.h"

@interface AutorotateViewController ()

@end

@implementation AutorotateViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}

//不支持旋转
- (BOOL)shouldAutorotate {
    return NO;
}


//注意:如果我的原VC是横屏，但是弹出来一个要竖屏的.此时不能重写下面的方法,否则崩溃
//支持的旋转方向
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationPortrait;
}

//一开始的屏幕旋转方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
