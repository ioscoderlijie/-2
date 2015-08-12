//
//  MovieViewController.m
//  OnePage
//
//  Created by lanouhn on 15/7/30.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "MovieViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "URL.h"
#import "MJRefresh.h"
#import "MovicModel.h"
#import "MovieTableViewCell.h"
#import "SendValueTap.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MovieViewController () {
    int pageNum;
}
//系统播放器
@property (nonatomic, strong)  MPMoviePlayerViewController *videoPlayer;

//是否是第一次轻拍
@property (nonatomic, assign) BOOL isFirstTap;

//存储轻拍的cell的位置
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置导航条样式
    [self configureNacStyle];
    //网络请求
    [self netWorkRequest:1];
    //刷新数据
    [self refreshData];
    pageNum = 1;
    [self.tableView registerClass:[MovieTableViewCell class] forCellReuseIdentifier:@"cell"];
}


#pragma mark - 下拉刷新
- (void)loadNewData {
    [self netWorkRequest:1];
    [self.tableView.header endRefreshing];
}

#pragma mark - 上拉加载
- (void)loadMoreData {
    [self netWorkRequest:++pageNum];
    [self.tableView.footer endRefreshing];
}

#pragma mark - 网络请求
- (void)netWorkRequest:(int)page {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    //拼接路径
    NSString *headerPart = [NSString stringWithFormat:kMovicAPI, page];
    NSString *totalURl = [NSString stringWithFormat:@"%@%@", headerPart, kSubLifeAPI];
    __block MovieViewController *weakSelf = self;
    
    [manager GET:totalURl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果是下拉刷新,则删除数据
        if (weakSelf.isPullRefresh) {
            [weakSelf.dataSource removeAllObjects];
        }
        NSArray *listArr = responseObject[@"list"];
        for (NSDictionary *tempDic in listArr) {
            MovicModel *model = [MovicModel movicWithDictionary:tempDic];
            [weakSelf.dataSource addObject:model];
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}


#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    MovicModel *model = self.dataSource[indexPath.row];
    cell.backgroundColor = [UIColor lightGrayColor];
    [cell configureCellInfo:model];
    //调整cell的高度
    [cell adjustCellHeight:model];
    
    //给cell上的contentImage设置轻拍手势
    SendValueTap *tap = [[SendValueTap alloc] initWithTarget:self action:@selector(playMovic:)];
    [cell.contentImage addGestureRecognizer:tap];
    //传值,将当前点击的视频所在的cell的位置传过去
    tap.indexPath = indexPath;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovicModel *model = self.dataSource[indexPath.row];
    CGFloat height = (kScreenWidth - 55) / [model.width floatValue] * [model.height floatValue];
    return 130 + height + [MovieTableViewCell calculateTextHeight:model];
}


#pragma mark - event response
//对播放界面轻拍时,创建播放的界面
- (void)playMovic:(SendValueTap *)tap {
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    MovicModel *model = self.dataSource[tap.indexPath.row];
    NSLog(@"%@", model.videouri);
    
    //创建系统播放器
    self.videoPlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:model.videouri]];
    [self.videoPlayer.moviePlayer prepareToPlay];
    
    [self.videoPlayer.moviePlayer setScalingMode:MPMovieScalingModeAspectFit];
    [self.videoPlayer.moviePlayer setControlStyle:MPMovieControlStyleDefault];
    
    //获取轻拍手势添加的cell
    MovieTableViewCell *movicCell = (MovieTableViewCell *)[self.tableView cellForRowAtIndexPath:tap.indexPath];
    
    [movicCell.mainView addSubview:self.videoPlayer.view];
    [self.videoPlayer.view setFrame:movicCell.contentImage.frame];
    [self.videoPlayer.moviePlayer play];
    
}

- (void)moviePlayDidEnd:(id)sender {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//配置导航条样式
- (void)configureNacStyle {
    self.navigationItem.title = @"微视频";
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


@end
