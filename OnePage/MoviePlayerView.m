//
//  MoviePlayerView.m
//  OnePage
//
//  Created by lanouhn on 15/7/31.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "MoviePlayerView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation MoviePlayerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.playerBar];
        [self.playerBar addSubview:self.playButton];
        [self.playerBar addSubview:self.startTimeLabel];
        [self.playerBar addSubview:self.progressSilder];
        [self.playerBar addSubview:self.endTimeLabel];
        [self.playerBar addSubview:self.rotationImage];
    }
    return self;
}

//在播放底部添加操作播放的按钮
- (UIView *)playerBar {
    if (!_playerBar) {
        self.playerBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
        _playerBar.backgroundColor = [UIColor blackColor];
        _playerBar.alpha = 0.69;
    }
    return _playerBar;
}
//添加播放按钮
- (UIButton *)playButton {
    if (!_playButton) {
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playButton.frame = CGRectMake(10, 15, 30, 30);
        //设置显示图片
        [_playButton setBackgroundImage:[UIImage imageNamed:@"voice-play-start"] forState:UIControlStateNormal];
    }
    return _playButton;
}
//添加开始播放时间
- (UILabel *)startTimeLabel {
    if (!_startTimeLabel) {
        self.startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_playButton.frame), CGRectGetMinY(_playButton.frame), 50, CGRectGetHeight(_playButton.frame))];
        _startTimeLabel.text = @"00:00";
        _startTimeLabel.textColor = [UIColor whiteColor];
        _startTimeLabel.adjustsFontSizeToFitWidth = YES;
        _startTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _startTimeLabel;
}
//添加播放进度条
- (UISlider *)progressSilder {
    if (!_progressSilder) {
        //上面的self.frame高度没有设置,因此下面不能使用此视图布局
        self.progressSilder = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_startTimeLabel.frame), CGRectGetMinY(_startTimeLabel.frame), 150, CGRectGetHeight(_playButton.frame))];
    }
    return _progressSilder;
}
//添加总播放时间
- (UILabel *)endTimeLabel {
    if (!_endTimeLabel) {
        self.endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 18 - 80, CGRectGetMinY(_progressSilder.frame), 50, CGRectGetHeight(_progressSilder.frame))];
        _endTimeLabel.textColor = [UIColor whiteColor];
        _endTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _endTimeLabel;
}

//调整屏幕播放样式
- (UIButton *)rotationImage {
    if (!_rotationImage) {
        self.rotationImage = [UIButton buttonWithType:UIButtonTypeCustom];
        _rotationImage.frame = CGRectMake(kScreenWidth - 75, CGRectGetMinY(_playButton.frame), 30, CGRectGetHeight(_playButton.frame));
        [_rotationImage setBackgroundImage:[UIImage imageNamed:@"video_fullscreen.png"] forState:UIControlStateNormal];
    }
    return _rotationImage;
}
@end
