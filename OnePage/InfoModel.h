//
//  InfoModel.h
//  OnePage
//
//  Created by lanouhn on 15/7/30.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoModel : NSObject
@property (nonatomic, copy) NSString *file_key;
@property (nonatomic, copy) NSString *raw_text;
//图片宽度
@property (strong, nonatomic) NSNumber *width;
//图片高度
@property (strong, nonatomic) NSNumber *height;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)infoWithDictionary:(NSDictionary *)dic;

@end
