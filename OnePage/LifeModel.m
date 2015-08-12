//
//  LifeModel.m
//  OnePage
//
//  Created by lanouhn on 15/7/29.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "LifeModel.h"

@implementation LifeModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"richtxt"]) {
        self.contentModel = [ContentModel contentWithDictionary:value];
    }
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
//便利构造器
+ (instancetype)lifeWithDictionary:(NSDictionary *)dic {
    return [[LifeModel alloc] initWithDictionary:dic];
}

@end
