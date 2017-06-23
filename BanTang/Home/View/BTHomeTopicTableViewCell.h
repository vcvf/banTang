//
//  BTHomeTopicTableViewCell.h
//  BanTang
//
//  Created by guanli on 16/4/18.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTHomeListModal.h"

@interface BTHomeTopicTableViewCell : UITableViewCell

@property (nonatomic,readonly, retain)UIImageView *imgV;
@property (nonatomic,readonly, retain)UILabel *labTitle;
@property (nonatomic,readonly, retain)UIImageView *imgLike;
@property (nonatomic,readonly, retain)UILabel *labLike;

- (void)setCellInfoWithModal:(BTHomeListModal *)modal;

@end
