//
//  LifeTableViewCell.m
//  OnePage
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "LifeTableViewCell.h"
#import "URL.h"
#import "UIImageView+WebCache.h"

@implementation BaseTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.mainView];
        [self.mainView addSubview:self.headerImage];
        [self.mainView addSubview:self.headerNameLabel];
        [self.mainView addSubview:self.timeLabel];
        [self.mainView addSubview:self.contentLabel];
    }
    return self;
}

- (UIView *)mainView {
    if (!_mainView) {
        self.mainView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 270)];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.layer.cornerRadius = 10;
        
    }
    return _mainView;
}

//添加头像
- (UIImageView *)headerImage {
    if (!_headerImage) {
        self.headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 40, 40)];
        //设置圆角
        _headerImage.layer.cornerRadius = 20;
        _headerImage.layer.masksToBounds = YES;
    }
    return _headerImage;
}

//添加用户名
- (UILabel *)headerNameLabel {
    if (!_headerNameLabel) {
        self.headerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headerImage.frame) + 10, CGRectGetMinY(_headerImage.frame), kScreenWidth - CGRectGetMaxX(_headerImage.frame) - 10, 25)];
        _headerNameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _headerNameLabel;
}

//添加发布时间
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_headerNameLabel.frame), CGRectGetMaxY(_headerNameLabel.frame) + 5, CGRectGetWidth(_headerNameLabel.frame), 15)];
        _timeLabel.font = [UIFont systemFontOfSize:11];
    }
    return _timeLabel;
}

//添加正文文字
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_headerImage.frame) - 5, CGRectGetMaxY(_headerImage.frame) + 15, kScreenWidth - 30 * 2, 30)];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
