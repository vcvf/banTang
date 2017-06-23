//
//  BTPlazaGrassCell.h
//  BanTang
//
//  Created by guanli on 16/5/6.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTPlazaGrassModal.h"

@interface BTPlazaGrassCell : UICollectionViewCell

@property (nonatomic, retain)UIImageView *imgVPic;
@property (nonatomic, retain)UIImageView *imgVTitle;
@property (nonatomic, retain)UILabel *labViews;
@property (nonatomic, retain)UILabel *labPosts;

- (void)setCellInfoWithModal:(BTPlazaGrassModal *)grassModal;

@end
