//
//  BTPlazaRecommendCell.h
//  BanTang
//
//  Created by guanli on 16/4/20.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTPlazaRecommendModal.h"

@interface BTPlazaRecommendCell : UICollectionViewCell

@property (nonatomic, retain)UIImageView *imgV;

- (void)setCellInfoWithModal:(BTPlazaRecommendModal *)modal;

@end
