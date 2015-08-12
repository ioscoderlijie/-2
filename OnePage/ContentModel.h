//
//  ContentModel.h
//  OnePage
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentModel : NSObject
//正文
@property (nonatomic, copy) NSString *title;
//正文图片
@property (nonatomic, copy) NSString *img_url;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)contentWithDictionary:(NSDictionary *)dic;

@end
