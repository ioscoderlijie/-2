//
//  MoviePlayerView.h
//  OnePage
//
//  Created by lanouhn on 15/7/31.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviePlayerView : UIView
//播放按钮
@property (nonatomic, strong) UIButton *playButton;
//显示开始播放的时间label
@property (nonatomic, strong) UILabel *startTimeLabel;
//显示结束播放的时间label
@property (nonatomic, strong) UILabel *endTimeLabel;
//播放进度的slider
@property (nonatomic, strong) UISlider *progressSilder;
//调整播放方式:全屏或半屏
@property (nonatomic, strong) UIButton *rotationImage;

//  自定义播放界面上的底部的操作视图
@property (nonatomic, strong) UIView *playerBar;
@end
