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

@implementation LifeTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.mainView addSubview:self.contentImage];
    }
    return self;
}

//添加主页图片
- (UIImageView *)contentImage {
    if (!_contentImage) {
        self.contentImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.headerImage.frame), CGRectGetMaxY(self.contentLabel.frame) + 10, CGRectGetWidth(self.contentLabel.frame) + 10, 150)];
    }
    return _contentImage;
}

- (void)configureCellInfo:(LifeModel *)lifeModel {
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:lifeModel.profile_image] placeholderImage:[UIImage imageNamed:@"qq.jpg"]];
    self.headerNameLabel.text = lifeModel.screen_name;
    self.timeLabel.text = lifeModel.created_at;
    self.contentLabel.text = lifeModel.contentModel.title;
    [self.contentImage sd_setImageWithURL:[NSURL URLWithString:lifeModel.contentModel.img_url] placeholderImage:[UIImage imageNamed:@"LinkTextDefaultIcon"]];
}
@end
