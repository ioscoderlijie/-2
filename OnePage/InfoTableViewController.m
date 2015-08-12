//
//  InfoTableViewController.m
//  OnePage
//
//  Created by lanouhn on 15/7/30.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "InfoTableViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "URL.h"
#import "InfoModel.h"
#import "ImageTableViewCell.h"

@interface InfoTableViewController ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation InfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTVCStyle];
    [self netWorkRequest];
}

//初始化数组
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)setTVCStyle {
    self.navigationItem.title = @"采集详情";
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-100.0, 0) forBarMetrics:UIBarMetricsDefault];
    //取出多余的行
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //注册cell
    [self.tableView registerClass:[ImageTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)netWorkRequest {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    __block InfoTableViewController *weakSelf = self;
    
    NSString *api = [NSString stringWithFormat:kInfoCollectionImageAPI, self.pin_id];
    [manager GET:api parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        InfoModel *infoModel = [InfoModel infoWithDictionary:responseObject[@"pin"]];
        [weakSelf.dataSource addObject:infoModel];
        [weakSelf.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据加载失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    InfoModel *infoModel = (InfoModel *)self.dataSource[indexPath.row];
    //配置cell
    [cell configureCellWithModel:infoModel];
    //调整cell的高度
    [cell adjustSubviewsFrame:infoModel];
    
    return cell;
}

//动态计算cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     InfoModel *infoModel = (InfoModel *)self.dataSource[indexPath.row];
    return [ImageTableViewCell calculateHeight:infoModel] + kScreenWidth / [infoModel.width floatValue] * [infoModel.height floatValue] + 30;
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
