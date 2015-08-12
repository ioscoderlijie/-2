//
//  BaseTableViewController.h
//  OnePage
//
//  Created by lanouhn on 15/7/30.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController
@property (assign, nonatomic) BOOL isPullRefresh;
@property (strong, nonatomic) NSMutableArray *dataSource;

//刷新
- (void)refreshData;
//下拉刷新
- (void)loadNewData;
//上拉加载
- (void)loadMoreData;
@end
