//
//  SendValueTap.h
//  OnePage
//
//  Created by lanouhn on 15/7/30.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendValueTap : UITapGestureRecognizer
//添加一个属性,记录图片的地址
@property (copy, nonatomic) NSString *userInfo;

@property (strong, nonatomic) NSIndexPath *indexPath;
@end
