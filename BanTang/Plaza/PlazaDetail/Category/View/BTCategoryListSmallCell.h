//
//  BTCategoryListSmallCell.h
//  BanTang
//
//  Created by guanli on 16/4/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTCategoryListModal.h"

@interface BTCategoryListSmallCell : UICollectionViewCell

@property (nonatomic, retain)UIImageView *imgPic;
@property (nonatomic, retain)UIImageView *imgAvatar;
@property (nonatomic, retain)UILabel *labNickname;
@property (nonatomic, retain)UIImageView *imgLike;
@property (nonatomic, retain)UILabel *labLikeNum;
@property (nonatomic, retain)UILabel *labContent;

- (void)setCellInfoWithModal:(BTCategoryListModal *)modal;

@end
