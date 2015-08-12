//
//  ImageTableViewCell.m
//  OnePage
//
//  Created by lanouhn on 15/7/30.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "ImageTableViewCell.h"
#import "UIImageView+WebCache.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width


@implementation ImageTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.myImageView];
        [self.contentView addSubview:self.infoImageLabel];
    }
    return self;
}

- (UIImageView *)myImageView {
    if (!_myImageView) {
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
        
    }
    return _myImageView;
}

- (UILabel *)infoImageLabel {
    if (!_infoImageLabel) {
        self.infoImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_myImageView.frame) + 10, kScreenWidth - 30, 40)];
        _infoImageLabel.numberOfLines = 0;
        _infoImageLabel.font = [UIFont systemFontOfSize:14];
    }
    return _infoImageLabel;
}

- (void)configureCellWithModel:(InfoModel *)model {
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:model.file_key]];
    self.infoImageLabel.text = model.raw_text;
}


+ (CGFloat)calculateHeight:(InfoModel *)model {
    //动态计算文本的高度
    CGRect rectContent = [model.raw_text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 3 * 10, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    return rectContent.size.height;
}

//调整高度
- (void)adjustSubviewsFrame:(InfoModel *)model {
    //动态计算图片的高度
    CGFloat height = kScreenWidth / [model.width floatValue] * [model.height floatValue];
    //获取content以前的高度
    CGRect rectCoverImage = _myImageView.frame;
    //把动态计算出来的高度赋给rect
    rectCoverImage.size.height = height;
    //给_coverImage赋值
    _myImageView.frame = rectCoverImage;
    
    //动态计算文本的高度
    CGFloat contentHeight = [ImageTableViewCell calculateHeight:model];
    CGRect rectContent = _infoImageLabel.frame;
    rectContent.size.height = contentHeight + 30;
    rectContent.origin.y = CGRectGetMaxY(_myImageView.frame);
    _infoImageLabel.frame = rectContent;
}

@end
