//
//  ImageCollectionViewCell.h
//  OnePage
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionCellModel.h"

@interface ImageCollectionViewCell : UICollectionViewCell

- (void)configureCellWithModel:(CollectionCellModel *)model;

+ (CGFloat)calculateHeight:(CollectionCellModel *)model;
//调整高度
- (void)adjustSubviewsFrame:(CollectionCellModel *)model;
@end
