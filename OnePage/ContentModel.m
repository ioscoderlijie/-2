//
//  ContentModel.m
//  OnePage
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "ContentModel.h"

@implementation ContentModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


//遍历构造器
+ (ContentModel *)contentWithDictionary:(NSDictionary *)dic {
    return [[ContentModel alloc] initWithDictionary:dic];
}


@end
