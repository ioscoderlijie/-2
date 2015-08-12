//
//  MovieTableViewCell.m
//  OnePage
//
//  Created by lanouhn on 15/7/30.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "MovieTableViewCell.h"
#import "UIImageView+WebCache.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation MovieTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.mainView addSubview:self.contentImage];
        [self.mainView addSubview:self.playerImage];
    }
    return self;
}

- (UIImageView *)contentImage {
    if (!_contentImage) {
        self.contentImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.headerImage.frame) - 8, CGRectGetMaxY(self.contentLabel.frame) + 10, CGRectGetWidth(self.contentLabel.frame) + 15, 200)];
        //打开用户交互功能
        _contentImage.userInteractionEnabled = YES;
    }
    return _contentImage;
}

- (UIImageView *)playerImage {
    if (!_playerImage) {
        self.playerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_play"]];
        _playerImage.center = _contentImage.center;
    }
    return _playerImage;
}

//配置cell样式
- (void)configureCellInfo:(MovicModel *)model {
    //用户头像
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"qq.jpg"]];
    //用户名
    self.headerNameLabel.text = model.screen_name;
    //正文信息
    self.contentLabel.text = model.text;
    //发布时间
    self.timeLabel.text = model.create_time;
    //正文图片
    [self.contentImage sd_setImageWithURL:[NSURL URLWithString:model.bimageuri] placeholderImage:[UIImage imageNamed:@"LinkTextDefaultIcon"]];
}

//动态修改正文图片的高度
- (void)adjustCellHeight:(MovicModel *)model {
    //调整正文的高度
    CGFloat textHeight = [self.contentLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth - 30 * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
    CGRect textFrame = self.contentLabel.frame;
    textFrame.size.height = textHeight;
    self.contentLabel.frame = textFrame;
    
    CGFloat height = CGRectGetWidth(self.contentImage.frame) / [model.width floatValue] * [model.height floatValue];
    CGRect contetImageFrame = self.contentImage.frame;
    contetImageFrame.size.height = height;
    contetImageFrame.origin.y = CGRectGetMaxY(self.contentLabel.frame) + 10;
    self.contentImage.frame = contetImageFrame;
    //让图片的中心点作为播放按钮的中心点
    self.playerImage.center = self.contentImage.center;
    
    CGRect mainViewFrame = self.mainView.frame;
    mainViewFrame.size.height = height +  textHeight + 100;
    self.mainView.frame = mainViewFrame;
}

+ (CGFloat)calculateTextHeight:(MovicModel *)model {
    //调整正文的高度
    CGFloat textHeight = [model.text boundingRectWithSize:CGSizeMake(kScreenWidth - 30 * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
    return textHeight;
}
@end
