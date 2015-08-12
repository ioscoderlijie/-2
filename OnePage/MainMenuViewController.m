//
//  MainMenuViewController.m
//  OnePage
//
//  Created by lanouhn on 15/7/28.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ImageCollectionViewCell.h"
#import "CollectionCellModel.h"
#import "AFNetworking.h"
#import "URL.h"
#import "NetworkStatus.h"
#import "UICollectionViewWaterfallLayout.h"
#import "MJRefresh.h"
#import "InfoTableViewController.h"

@interface MainMenuViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateWaterfallLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
//存储cell的展示数据的对象
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) UICollectionViewWaterfallLayout *waterFlow;

@property (assign, nonatomic) BOOL isPullRefresh; //判断是否是下拉刷新
@property (strong, nonatomic) NSNumber *maxNum; //每次加载的变量值
@property (copy, nonatomic) NSString *status; //网络状态
@end

static NSString * const reuseIdentifier = @"cell";
@implementation MainMenuViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCollectionView];//创建集合视图
    //判断当前的网络的状态
    self.status = [NetworkStatus networkingStatesFromStatebar];
    //网络请求
    [self netWorkRequest:kFirstCollectionCellAPI];
    //下拉刷新
    [self addRefreshControl];
}


#pragma mark - 下拉刷新
- (void)addRefreshControl {
    // 给tableView添加下拉刷新功能
    __weak __typeof(self) weakSelf = self;
    
    //下拉刷新
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    //上拉加载
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
}

- (void)loadData {
    self.isPullRefresh = YES;
    [self netWorkRequest:kFirstCollectionCellAPI];
    [self.collectionView.header endRefreshing];
}

// 加载更多数据
- (void)loadMoreData
{
    self.isPullRefresh = NO;
    [self netWorkRequest:[NSString stringWithFormat:kCollectionCellAPI, self.maxNum]];
    [self.collectionView.footer endRefreshing];
}

//数组初始化
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - create subviews
//创建集合视图
- (void)createCollectionView {
    /**
     布局瀑布流效果, 要自定义布局样式, 继承自UICollectionViewLayout
     UICollectionViewWaterfallLayout 是第三方的一个瀑布流样式
     */
    //    UICollectionViewFlowLayout
    self.waterFlow = [[UICollectionViewWaterfallLayout alloc] init];
    //1.设置item的宽度
    _waterFlow.itemWidth = kItemWidth;
    //2.设置每个分区的缩进量
    _waterFlow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //3.设置列数
    _waterFlow.columnCount = 2;
    //3.设置代理, 用来动态返回每一个item的高度
    _waterFlow.delegate = self;
    //4.设置最小行间距
    _waterFlow.minLineSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.waterFlow];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    
    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:self.collectionView];
}

#pragma mark - 网络请求
- (void)netWorkRequest: (NSString *)API {
    //当前网络状态不为离线状态
    if (![self.status isEqualToString:@"notReachable"]) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        __block MainMenuViewController *blockSelf = self;
        
        //瀑布流布局
        
        [manager GET:API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //如果是下拉刷新,删除以前的数据
            if (self.isPullRefresh) {
                //移除之前的数据
                [blockSelf.dataSource removeAllObjects];
            }

            
            NSArray *pinArr = responseObject[@"pins"];
            
            for (NSDictionary *tempDic in pinArr) {
                CollectionCellModel *model = [[CollectionCellModel alloc] initWithDictionary:tempDic];
                [blockSelf.dataSource addObject:model];
            }
            NSUInteger count = pinArr.count;
            //获取数组中最后一页的pin_id, 就是下一页加载的标识
            self.maxNum = pinArr[count - 1][@"pin_id"];
            //刷新数据
            [blockSelf.collectionView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
        
    } else {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"数据加载失败,请检查网络"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (self.dataSource.count) {
        CollectionCellModel *model = (CollectionCellModel *)self.dataSource[indexPath.row];
        [cell configureCellWithModel:model];
        //设置cell圆角
        cell.layer.cornerRadius = 8;
        cell.layer.masksToBounds = YES;
        cell.backgroundColor = [UIColor whiteColor];
        //调整高度
        [cell adjustSubviewsFrame:model];
    }
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewWaterfallLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    CollectionCellModel *model = (CollectionCellModel *)self.dataSource[indexPath.row];
    CGFloat heightImage = kItemWidth / [model.width floatValue] * [model.height floatValue];
    return [ImageCollectionViewCell calculateHeight:model] + heightImage + 80;
    
}

//点击item时,触发的事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableViewController *infoTVC = [[InfoTableViewController alloc] init];
    CollectionCellModel *collectionModel = (CollectionCellModel *)self.dataSource[indexPath.row];
    //传值
    infoTVC.pin_id = collectionModel.pin_id;
    
    [self.navigationController pushViewController:infoTVC animated:YES];
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
