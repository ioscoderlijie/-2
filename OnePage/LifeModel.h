//
//  LifeModel.h
//  OnePage
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentModel.h"
@interface LifeModel : NSObject
//用户名
@property (nonatomic, copy) NSString *screen_name;
//发布时间
@property (nonatomic, copy) NSString *created_at;
//用户头像
@property (nonatomic, copy) NSString *profile_image;
@property (nonatomic, strong) ContentModel *contentModel;

//>>>>>>>>>>>>>>>>>>>>
//插画
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *cdn_img;


- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)lifeWithDictionary:(NSDictionary *)dic;
@end
