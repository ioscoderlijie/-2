//
//  BaseTableViewCell.h
//  OnePage
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *headerImage;
@property (strong, nonatomic) UILabel *headerNameLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UIView *mainView;

@end
