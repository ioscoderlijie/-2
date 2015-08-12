//
//  NetworkStatus.h
//  OnePage
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkStatus : NSObject
//判断当前的网络状态
+ (NSString *)networkingStatesFromStatebar;
@end
