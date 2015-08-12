//
//  LifeTableViewController.m
//  OnePage
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "DrawImageTableViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "URL.h"
#import "LifeModel.h"
#import "DrawImageCell.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "ImageViewController.h"
#import "SendValueTap.h"

@interface DrawImageTableViewController () {
    int pageCount;
}
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) BOOL isPullRefresh;

@property (assign, nonatomic) NSInteger height;
//存储图片大小
@property (strong, nonatomic) NSMutableArray *imageSizeArr;
@end

@implementation DrawImageTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //配置导航条样式
    [self configureNacStyle];
    [self.tableView registerClass:[DrawImageCell class] forCellReuseIdentifier:@"cell"];
    //网络请求
    [self netWorkRequest:1];
    //标识当前刷新的页数
    pageCount = 1;
    //刷新数据
    [self addRefreshControl];
}

//存储动态设置后的图片的高度
- (NSMutableArray *)imageSizeArr {
    if (!_imageSizeArr) {
        self.imageSizeArr = [NSMutableArray array];
    }
    return _imageSizeArr;
}

#pragma mark - 加载数据
- (void)addRefreshControl {
    __weak __typeof(self) weakSelf = self;
    
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    //上拉加载
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}
//下拉刷新
- (void)loadNewData {
    self.isPullRefresh = YES;
    
    [self netWorkRequest:1];
    [self.tableView.header endRefreshing];
}
//上拉加载
- (void)loadMoreData {
    self.isPullRefresh = NO;
    [self netWorkRequest:++pageCount];
    [self.tableView.footer endRefreshing];
}

//初始化数组
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

//配置导航条样式
- (void)configureNacStyle {
    self.navigationItem.title = @"插画";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 30, 27, 27)];
    imageView.image = [UIImage imageNamed:@"leaf"];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    
    [imageView addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//网路请求
- (void)netWorkRequest:(int)page {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    __block DrawImageTableViewController *blockSelf = self;
    
    //地址拼接
    NSString *childPart = [NSString stringWithFormat:kDrawImageAPI, page];
    NSString *superPart = [NSString stringWithFormat:@"%@%@", childPart, kSubLifeAPI];
    
    [manager GET:superPart parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果是下拉刷新,删除以前的数据
        if (self.isPullRefresh) {
            //移除之前的数据
            [blockSelf.dataSource removeAllObjects];
        }
        
        NSArray *listsArr = responseObject[@"list"];
        for (NSDictionary *tempDic in listsArr) {
            LifeModel *life = [LifeModel lifeWithDictionary:tempDic];
            [blockSelf.dataSource addObject:life];
        }
        //刷新数据
        [blockSelf.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"亲,数据加载失败了"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DrawImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    LifeModel *life = (LifeModel *)self.dataSource[indexPath.row];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    //配置cell
    [cell configureCellInfo:life];
    
    SendValueTap *tap = [[SendValueTap alloc] initWithTarget:self action:@selector(toNextView:)];
    //将当前轻拍的图片地址传过去
    tap.userInfo = life.cdn_img;
    [cell.contentImage addGestureRecognizer:tap];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 440;
}

- (void)toNextView:(SendValueTap *)tap {
    ImageViewController *imageVC = [[ImageViewController alloc] init];
    imageVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    imageVC.imageURL = tap.userInfo;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:imageVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}

@end
