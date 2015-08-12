//
//  DrawImageCell.h
//  OnePage
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "LifeModel.h"
@interface DrawImageCell : BaseTableViewCell
@property (strong, nonatomic) UIImageView *contentImage;

- (void)configureCellInfo:(LifeModel *)lifeModel;

//自适应cell的高度
- (void)adjustCellHeight:(LifeModel *)model;
//计算图片的高度
- (CGFloat)calculateCellHeight:(LifeModel *)model;

@end
