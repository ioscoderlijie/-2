//
//  MovicModel.m
//  OnePage
//
//  Created by lanouhn on 15/7/30.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "MovicModel.h"

@implementation MovicModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


+ (instancetype)movicWithDictionary:(NSDictionary *)dic {
    return [[MovicModel alloc] initWithDictionary:dic];
}
@end
