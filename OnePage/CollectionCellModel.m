//
//  CollectionCellModel.m
//  OnePage
//
//  Created by lanouhn on 15/7/28.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import "CollectionCellModel.h"
#import "URL.h"

@implementation CollectionCellModel

//-(void) objectForKey:(NSString*) str  {
//    
//    assert(NO); // 这里的assert(NO)是必须的，不允许该函数正常运行
//    
//}



- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        //内容文字
        [self setValuesForKeysWithDictionary:dic];
        //图片路径
        self.file_key = [NSString stringWithFormat:kCollectionImageAPI, dic[@"file"][@"key"]];
        //图片宽高
        self.width = dic[@"file"][@"width"];
        self.height = dic[@"file"][@"height"];
        self.username = dic[@"user"][@"username"];
        self.title = dic[@"board"][@"title"];
        
        //因为dic[@"user"][[@"avatar"不一定是字典,如果是字典,则取值,不是,则获取avatar的值. avatar = "http://head.xiaonei.com/photos/0/0/men_main.gif";
        
        if ([dic[@"user"][@"avatar"] isKindOfClass:[NSDictionary class]]) {
             self.avatarKey = [NSString stringWithFormat:kUserHeaderImageAPI,dic[@"user"][@"avatar"][@"key"]];
        } else {
            self.avatarKey = dic[@"user"][@"avatar"];
        }
        
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
