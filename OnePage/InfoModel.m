//
//  InfoModel.m
//  OnePage
//
//  Created by lanouhn on 15/7/30.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "InfoModel.h"
#import "URL.h"

@implementation InfoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        //图片路径
        self.file_key = [NSString stringWithFormat:kCollectionImageAPI, dic[@"file"][@"key"]];
        //图片宽高
        self.width = dic[@"file"][@"width"];
        self.height = dic[@"file"][@"height"];
    }
    return self;
}

+ (instancetype)infoWithDictionary:(NSDictionary *)dic {
    return [[InfoModel alloc] initWithDictionary:dic];
}
@end
