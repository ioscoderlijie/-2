//
//  ListsViewCell.m
//  OnePage
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "ListsViewCell.h"
#import "URL.h"

@implementation ListsViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone; //点击cell的时候没有颜色显示
        [self.contentView addSubview:self.cellView];
        [self.cellView addSubview:self.headerImage];
        [self.cellView addSubview:self.titleLabel];
        [self.cellView addSubview:self.subTitleLabel];
    }
    return self;
}

- (UIView *)cellView {
    if (!_cellView) {
        self.cellView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth -  100, 80)];
        _cellView.layer.cornerRadius = 40;
        _cellView.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:0 / 255.0 alpha:0.9];
    }
    return _cellView;
}

- (UIImageView *)headerImage {
    if (!_headerImage) {
        self.headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 70)];
        _headerImage.image = [UIImage imageNamed:@"qq.jpg"];
        _headerImage.layer.cornerRadius = 35;
        _headerImage.layer.masksToBounds = YES;
    }
    return _headerImage;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headerImage.frame) + 10, CGRectGetMinY(_headerImage.frame), kScreenWidth - CGRectGetMaxX(_headerImage.frame) - 10, 50)];
        _titleLabel.text = @"频道";
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame) - 10, CGRectGetWidth(_titleLabel.frame), 30)];
        _subTitleLabel.textColor = [UIColor darkGrayColor];
        _subTitleLabel.numberOfLines = 0;
        _subTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _subTitleLabel;
}

@end
