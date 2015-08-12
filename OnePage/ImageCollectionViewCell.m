//
//  ImageCollectionViewCell.m
//  OnePage
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#define kCoverImageHeight 220
#define kContentLabelHeight 80
#define kFooterViewHeight 70

@interface ImageCollectionViewCell ()
//图片和内容
@property (strong, nonatomic) UIImageView *coverImage;
@property (strong, nonatomic) UILabel *contentLabel;
//脚的显示
@property (strong, nonatomic) UIView *footerView;
//用户头像和用户信息
@property (strong, nonatomic) UIImageView *userImage;
@property (strong, nonatomic) UILabel *userLabel;

@end
@implementation ImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //添加子控件
        [self.contentView addSubview:self.coverImage];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.footerView];
        [self.footerView addSubview:self.userImage];
        [self.footerView addSubview:self.userLabel];
    }
    return self;
}

- (UIImageView *)coverImage {
    if (!_coverImage) {
        self.coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kCoverImageHeight)];
        _coverImage.backgroundColor = [UIColor yellowColor];
    }
    return _coverImage;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(_coverImage.frame) + 15, CGRectGetWidth(_coverImage.frame) - 2 * 10, 40)];
        //设置分行显示
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textColor = [UIColor colorWithRed:0 green:100 / 255.0 blue:0 alpha:1.0];
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _contentLabel;
}

- (UIView *)footerView {
    if (!_footerView) {
        self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_contentLabel.frame), CGRectGetWidth(_coverImage.frame), kFooterViewHeight)];
        _footerView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:228 / 255.0 blue:225 / 255.0 alpha:1.0];
    }
    return _footerView;
}

- (UIImageView *)userImage {
    if (!_userImage) {
        self.userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 40, 40)];
        _userImage.layer.cornerRadius = 20;
        _userImage.layer.masksToBounds = YES;
    }
    return _userImage;
}

- (UILabel *)userLabel {
    if (!_userLabel) {
        self.userLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImage.frame) + 5, CGRectGetMinY(_userImage.frame) - 5, CGRectGetWidth(_footerView.frame) - CGRectGetMaxX(_userImage.frame) - 20, 40)];
        _userLabel.numberOfLines = 0;
        _userLabel.font = [UIFont systemFontOfSize:14];
    }
    return _userLabel;
}

- (void)configureCellWithModel:(CollectionCellModel *)model {
    [_coverImage sd_setImageWithURL:[NSURL URLWithString:model.file_key]];
    _contentLabel.text = model.raw_text;
    [_userImage sd_setImageWithURL:[NSURL URLWithString:model.avatarKey] placeholderImage:[UIImage imageNamed:@"qq.jpg"]];
    
    _userLabel.text = [NSString stringWithFormat:@"由 %@ 采集到 %@", model.username, model.title];
    
}

+ (CGFloat)calculateHeight:(CollectionCellModel *)model {
    //动态计算文本的高度
    CGRect rectContent = [model.raw_text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * 10, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    CGRect infoContent = [model.title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 70, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
    return rectContent.size.height + infoContent.size.height;
}

//调整高度
- (void)adjustSubviewsFrame:(CollectionCellModel *)model {
    //动态计算图片的高度
    CGFloat height = _coverImage.frame.size.width / [model.width floatValue] * [model.height floatValue];
    //获取content以前的高度
    CGRect rectCoverImage = _coverImage.frame;
    //把动态计算出来的高度赋给rect
    rectCoverImage.size.height = height;
    //给_coverImage赋值
    _coverImage.frame = rectCoverImage;
    
    //动态计算文本的高度
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //设置行的截取方式， 以每个字符来进行截取
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13], NSParagraphStyleAttributeName:paragraphStyle};
    
    CGFloat contentHeight = [model.raw_text  boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * 10, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.height;
    CGRect rectContent = _contentLabel.frame;
    rectContent.size.height = contentHeight + 20;
    rectContent.origin.y = CGRectGetMaxY(_coverImage.frame);
    _contentLabel.frame = rectContent;
    
    
    //动态计算采集信息的高度
     CGRect infoHeight = [model.title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 75, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    CGRect infoContent = _userLabel.frame;
    infoContent.size.height = infoHeight.size.height + 50;
    _userLabel.frame = infoContent;
    
    CGRect footerHeight = _footerView.frame;
    footerHeight.origin.y = CGRectGetMaxY(_contentLabel.frame);
    footerHeight.size.height = CGRectGetHeight(_userLabel.frame) + 40;
    _footerView.frame = footerHeight;
    
}

@end
