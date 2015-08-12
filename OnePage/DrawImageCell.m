//
//  DrawImageCell.m
//  OnePage
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "DrawImageCell.h"
#import "URL.h"
#import "UIImageView+WebCache.h"

@implementation DrawImageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.mainView addSubview:self.contentImage];
        
        //设置cell上mainView的大小
        CGRect mainFrame = self.mainView.frame;
        mainFrame.size.height = 420;
        self.mainView.frame = mainFrame;
    }
    return self;
}

//添加主页图片
- (UIImageView *)contentImage {
    if (!_contentImage) {
        self.contentImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.headerImage.frame), CGRectGetMaxY(self.contentLabel.frame) + 10, CGRectGetWidth(self.contentLabel.frame), 280)];
        _contentImage.userInteractionEnabled = YES;
    }
    return _contentImage;
}

- (void)configureCellInfo:(LifeModel *)lifeModel {
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:lifeModel.profile_image] placeholderImage:[UIImage imageNamed:@"qq.jpg"]];
    self.headerNameLabel.text = lifeModel.screen_name;
    self.timeLabel.text = lifeModel.created_at;
    self.contentLabel.text = lifeModel.text;
    
    //第三方有缓存机制,相当于图片已下载.下载图片后,可以直接通过UIImage的size获取图片大小
    [self.contentImage sd_setImageWithURL:[NSURL URLWithString:lifeModel.cdn_img] placeholderImage:[UIImage imageNamed:@"LinkTextDefaultIcon"]];
}

//自适应cell的高度
- (void)adjustCellHeight:(LifeModel *)mode {
    //设置图片自适应的高度
    CGFloat height = self.contentImage.frame.size.width / self.contentImage.image.size.width * self.contentImage.image.size.height;
    NSLog(@"height = %f", height);
    CGRect originFrame = self.contentImage.frame;
    originFrame.size.height = height;
    self.contentImage.frame = originFrame;
}


//计算图片的高度
- (CGFloat)calculateCellHeight:(LifeModel *)model {
    return self.contentImage.frame.size.width / self.contentImage.image.size.width * self.contentImage.image.size.height;
}

@end
