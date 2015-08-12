//
//  MovicModel.h
//  OnePage
//
//  Created by lanouhn on 15/7/30.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovicModel : NSObject
//用户名
@property (nonatomic, copy) NSString *screen_name;
//正文信息
@property (nonatomic, copy) NSString *text;
//图片的宽高
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *height;
//用户头像
@property (nonatomic, copy) NSString *profile_image;
//展示图片
@property (nonatomic, copy) NSString *bimageuri;
//视频链接
@property (nonatomic, copy) NSString *videouri;
//视频总时长
@property (nonatomic, copy) NSString *videotime;
//视频发布时间
@property (nonatomic, copy) NSString *create_time;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)movicWithDictionary:(NSDictionary *)dic;

@end
