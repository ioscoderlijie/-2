//
//  HeaderCollectionViewCell.m
//  OnePage
//
//  Created by lanouhn on 15/7/28.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "HeaderCollectionViewCell.h"

@implementation HeaderCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.headerView];
    }
    return self;
}

- (UIView *)headerView {
    if (!_headerView) {
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
        self.headerView.backgroundColor = [UIColor grayColor];
    }
    return _headerView;
}
@end
