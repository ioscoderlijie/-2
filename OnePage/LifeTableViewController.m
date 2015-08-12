//
//  LifeTableViewController.m
//  OnePage
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "LifeTableViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "URL.h"
#import "LifeModel.h"
#import "LifeTableViewCell.h"
#import "MJRefresh.h"

@interface LifeTableViewController () {
    int pageCount;
}
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) BOOL isPullRefresh;
@end

@implementation LifeTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //配置导航条样式
    [self configureNacStyle];
    self.navigationItem.title = @"生活百科";
    
    [self.tableView registerClass:[LifeTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //网络请求
    [self netWorkRequest:1];
    //标识当前刷新的页数
    pageCount = 1;
    //刷新数据
    [self addRefreshControl];
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
    self.navigationItem.title = @"生活百科";
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
    
    __block LifeTableViewController *blockSelf = self;
    
    //地址拼接
    NSString *childPart = [NSString stringWithFormat:kLifeAPI, page];
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
    LifeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    LifeModel *life = (LifeModel *)self.dataSource[indexPath.row];
    cell.backgroundColor = [UIColor lightGrayColor];
    //配置cell
    [cell configureCellInfo:life];
  
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 290;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
