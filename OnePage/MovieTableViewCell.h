//
//  MovieTableViewCell.h
//  OnePage
//
//  Created by lanouhn on 15/7/30.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MovicModel.h"

@interface MovieTableViewCell : BaseTableViewCell
@property (strong, nonatomic) UIImageView *contentImage;

//播放按钮
@property (strong, nonatomic) UIImageView *playerImage;

//配置cell信息
- (void)configureCellInfo:(MovicModel *)model;
//动态修改正文图片的高度
- (void)adjustCellHeight:(MovicModel *)model;

+ (CGFloat)calculateTextHeight:(MovicModel *)model;
@end
