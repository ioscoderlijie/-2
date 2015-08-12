//
//  ImageTableViewCell.h
//  OnePage
//
//  Created by lanouhn on 15/7/30.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoModel.h"

@interface ImageTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *myImageView;
@property (strong, nonatomic) UILabel *infoImageLabel;

- (void)configureCellWithModel:(InfoModel *)model;

//计算高度
+ (CGFloat)calculateHeight:(InfoModel *)model;

//调整高度
- (void)adjustSubviewsFrame:(InfoModel *)model;

@end
