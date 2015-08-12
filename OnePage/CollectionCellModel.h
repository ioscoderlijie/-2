//
//  CollectionCellModel.h
//  OnePage
//
//  Created by lanouhn on 15/7/28.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionCellModel : NSObject
@property (strong, nonatomic) NSNumber *pin_id;
//图片路径
@property (copy, nonatomic) NSString *file_key;
//图片宽度
@property (strong, nonatomic) NSNumber *width;
//图片高度
@property (strong, nonatomic) NSNumber *height;
@property (copy, nonatomic) NSString *raw_text;
//采集者昵称
@property (copy, nonatomic) NSString *username;

//采集到哪个主题下
@property (copy, nonatomic) NSString *title;
//头像
@property (copy, nonatomic) NSString *avatarKey;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
