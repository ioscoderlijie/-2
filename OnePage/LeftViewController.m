//
//  LeftViewController.m
//  OnePage
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "LeftViewController.h"
#import "ListsViewCell.h"
#import "LifeTableViewController.h"
#import "DrawImageTableViewController.h"
#import "MovieViewController.h"

@interface LeftViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *headerImageArr;
@property (strong, nonatomic) NSArray *titleArr;
@property (strong, nonatomic) NSArray *subTitleArr;
@end

@implementation LeftViewController
- (void)loadView {
    [super loadView];
    //将tableView作为视图的根视图
    self.tableView = [[UITableView alloc] initWithFrame:
        CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //去掉多余的行
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //设置tableView的背景颜色
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"left"];
    [self.tableView setBackgroundView:imageView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ListsViewCell class] forCellReuseIdentifier:@"cell"];
    //设置cell数据
    [self setUpDataOfCell];
   
}
//给cell设置数据
- (void)setUpDataOfCell {
    self.headerImageArr = @[@"baike.jpg", @"shipin.jpg", @"lvxing.jpg", @"music.jpg", @"chahua.jpg", @"qiu.jpg", @"neihan.jpg"];
    self.titleArr = @[@"生活百科", @"微视频", @"旅行", @"音乐", @"插画", @"糗事", @"内涵"];
    self.subTitleArr = @[@"生活,生下来,活下去", @"如果这是我", @"travel the world", @"想唱就唱,要唱的闪亮", @"看不完的风景", @"看不完,乐不完", @"心灵的美来自自然"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.headerImageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //清除背景颜色
    cell.backgroundColor = [UIColor clearColor];
    cell.headerImage.image = [UIImage imageNamed:self.headerImageArr[indexPath.row]];
    cell.titleLabel.text = self.titleArr[indexPath.row];
    cell.subTitleLabel.text = self.subTitleArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        LifeTableViewController *lifeTVC = [[LifeTableViewController alloc] init];
        //跳转样式
        lifeTVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lifeTVC];
        
        [self presentViewController:nav animated:YES completion:nil];
    }
    if (1 == indexPath.row) {
        MovieViewController *movicTVC = [[MovieViewController alloc] init];
        movicTVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:movicTVC];
        
        [self presentViewController:nav animated:YES completion:nil];
    }
    if (4 == indexPath.row) {
        DrawImageTableViewController *drawImageTVC = [[DrawImageTableViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:drawImageTVC];
        
        [self presentViewController:nav animated:YES completion:nil];
    }

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
