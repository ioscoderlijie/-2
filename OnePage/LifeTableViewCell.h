//
//  LifeTableViewCell.h
//  OnePage
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LifeModel.h"
#import "BaseTableViewCell.h"

@interface LifeTableViewCell :BaseTableViewCell
@property (strong, nonatomic) UIImageView *contentImage;

- (void)configureCellInfo:(LifeModel *)lifeModel;

@end
