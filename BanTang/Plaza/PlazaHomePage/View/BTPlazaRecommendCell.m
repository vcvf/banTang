//
//  BTPlazaRecommendCell.m
//  BanTang
//
//  Created by guanli on 16/4/20.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTPlazaRecommendCell.h"

@implementation BTPlazaRecommendCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _imgV = [[UIImageView alloc]init];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        _imgV.layer.masksToBounds = YES;
        _imgV.backgroundColor = ItemBackgroundColor;
        [self.contentView addSubview:_imgV];
        
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)setCellInfoWithModal:(BTPlazaRecommendModal *)modal {
    [_imgV yy_setImageWithURL:[NSURL URLWithString:modal.mini_pic_url] options:YYWebImageOptionSetImageWithFadeAnimation];
}

@end
